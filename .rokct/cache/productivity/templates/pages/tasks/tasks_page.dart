// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:comms_sdk/comms_sdk.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:base_sdk/base_sdk.dart';
// The base barrel does not re-export the theme tokens, and section 44
// is drawn in them explicitly ("dark base tokens transcribed from
// app_style.dart") rather than in Theme.of(context).colorScheme.
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:productivity_sdk/productivity_sdk.dart';
import 'package:auto_route/auto_route.dart';
import 'dart:async';
import 'dart:math';

@RoutePage()
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TodoRepositoryFacade _repository;

  List<Map<String, dynamic>> _todos = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subtaskController = TextEditingController();
  // Section 46: a step may carry an instruction and a duration (minutes).
  final TextEditingController _subtaskInstructionController =
      TextEditingController();
  final TextEditingController _subtaskMinutesController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  DateTime? _selectedDeadline;
  bool _isReminderSet = false;
  String _selectedPriority = 'Medium';
  String _filterStatus = 'All'; // All, Pending, Completed
  String _sortBy = 'Created'; // Created, Deadline, Priority
  String _recurrence = 'None'; // None, Daily, Weekly, Monthly
  bool _showCalendar = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String? _editingId;

  /// Section 46: the task whose run holds the detail plane, if any.
  String? _runningId;

  /// Section 46: `stepsAreSequential` for the task being composed.
  bool _stepsInOrder = false;

  /// Section 47m: `isLongTerm` for the task being composed.
  bool _isLongTerm = false;

  /// Frame 44c: the objective link on the task being composed — the
  /// `Strategic Objective` name (the typed column the server keeps) and
  /// the title / pillar pair chip 833 reads, kept beside it because a
  /// Frappe name is a hash and the row has to say something.
  String? _strategicObjective;
  String? _strategicObjectiveTitle;
  String? _strategicObjectivePillar;

  /// Frame 44c: the objective picker (834) holds the last plane.
  bool _pickingObjective = false;

  /// The plan, read once per page through the productivity module's own
  /// `get_strategic_objectives` / `get_pillars` / `get_kpis`, on the first
  /// open of the picker. Never in front of anything: the picker draws a
  /// spinner, then the cards or the backend's own error.
  late final ObjectivesRepositoryFacade _objectives;
  ObjectiveCatalog? _objectiveCatalog;
  bool _objectivesLoading = false;
  String? _objectivesError;

  /// Section 47n: where each task stands with the server, by client id.
  /// Read from the outbox beside the list and redrawn as a badge; never
  /// waited on.
  Map<String, TaskSyncState> _syncStates = <String, TaskSyncState>{};

  /// Whether the last pull failed (`TaskPullService.lastFailure`). Read by
  /// the empty state and nowhere else: a list with rows in it says nothing
  /// about the backend, and this page never names a cmd or an error.
  bool _syncFailed = TaskPullService.syncFailed;

  String? _selectedCategory;
  List<Map<String, dynamic>> _currentSubtasks = [];

  final List<String> _priorities = ['Low', 'Medium', 'High'];
  final List<String> _recurrences = ['None', 'Daily', 'Weekly', 'Monthly'];
  // SUPERSEDED, NOT DELETED. `_sortOptions` fed the shipped
  // DropdownButton and `_getPriorityColor` (below) tinted the shipped
  // card; design strip section 44 replaced both — the sort values now
  // live in `TaskSort` (chip 827's segment) and the tint in
  // `taskPriorityColor` (chip 825). They are LEFT HERE deliberately
  // rather than removed: nothing in this pass was asked to delete
  // shipped code, and a later reader deciding they are genuinely dead
  // should be the one to say so.
  final List<String> _sortOptions = ['Created', 'Deadline', 'Priority'];
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _repository = TodoRepositoryImpl(AppDatabase());
    _objectives = const ObjectivesRepositoryImpl();
    _selectedDay = _focusedDay;
    _initNotifications();
    _loadTodos();
    TaskPullService.lastFailure.addListener(_onPullStatusChanged);
    // Sync runs BESIDE the page, never in front of it. The list above is
    // already being read from the local store; this asks the backend for
    // anything it knows that this device does not, and redraws only if the
    // answer actually changed something. Unawaited on purpose: there is no
    // spinner and no gate — a device with no network or no backend simply
    // never gets an answer. What the page DOES notice is a pull that
    // failed: `TaskPullService.lastFailure` is watched above, and the empty
    // state says one friendly line when the list is empty because of it.
    unawaited(_syncInBackground());
  }

  @override
  void dispose() {
    TaskPullService.lastFailure.removeListener(_onPullStatusChanged);
    super.dispose();
  }

  /// A pull completed or failed; redraw only if the answer changed.
  void _onPullStatusChanged() {
    final bool failed = TaskPullService.syncFailed;
    if (!mounted || failed == _syncFailed) return;
    setState(() => _syncFailed = failed);
  }

  /// Drains queued task pushes and pulls down whatever changed elsewhere.
  ///
  /// Nothing waits for this and nothing depends on it. `syncNow` never
  /// throws on an unreachable backend — the pull records its failure on
  /// `TaskPullService.lastFailure` and in telemetry instead — so the only
  /// visible effects it can have are MORE tasks appearing, or the empty
  /// state's one line when nothing came down because the pull failed.
  Future<void> _syncInBackground() async {
    final bool changed = await _repository.syncNow();
    if (!mounted) return;
    if (changed) {
      await _loadTodos();
    } else {
      // Nothing new came down, but pushes may have gone up: the badges
      // move from "this device" to "synced" on their own facts.
      await _refreshSyncStates();
    }
  }

  Future<void> _initNotifications() async {
    await LocalNotifications.initialize();
  }

  Future<void> _loadTodos() async {
    final todos = await _repository.loadTodos();
    if (mounted) {
      setState(() {
        _todos = todos;
      });
    }
    await _refreshSyncStates();
  }

  Future<void> _saveTodos() async {
    await _repository.saveTodos(_todos);
    // The save queued a push; the badge says so until the push lands.
    await _refreshSyncStates();
  }

  /// Section 47n — one query for the whole list. Local only, and never in
  /// front of anything: an unreadable outbox leaves every badge reading
  /// "this device", which is then the truth.
  Future<void> _refreshSyncStates() async {
    final Map<String, bool> byClientId = <String, bool>{
      for (final t in _todos)
        if ((t['clientId'] ?? '').toString().isNotEmpty)
          t['clientId'].toString(): (t['remoteId'] ?? '').toString().isNotEmpty,
    };
    final Map<String, TaskSyncState> states =
        await TaskSyncQueue.statesFor(byClientId);
    if (mounted) setState(() => _syncStates = states);
  }

  Future<void> _exportData() async {
    await _repository.exportTodos(_todos);
  }

  void _saveTask() {
    if (_controller.text.trim().isEmpty) return;

    final String title = _controller.text.trim();
    final String? deadlineStr = _selectedDeadline?.toIso8601String();
    final String? category = _categoryController.text.trim().isNotEmpty
        ? _categoryController.text.trim()
        : _selectedCategory;

    setState(() {
      if (_editingId != null) {
        // Updating existing by UUID
        final index = _todos.indexWhere((t) => t['id'] == _editingId);
        if (index != -1) {
          final String id = _editingId!;
          final int notifId =
              _todos[index]['notifId'] ?? Random().nextInt(100000);

          LocalNotifications.cancelNotification(notifId);

          // Spread the stored map first: the form does not show remindAt,
          // snoozeCount, reminderFired, the sync ids or the step
          // timestamps, and rebuilding the map from the form alone
          // silently dropped every one of them on each edit.
          _todos[index] = {
            ..._todos[index],
            'id': id,
            'notifId': notifId,
            'title': title,
            'isDone': _todos[index]['isDone'],
            'deadline': deadlineStr,
            'reminder': _isReminderSet,
            'priority': _selectedPriority,
            'category': category,
            'recurrence': _recurrence,
            'stepsAreSequential': _stepsInOrder,
            'isLongTerm': _isLongTerm,
            ..._objectiveLinkFields(existing: _todos[index]),
            'createdAt':
                _todos[index]['createdAt'] ?? DateTime.now().toIso8601String(),
            'subtasks': _currentSubtasks
                .map((s) => Map<String, dynamic>.from(s))
                .toList(),
          };

          if (_isReminderSet && _selectedDeadline != null) {
            LocalNotifications.scheduleNotification(
              id: notifId,
              title: 'Task Reminder',
              body: title,
              scheduledDate: _selectedDeadline!,
            );
          }
        }
        _editingId = null;
      } else {
        // Adding new
        final String id = _uuid.v4();
        final int notifId = Random().nextInt(100000);
        _todos.add({
          'id': id,
          'notifId': notifId,
          'title': title,
          'isDone': false,
          'deadline': deadlineStr,
          'reminder': _isReminderSet,
          'priority': _selectedPriority,
          'category': category,
          'recurrence': _recurrence,
          'stepsAreSequential': _stepsInOrder,
          'isLongTerm': _isLongTerm,
          ..._objectiveLinkFields(),
          'createdAt': DateTime.now().toIso8601String(),
          'subtasks': _currentSubtasks
              .map((s) => Map<String, dynamic>.from(s))
              .toList(),
        });

        if (_isReminderSet && _selectedDeadline != null) {
          LocalNotifications.scheduleNotification(
            id: notifId,
            title: 'Task Reminder',
            body: title,
            scheduledDate: _selectedDeadline!,
          );
        }
      }

      // Reset form
      _controller.clear();
      _categoryController.clear();
      _subtaskController.clear();
      _subtaskInstructionController.clear();
      _subtaskMinutesController.clear();
      _selectedDeadline = null;
      _isReminderSet = false;
      _selectedPriority = 'Medium';
      _recurrence = 'None';
      _stepsInOrder = false;
      _isLongTerm = false;
      _strategicObjective = null;
      _strategicObjectiveTitle = null;
      _strategicObjectivePillar = null;
      _pickingObjective = false;
      _selectedCategory = null;
      _currentSubtasks = [];
    });
    _saveTodos();
  }

  void _addSubtask() {
    if (_subtaskController.text.trim().isNotEmpty) {
      // Section 46: the step's instruction and duration. Minutes on the
      // form, seconds on the map and the wire; 0 is an untimed step.
      final String instruction = _subtaskInstructionController.text.trim();
      final int minutes =
          int.tryParse(_subtaskMinutesController.text.trim()) ?? 0;
      setState(() {
        _currentSubtasks.add({
          'title': _subtaskController.text.trim(),
          'isDone': false,
          if (instruction.isNotEmpty) 'instruction': instruction,
          'durationSeconds': minutes < 0 ? 0 : minutes * 60,
        });
        _subtaskController.clear();
        _subtaskInstructionController.clear();
        _subtaskMinutesController.clear();
      });
    }
  }

  void _toggleSubtaskStatus(int taskIndex, int subtaskIndex) {
    setState(() {
      final subtasks = List<Map<String, dynamic>>.from(
        _todos[taskIndex]['subtasks'] ?? [],
      );
      subtasks[subtaskIndex]['isDone'] =
          !(subtasks[subtaskIndex]['isDone'] ?? false);
      _todos[taskIndex]['subtasks'] = subtasks;
    });
    _saveTodos();
  }

  void _toggleFormSubtaskStatus(int subtaskIndex) {
    setState(() {
      _currentSubtasks[subtaskIndex]['isDone'] =
          !(_currentSubtasks[subtaskIndex]['isDone'] ?? false);
    });
  }

  void _startEditing(int index) {
    setState(() {
      final task = _todos[index];
      _editingId = task['id'];
      _controller.text = task['title'];
      _selectedPriority = task['priority'] ?? 'Medium';
      _isReminderSet = task['reminder'] ?? false;
      _recurrence = task['recurrence'] ?? 'None';
      _stepsInOrder = task['stepsAreSequential'] == true;
      _isLongTerm = task['isLongTerm'] == true;
      _strategicObjective = _linkText(task['strategicObjective']);
      _strategicObjectiveTitle = _linkText(task['strategicObjectiveTitle']);
      _strategicObjectivePillar = _linkText(task['strategicObjectivePillar']);
      _pickingObjective = false;
      _selectedCategory = task['category'];
      _categoryController.text = task['category'] ?? '';

      // Deep Copy Subtasks
      if (task['subtasks'] != null) {
        _currentSubtasks = (task['subtasks'] as List)
            .map((s) => Map<String, dynamic>.from(s))
            .toList();
      } else {
        _currentSubtasks = [];
      }

      if (task['deadline'] != null) {
        _selectedDeadline = DateTime.parse(task['deadline']);
      } else {
        _selectedDeadline = null;
      }
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingId = null;
      _controller.clear();
      _categoryController.clear();
      _subtaskController.clear();
      _subtaskInstructionController.clear();
      _subtaskMinutesController.clear();
      _selectedDeadline = null;
      _isReminderSet = false;
      _selectedPriority = 'Medium';
      _recurrence = 'None';
      _stepsInOrder = false;
      _isLongTerm = false;
      _strategicObjective = null;
      _strategicObjectiveTitle = null;
      _strategicObjectivePillar = null;
      _pickingObjective = false;
      _selectedCategory = null;
      _currentSubtasks = [];
    });
  }

  void _handleRecurrence(Map<String, dynamic> task) {
    final String recurrence = task['recurrence'] ?? 'None';
    if (recurrence == 'None' || task['deadline'] == null) return;

    final DateTime currentDeadline = DateTime.parse(task['deadline']);
    DateTime nextDeadline;

    if (recurrence == 'Daily') {
      nextDeadline = currentDeadline.add(const Duration(days: 1));
    } else if (recurrence == 'Weekly') {
      nextDeadline = currentDeadline.add(const Duration(days: 7));
    } else if (recurrence == 'Monthly') {
      nextDeadline = DateTime(
        currentDeadline.year,
        currentDeadline.month + 1,
        currentDeadline.day,
        currentDeadline.hour,
        currentDeadline.minute,
      );
    } else {
      return;
    }

    final String newId = _uuid.v4();
    final int notifId = Random().nextInt(100000);
    final bool hasReminder = task['reminder'] ?? false;

    _todos.add({
      'id': newId,
      'notifId': notifId,
      'title': task['title'],
      'isDone': false,
      'deadline': nextDeadline.toIso8601String(),
      'reminder': hasReminder,
      'priority': task['priority'],
      'category': task['category'],
      'recurrence': recurrence,
      'createdAt': DateTime.now().toIso8601String(),
      'stepsAreSequential': task['stepsAreSequential'] == true,
      'isLongTerm': task['isLongTerm'] == true,
      // Frame 44c: the objective is part of the procedure, not of the
      // progress — the next instance serves the same objective.
      if (task.containsKey('strategicObjective')) ...<String, dynamic>{
        'strategicObjective': task['strategicObjective'],
        'strategicObjectiveTitle': task['strategicObjectiveTitle'],
        'strategicObjectivePillar': task['strategicObjectivePillar'],
      },
      // The next instance starts with the PROCEDURE (title, instruction,
      // duration) and none of the run's progress: isDone cleared as
      // before, and the step timestamps with it.
      'subtasks':
          (task['subtasks'] as List?)
              ?.map((s) => TaskRunStep.freshCopy(Map<String, dynamic>.from(s)))
              .toList() ??
          [],
    });

    if (hasReminder) {
      LocalNotifications.scheduleNotification(
        id: notifId,
        title: 'Task Reminder',
        body: task['title'],
        scheduledDate: nextDeadline,
      );
    }
  }

  void _toggleTodo(int index) {
    final int notifId = _todos[index]['notifId'] ?? Random().nextInt(100000);

    setState(() {
      _todos[index]['isDone'] = !_todos[index]['isDone'];

      if (_todos[index]['isDone']) {
        LocalNotifications.cancelNotification(notifId);
        _handleRecurrence(_todos[index]);
      } else {
        final bool hasReminder = _todos[index]['reminder'] ?? false;
        final String? deadlineStr = _todos[index]['deadline'];
        if (hasReminder && deadlineStr != null) {
          final DateTime deadlineDate = DateTime.parse(deadlineStr);
          if (deadlineDate.isAfter(DateTime.now())) {
            LocalNotifications.scheduleNotification(
              id: notifId,
              title: 'Task Reminder',
              body: _todos[index]['title'],
              scheduledDate: deadlineDate,
            );
          }
        }
      }
    });
    _saveTodos();
  }

  void _removeTodo(int index) {
    LocalNotifications.cancelNotification(_todos[index]['notifId'] ?? 0);

    // Take the id before the map leaves the list: the row has to be deleted
    // by name. saveTodos only inserts and updates, so dropping the task from
    // _todos alone left the row behind and the task came back on the next
    // start. Pruning inside the save instead would be worse - this table has
    // another writer, and a save that deleted every row absent from this
    // list would delete that writer's rows too.
    final String id = (_todos[index]['id'] ?? '').toString();

    setState(() {
      _todos.removeAt(index);
    });
    _deleteTodo(id);
  }

  Future<void> _deleteTodo(String id) async {
    await _repository.deleteTodo(id);
  }

  Future<void> _pickDeadline() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedDeadline != null
            ? TimeOfDay.fromDateTime(_selectedDeadline!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null && mounted) {
        setState(() {
          _selectedDeadline = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Color _getPriorityColor(String priority, ColorScheme colors) {
    switch (priority) {
      case 'High':
        return colors.error;
      case 'Medium':
        return colors.primary;
      case 'Low':
        return Colors.green;
      default:
        return colors.primary;
    }
  }

  int _priorityWeight(String priority) {
    if (priority == 'High') return 3;
    if (priority == 'Medium') return 2;
    return 1;
  }

  List<MapEntry<int, Map<String, dynamic>>> _getFilteredAndSortedTodos() {
    // 1. Filter
    var filtered = _todos.asMap().entries.where((entry) {
      final todo = entry.value;
      if (_filterStatus == 'Pending' && todo['isDone'] == true) return false;
      if (_filterStatus == 'Completed' && todo['isDone'] == false) return false;

      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        final title = (todo['title'] as String).toLowerCase();
        final cat = (todo['category'] as String?)?.toLowerCase() ?? '';
        if (!title.contains(query) && !cat.contains(query)) return false;
      }

      if (_showCalendar && _selectedDay != null) {
        final deadlineStr = todo['deadline'] as String?;
        if (deadlineStr == null) return false;
        final dDate = DateTime.parse(deadlineStr);
        if (!isSameDay(dDate, _selectedDay)) return false;
      }

      return true;
    }).toList();

    // 2. Sort
    filtered.sort((a, b) {
      final ta = a.value;
      final tb = b.value;

      if (_sortBy == 'Priority') {
        final wa = _priorityWeight(ta['priority'] ?? 'Medium');
        final wb = _priorityWeight(tb['priority'] ?? 'Medium');
        if (wa != wb) return wb.compareTo(wa); // Descending
      } else if (_sortBy == 'Deadline') {
        final daStr = ta['deadline'] as String?;
        final dbStr = tb['deadline'] as String?;
        if (daStr != null && dbStr != null) {
          return DateTime.parse(daStr).compareTo(DateTime.parse(dbStr));
        } else if (daStr != null) {
          return -1;
        } else if (dbStr != null) {
          return 1;
        }
      }

      // Default fallback to Created
      final caStr = ta['createdAt'] as String?;
      final cbStr = tb['createdAt'] as String?;
      if (caStr != null && cbStr != null) {
        return DateTime.parse(
          cbStr,
        ).compareTo(DateTime.parse(caStr)); // Newest first
      }
      return 0;
    });

    return filtered;
  }

  // ===================================================================
  // DESIGN STRIP SECTION 44 — the /tasks workspace.
  //
  // The page was BUILT and the screen was never designed; this is that
  // design pass, applied to the settled plane language. Frames 44a
  // (list · detail), 44b (the compose lane), 44d (the phone fold) and
  // 44e (calendar mode) are all states of this one composition.
  //
  // NO FIELD IS ADDED AND NONE IS REMOVED. Every handler above this
  // line is the shipped one, untouched: _saveTask, _startEditing,
  // _cancelEditing, _toggleTodo, _removeTodo, _addSubtask,
  // _toggleSubtaskStatus, _toggleFormSubtaskStatus, _handleRecurrence,
  // _pickDeadline, _exportData and _getFilteredAndSortedTodos. What
  // changed is where things are drawn, not what they do.
  //
  // THE PLANE CLAIM, AND THE FORK THIS FILE CLOSES. Frame 44a's own
  // stamp reads "/tasks DECLARES 2 — HUB YIELDS TO 1", while section 7e
  // had drawn /tasks landing in the bare trailing plane (a claim of
  // one). The frame calls that "a choice, not a defect" and asks for it
  // to be made explicitly rather than inherited. THIS FILE PICKS TWO,
  // on 44a's stamp: the list keeps its planes and the detail or compose
  // pane pushes into the LAST one, which is the whole point of 44b —
  // the shipped page wedged the compose form ABOVE the list, five
  // Expanded rows of chips and dropdowns competing with the list for
  // the same column.
  //
  // The mechanism is base_sdk's PlaneHost — the section 38 list flow
  // ListPlaneFlow wraps, spelled out here because frame 44c pushes a
  // THIRD step (the objective picker) that the wrapper cannot express.
  // The list still declares two, and the corner back pill (canonical
  // 347) is raised only while a pane is open.
  //
  // TWO FLAGS RIDE THIS SCREEN AND ARE DRAWN, NOT HIDDEN. A THIRD IS
  // GONE:
  //   (a) WAS "these tasks live on this device only — no remote store,
  //       no sync", drawn by the local-only strip (828) above the first
  //       card. It is no longer true and the strip is no longer drawn:
  //       the workspace now syncs against the personal-task endpoints
  //       in `projects/frappe/src/task_sync.py` through the SyncEngine
  //       outbox. The local store is still the source of truth for
  //       every read on this page and every write still lands there
  //       first, so a device with no backend behaves exactly as it did
  //       when the strip was accurate — that part did not change, and
  //       must not.
  //   (b) `recurrence` is stored and NOTHING ever acts on it: no
  //       scheduler, no rollover, no next-instance creation anywhere in
  //       the SDK. A task marked Daily is a label. The REPEATS quad is
  //       drawn because the field is real.
  //   (c) the reminder toggle promises a LOCAL notification at the
  //       deadline and nothing more.
  // ===================================================================

  /// FRAME 44d — the fold. On one plane the detail pane has no phone
  /// form of its own: the first card expands IN PLACE, which is the
  /// shipped ExpansionTile behaviour kept, so the subtask check lines
  /// still reach the phone rather than becoming a second push.
  bool _isSinglePlane(BuildContext context) =>
      ListPlaneColumns.columnsOf(context) < 2;

  /// The task whose card is expanded on the phone fold.
  String? _expandedId;

  TaskStatusFilter get _statusFilter => switch (_filterStatus) {
        'Pending' => TaskStatusFilter.pending,
        'Completed' => TaskStatusFilter.completed,
        _ => TaskStatusFilter.all,
      };

  TaskSort get _sort => switch (_sortBy) {
        'Deadline' => TaskSort.deadline,
        'Priority' => TaskSort.priority,
        _ => TaskSort.created,
      };

  /// The tab counts, DERIVED from the same list the tabs filter — there
  /// is no count field to read.
  Map<TaskStatusFilter, int> get _statusCounts => {
        TaskStatusFilter.all: _todos.length,
        TaskStatusFilter.pending:
            _todos.where((t) => t['isDone'] != true).length,
        TaskStatusFilter.completed:
            _todos.where((t) => t['isDone'] == true).length,
      };

  @override
  Widget build(BuildContext context) {
    final String? runningId = _runningId;
    final String? detailName = runningId != null
        ? 'run-$runningId'
        : _editingId ?? (_paneOpen ? 'compose' : null);
    final WidgetBuilder? detailBuilder = runningId != null
        ? (context) => _runPane(context, runningId)
        : _paneOpen
        ? (context) => _composePane(context)
        : null;
    // The section-38 list flow, spelled out as the PlaneHost stack
    // ListPlaneFlow builds — same page names, same corner Back (347) —
    // because FRAME 44c pushes a THIRD step: the objective picker (834)
    // is a 1-plane push that wins the last plane, and "newest wins" then
    // slides list + detail left (the detail compresses into plane 2, the
    // list into plane 1). ListPlaneFlow carries exactly one detail and
    // cannot express that push; PlaneHost is what it wraps.
    return PlaneHost(
      back: FloatingNavBack(
        icon: Icons.arrow_back,
        label: AppHelpers.getTranslation(TrKeys.back),
        // The pill pops the NEWEST step: the picker while it is open,
        // else the detail / compose / run pane.
        onTap: _popPlane,
      ),
      stack: [
        PlanePage(name: 'list', span: PlaneSpan.two, builder: _listPlane),
        if (detailBuilder != null)
          PlanePage(name: 'list-detail-${detailName ?? ''}', builder: detailBuilder),
        if (detailBuilder != null && _pickingObjective && runningId == null)
          PlanePage(name: 'objective-picker', builder: _objectivePickerPane),
      ],
    );
  }

  /// Canonical 347 — back pops one step.
  void _popPlane() {
    if (_pickingObjective) {
      setState(() => _pickingObjective = false);
      return;
    }
    _closePane();
  }

  /// True while the last plane is carrying something — an edit (the
  /// detail pane, 829), a new task (the compose lane, 830), or a run
  /// (section 46). Create and edit are ONE component with an empty
  /// model, exactly as the shipped page already treats them via
  /// `_editingId`.
  bool get _paneOpen => _editingId != null || _composing || _runningId != null;

  bool _composing = false;

  void _openCompose() {
    _cancelEditing();
    setState(() {
      _composing = true;
      _runningId = null;
    });
  }

  void _closePane() {
    _cancelEditing();
    setState(() {
      _composing = false;
      _runningId = null;
    });
  }

  // ===================================================================
  // DESIGN STRIP FRAME 44c — the M2 bridge, hosted here.
  //
  // Chip 833 (the link row in the detail pane) opens chip 834 (the
  // picker) as a further push with the default 1-plane claim. The plan
  // is read through the productivity module's own get_* endpoints; the
  // link is written onto the TASK MAP as `strategicObjective` and
  // travels through the existing `task.upsert` op to Task's typed
  // `strategic_objective` column. Nothing here can reach commit_plan.
  //
  // For a task being EDITED, Link objective writes at once — the row is
  // already a saved task and the link is a fact about it. For a task
  // being COMPOSED, the link waits on Save task with every other field.
  // ===================================================================

  static String? _linkText(Object? value) {
    final String text = (value ?? '').toString().trim();
    return text.isEmpty ? null : text;
  }

  /// The link as it goes onto the task map.
  ///
  /// Absent is silence: a task that never had a link gets NO key, so the
  /// sync never mentions the column. A key present with null is an
  /// UNLINK — the wire sends the empty string that clears the column —
  /// which is why a task that had one keeps the key when it is removed.
  Map<String, dynamic> _objectiveLinkFields({Map<String, dynamic>? existing}) {
    final bool had = existing?.containsKey('strategicObjective') ?? false;
    if (_strategicObjective == null && !had) return const <String, dynamic>{};
    return <String, dynamic>{
      'strategicObjective': _strategicObjective,
      'strategicObjectiveTitle': _strategicObjectiveTitle,
      'strategicObjectivePillar': _strategicObjectivePillar,
    };
  }

  /// Chip 833 — open the picker. Reads the plan on the first open.
  void _openObjectivePicker() {
    setState(() => _pickingObjective = true);
    if (_objectiveCatalog == null && !_objectivesLoading) {
      unawaited(_loadObjectives());
    }
  }

  Future<void> _loadObjectives() async {
    setState(() {
      _objectivesLoading = true;
      _objectivesError = null;
    });
    final ApiResult<ObjectiveCatalog> result = await _objectives.loadCatalog();
    if (!mounted) return;
    setState(() {
      _objectivesLoading = false;
      switch (result) {
        case Success<ObjectiveCatalog>(:final data):
          _objectiveCatalog = data;
        case Failure<ObjectiveCatalog>(:final error):
          _objectivesError = error;
      }
    });
  }

  /// Chip 834's Link objective (or its clear, for null): the link lands
  /// on the form, and — for a saved task — on the task map and the store.
  void _applyObjectiveLink(StrategicObjective? objective) {
    final Pillar? pillar = _objectiveCatalog?.pillarNamed(objective?.pillar);
    setState(() {
      _strategicObjective = objective?.name;
      _strategicObjectiveTitle = objective?.title;
      _strategicObjectivePillar = pillar?.title;
      _pickingObjective = false;
      final String? id = _editingId;
      if (id != null) {
        final int index = _todos.indexWhere((t) => t['id'] == id);
        if (index != -1) {
          _todos[index] = <String, dynamic>{
            ..._todos[index],
            ..._objectiveLinkFields(existing: _todos[index]),
          };
        }
      }
    });
    if (_editingId != null) _saveTodos();
  }

  /// The task being composed, as chip 833 reads it: only the link fields
  /// matter to the row, and they come off the form state.
  TaskViewModel get _composedTask => TaskViewModel(
        id: _editingId ?? '',
        title: _controller.text,
        strategicObjective: _strategicObjective,
        strategicObjectiveTitle: _strategicObjectiveTitle,
        strategicObjectivePillar: _strategicObjectivePillar,
      );

  /// PLANE 3 (the LAST plane) — chip 834, the objective picker.
  Widget _objectivePickerPane(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.transparent,
      body: SafeArea(
        child: ObjectivePickerPane(
          key: const ValueKey<String>('objective-picker'),
          catalog: _objectiveCatalog,
          loading: _objectivesLoading,
          error: _objectivesError,
          initialSelection: _strategicObjective,
          onCancel: () => setState(() => _pickingObjective = false),
          onLink: _applyObjectiveLink,
          onRetry: _loadObjectives,
        ),
      ),
    );
  }

  // ===================================================================
  // DESIGN STRIP SECTION 46 — the guided run, hosted here.
  //
  // FRAME 46a: "the run is 44a's detail plane — no new push". On a wide
  // window the run takes the LAST plane exactly as the compose lane
  // does, so it claims no new plane and the corner Back (347) still pops
  // /tasks back to the hub. FRAME 46f: at one plane there is no detail
  // plane to land in, so the phone pushes the /tasks/run route with the
  // same view filling the screen.
  //
  // THE PAGE OWNS NO RUN STATE. TaskRunView derives everything from the
  // task map and hands the map back with progress written onto it; this
  // page puts it in the list and saves it the way it saves everything —
  // drift first, the outbox push unawaited behind it.
  // ===================================================================

  /// Chip 859 — open a task's run. The run pill on the card leads here.
  Future<void> _openRun(int index) async {
    final Map<String, dynamic> task = _todos[index];
    final String id = '${task['id'] ?? ''}';
    if (id.isEmpty) return;
    if (!_isSinglePlane(context)) {
      _cancelEditing();
      setState(() {
        _composing = false;
        _runningId = id;
      });
      return;
    }
    // The pushed page persists through the same repository; reload on
    // return so the badge on the card reads the run's new position, and
    // tick the task when the finished card asked for it.
    final Object? result = await context.router.pushNamed(
      '/tasks/run?task=$id',
    );
    if (!mounted) return;
    await _loadTodos();
    if (result == true) {
      final int again = _todos.indexWhere((t) => t['id'] == id);
      if (again != -1 && _todos[again]['isDone'] != true) _toggleTodo(again);
    }
  }

  /// The run wrote progress onto its task: put the map back and save.
  void _onRunChanged(Map<String, dynamic> task) {
    final int index = _todos.indexWhere((t) => t['id'] == task['id']);
    if (index == -1) return;
    setState(() => _todos[index] = task);
    _saveTodos();
  }

  /// PLANE 3 (the LAST plane) — the run, in place of the static detail.
  Widget _runPane(BuildContext context, String id) {
    final int index = _todos.indexWhere((t) => t['id'] == id);
    if (index == -1) {
      return const SizedBox.shrink();
    }
    final Map<String, dynamic> task = _todos[index];
    return Scaffold(
      backgroundColor: AppStyle.transparent,
      body: SafeArea(
        child: TaskRunView(
          key: ValueKey<String>('run-$id'),
          task: task,
          onChanged: _onRunChanged,
          // Chip 866 — Leave, progress kept: nothing is written on the
          // way out, and the corner pill (347) does the same.
          onLeave: _closePane,
          onMarkDone: () {
            final int again = _todos.indexWhere((t) => t['id'] == id);
            if (again != -1 && _todos[again]['isDone'] != true) {
              _toggleTodo(again);
            }
            _closePane();
          },
        ),
      ),
    );
  }

  /// The words on a card's run pill: "Run" for an untouched run, else
  /// where it stopped — "Resume · Step 3 of 9" — unless that run is the
  /// one open in the plane right now, where "Resume" would be wrong.
  String _runLabelFor(TaskViewModel task) {
    final TaskRun run = task.run;
    final String? position = run.positionLabel;
    if (position == null) return 'Run';
    return task.id == _runningId ? position : 'Resume · $position';
  }

  // ===================================================================
  // DESIGN STRIP SECTION 47 — snooze (47k / 47l), the long-term band
  // (47m) and the sync-state badge (47n). Properties of THE TASK, every
  // task; no vertical has a privilege here.
  // ===================================================================

  /// CHIPS 1060 / 1062 — snooze this task's reminder. The sheet hands
  /// back a reminder time and nothing else; `snoozeReminder` writes it
  /// and NEVER the deadline; the device-local notification moves with it
  /// (47n: it reminds on this device until the push lands).
  Future<void> _snooze(int index) async {
    final Map<String, dynamic> todo = _todos[index];
    final TaskViewModel task = TaskViewModel.fromMap(todo);
    final DateTime? remindAt = await showSnoozeSheet(context, task: task);
    if (remindAt == null || !mounted) return;
    final bool applied = await _repository.snoozeReminder(task.id, remindAt);
    if (!applied || !mounted) return;
    final int notifId = todo['notifId'] ?? Random().nextInt(100000);
    LocalNotifications.cancelNotification(notifId);
    LocalNotifications.scheduleNotification(
      id: notifId,
      title: 'Task Reminder',
      body: task.title,
      scheduledDate: remindAt,
    );
    unawaited(
      TelemetryClient.I.track(
        'task_reminder_snoozed',
        properties: <String, dynamic>{
          'minutes_ahead': remindAt.difference(DateTime.now()).inMinutes,
          'snooze_count': task.snoozeCount + 1,
        },
      ),
    );
    // The repository wrote the row; read it back rather than guessing at
    // what it holds now.
    await _loadTodos();
  }

  /// CHIP 1064 — the day's list, split into the long-term band and the
  /// rest. Both halves keep the filter and sort the list already has.
  ({List<MapEntry<int, Map<String, dynamic>>> longTerm,
  List<MapEntry<int, Map<String, dynamic>>> rest})
  _banded(List<MapEntry<int, Map<String, dynamic>>> displayed) {
    final longTerm = <MapEntry<int, Map<String, dynamic>>>[];
    final rest = <MapEntry<int, Map<String, dynamic>>>[];
    for (final entry in displayed) {
      (entry.value['isLongTerm'] == true ? longTerm : rest).add(entry);
    }
    return (longTerm: longTerm, rest: rest);
  }

  // -------------------------------------------------------------- list

  /// PLANE 1–2 — the task list in the section-33 list language.
  Widget _listPlane(BuildContext context) {
    final displayedTodos = _getFilteredAndSortedTodos();
    final singlePlane = _isSinglePlane(context);

    return Scaffold(
      backgroundColor: AppStyle.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: _openCompose,
        backgroundColor: AppStyle.primary,
        foregroundColor: AppStyle.blackColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.verticalSpace,
              // CANONICAL 700 — header and count pill, carrying the two
              // header utilities: 832 calendar mode and 835 Backup.
              TaskListHeader(
                title: 'Tasks',
                count: displayedTodos.length,
                actions: [
                  _headerAction(
                    icon: _showCalendar ? Icons.list : Icons.calendar_month,
                    tooltip: 'Calendar mode',
                    onTap: () => setState(() => _showCalendar = !_showCalendar),
                  ),
                  // CHIP 835 — the only way a task leaves the device
                  // (flag a). Kept in the header on every frame.
                  _headerAction(
                    icon: Icons.download,
                    tooltip: 'Backup',
                    onTap: _exportData,
                  ),
                ],
              ),
              10.verticalSpace,
              _searchField(),
              10.verticalSpace,
              // CANONICAL 362 / 363 — the status tabs, re-dressing the
              // shipped ChoiceChip row.
              TaskStatusTabs(
                active: _statusFilter,
                counts: _statusCounts,
                onChanged: (filter) => setState(() {
                  _filterStatus = switch (filter) {
                    TaskStatusFilter.pending => 'Pending',
                    TaskStatusFilter.completed => 'Completed',
                    TaskStatusFilter.all => 'All',
                  };
                }),
              ),
              10.verticalSpace,
              Align(
                alignment: AlignmentDirectional.centerStart,
                // CHIP 827 — the sort segment. Promoted from the shipped
                // DropdownButton because there are only three values and
                // a dropdown hides two of them behind a tap.
                child: TaskSortSegment(
                  active: _sort,
                  onChanged: (sort) => setState(() {
                    _sortBy = switch (sort) {
                      TaskSort.deadline => 'Deadline',
                      TaskSort.priority => 'Priority',
                      TaskSort.created => 'Created',
                    };
                  }),
                ),
              ),
              12.verticalSpace,
              if (_showCalendar) ...[
                _calendar(),
                12.verticalSpace,
              ],
              Expanded(
                child: displayedTodos.isEmpty
                    ? _emptyList()
                    : Builder(
                        builder: (context) {
                          // CHIP 1064 — the long-term band sits above
                          // the day's work; the rest keep their list.
                          final banded = _banded(displayedTodos);
                          final rows = <Widget>[
                            if (banded.longTerm.isNotEmpty) ...[
                              LongTermBandHeader(
                                count: banded.longTerm.length,
                              ),
                              for (final entry in banded.longTerm) ...[
                                _card(entry.key, entry.value, singlePlane),
                                8.verticalSpace,
                              ],
                              if (banded.rest.isNotEmpty) ...[
                                4.verticalSpace,
                                _bandLabel('EVERYTHING ELSE'),
                              ],
                            ],
                            for (var i = 0; i < banded.rest.length; i++) ...[
                              if (i > 0) 8.verticalSpace,
                              _card(
                                banded.rest[i].key,
                                banded.rest[i].value,
                                singlePlane,
                              ),
                            ],
                          ];
                          return ListView(
                            padding: EdgeInsets.only(bottom: 88.h),
                            children: rows,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// One card of the list, with everything sections 44, 46 and 47 hang
  /// on it. [originalIndex] is the task's index in `_todos`.
  Widget _card(int originalIndex, Map<String, dynamic> todo, bool singlePlane) {
    final task = TaskViewModel.fromMap(todo);
    final String clientId = (todo['clientId'] ?? '').toString();
    return TaskCard(
      task: task,
      selected: _editingId == task.id || _runningId == task.id,
      // CHIP 859 — the run pill, for a task with steps that is not done.
      onRun: task.hasSubtasks && !task.isDone
          ? () => _openRun(originalIndex)
          : null,
      runLabel: _runLabelFor(task),
      // CHIPS 1066 / 1067 / 1068 — where the task stands with the server.
      syncState: clientId.isEmpty
          ? TaskSyncState.thisDevice
          : _syncStates[clientId] ?? TaskSyncState.thisDevice,
      // CHIP 1060 — snooze, on the expanded card at the fold.
      onSnooze: task.hasReminder && !task.isDone
          ? () => _snooze(originalIndex)
          : null,
      // FRAME 44d: on one plane the card expands in place instead of
      // pushing a pane.
      expanded: singlePlane && _expandedId == task.id,
      onToggleDone: () => _toggleTodo(originalIndex),
      onTap: () => singlePlane
          ? setState(
              () => _expandedId = _expandedId == task.id ? null : task.id,
            )
          : _startEditing(originalIndex),
      onToggleSubtask: (i) => _toggleSubtaskStatus(originalIndex, i),
    );
  }

  Widget _bandLabel(String label) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          label,
          style: AppStyle.interNormal(
            size: 11,
            color: AppStyle.textDarkFaint,
            letterSpacing: 0.8,
          ),
        ),
      );

  Widget _headerAction({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      iconSize: 20.r,
      color: AppStyle.textDarkSecondary,
      icon: Icon(icon),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      style: AppStyle.interNormal(size: 13, color: AppStyle.textPrimary),
      decoration: InputDecoration(
        hintText: 'Search tasks or categories...',
        hintStyle:
            AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
        prefixIcon: Icon(Icons.search, size: 18.r),
        filled: true,
        fillColor: AppStyle.cardDarkAlt,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _emptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nothing here yet.',
            style: AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
          ),
          // The one line about a failed pull. `_todos`, not the filtered
          // view: a filter that hides every row is not an empty list, and
          // the notice draws nothing unless the LOCAL list is empty AND
          // the last pull failed.
          TaskSyncNotice(
            localListEmpty: _todos.isEmpty,
            lastPullFailed: _syncFailed,
          ),
        ],
      ),
    );
  }

  /// FRAME 44e — calendar mode, a MODE OF THE LIST PLANE rather than a
  /// screen of its own, re-dressed in base tokens: today ringed in
  /// primary, the selected day filled primary, and a primary dot under
  /// any day a local task's `deadline` lands on.
  ///
  /// THE DAY DOT IS A REAL MARKER — derived from local rows and nothing
  /// more. Flag (a) is unchanged by the mode: the days being marked are
  /// local rows.
  Widget _calendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020),
      lastDay: DateTime.utc(2035, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selected, focused) => setState(() {
        _selectedDay = isSameDay(_selectedDay, selected) ? null : selected;
        _focusedDay = focused;
      }),
      eventLoader: (day) => _todos.where((t) {
        final deadline = t['deadline'] as String?;
        if (deadline == null) return false;
        final parsed = DateTime.tryParse(deadline);
        return parsed != null && isSameDay(parsed, day);
      }).toList(),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle:
            AppStyle.interSemi(size: 14, color: AppStyle.textPrimary),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: AppStyle.interNormal(
          size: 11,
          color: AppStyle.textDarkFaint,
        ),
        weekendStyle: AppStyle.interNormal(
          size: 11,
          color: AppStyle.textDarkFaint,
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle:
            AppStyle.interNormal(size: 12, color: AppStyle.textPrimary),
        weekendTextStyle:
            AppStyle.interNormal(size: 12, color: AppStyle.textPrimary),
        outsideTextStyle:
            AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppStyle.primary),
        ),
        todayTextStyle:
            AppStyle.interSemi(size: 12, color: AppStyle.textPrimary),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppStyle.primary,
        ),
        selectedTextStyle:
            AppStyle.interSemi(size: 12, color: AppStyle.blackColor),
        markerDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppStyle.primary,
        ),
        markersMaxCount: 1,
      ),
    );
  }

  // ----------------------------------------------------- compose plane

  /// PLANE 3 (the LAST plane) — frame 44b's compose lane and frame 44a's
  /// detail pane, which are ONE component with an empty model.
  ///
  /// GIVING IT THE LAST PLANE IS THE WHOLE CHANGE. The shipped page
  /// built all of this as an inline form wedged ABOVE the list; here the
  /// list keeps its planes and stays legible while you type.
  Widget _composePane(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView(
            padding: EdgeInsets.only(top: 12.h, bottom: 88.h),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _editingId == null ? 'New task' : 'Task',
                      style: AppStyle.interSemi(
                        size: 18,
                        color: AppStyle.textPrimary,
                      ),
                    ),
                  ),
                  // The only state the pane adds.
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppStyle.strokeDark),
                    ),
                    child: Text(
                      'unsaved',
                      style: AppStyle.interNormal(
                        size: 11,
                        color: AppStyle.textDarkFaint,
                      ),
                    ),
                  ),
                ],
              ),
              14.verticalSpace,
              _fieldLabel('TITLE'),
              _textField(_controller, 'What needs doing?'),
              14.verticalSpace,
              _fieldLabel('PRIORITY'),
              _priorityTriple(),
              14.verticalSpace,
              _fieldLabel('DEADLINE'),
              _deadlineRow(),
              14.verticalSpace,
              _fieldLabel('CATEGORY'),
              _textField(_categoryController, 'Plant, admin, errand…'),
              14.verticalSpace,
              // FLAG (b) — drawn because the field is real; it is
              // flagged because nothing ever acts on it.
              _fieldLabel('REPEATS'),
              _recurrenceQuad(),
              14.verticalSpace,
              // FLAG (c) — a local notification at the deadline, and
              // nothing more. The sub-line says exactly that.
              _reminderToggle(),
              // CHIPS 1061 / 1060 — for a saved task with a reminder, the
              // two clocks and the snooze control, right under the toggle
              // that made the reminder.
              if (_editingId != null) ..._editingReminderRow(),
              14.verticalSpace,
              // CHIP 1064 — the long-term band is a property of the task.
              _longTermToggle(),
              14.verticalSpace,
              _fieldLabel('STEPS'),
              // Section 46: the order rule. Off is today's any-order
              // checklist; on, a run opens the steps one at a time.
              _stepsInOrderToggle(),
              8.verticalSpace,
              for (var i = 0; i < _currentSubtasks.length; i++)
                SubtaskCheckLine(
                  subtask: SubtaskViewModel.fromMap(_currentSubtasks[i]),
                  onToggle: () => _toggleFormSubtaskStatus(i),
                  onRemove: () =>
                      setState(() => _currentSubtasks.removeAt(i)),
                ),
              8.verticalSpace,
              _subtaskComposer(),
              14.verticalSpace,
              // CHIP 833 — the M2 link row: what objective of the plan
              // this task serves, and the door to the picker (834).
              _fieldLabel('OBJECTIVE'),
              ObjectiveLinkRow(
                task: _composedTask,
                onTap: _openObjectivePicker,
                onClear: _strategicObjective == null
                    ? null
                    : () => _applyObjectiveLink(null),
              ),
              20.verticalSpace,
              _paneActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          label,
          style: AppStyle.interNormal(
            size: 11,
            color: AppStyle.textDarkFaint,
            letterSpacing: 0.8,
          ),
        ),
      );

  Widget _textField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: AppStyle.interNormal(size: 13, color: AppStyle.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
        filled: true,
        fillColor: AppStyle.cardDarkAlt,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// The shipped `_priorities` triple.
  Widget _priorityTriple() {
    return Row(
      children: [
        for (final priority in _priorities) ...[
          _pill(
            label: priority,
            selected: _selectedPriority == priority,
            tint: taskPriorityColor(priority),
            onTap: () => setState(() => _selectedPriority = priority),
          ),
          if (priority != _priorities.last) 8.horizontalSpace,
        ],
      ],
    );
  }

  /// The shipped `_recurrences` quad as a pill switcher.
  Widget _recurrenceQuad() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final recurrence in _recurrences)
          _pill(
            label: recurrence,
            selected: _recurrence == recurrence,
            onTap: () => setState(() => _recurrence = recurrence),
          ),
      ],
    );
  }

  Widget _pill({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Color? tint,
  }) {
    final color = tint ?? AppStyle.primary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color:
              selected ? color.withValues(alpha: 0.16) : AppStyle.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? color : AppStyle.strokeDarkSubtle,
          ),
        ),
        child: Text(
          label,
          style: AppStyle.interSemi(
            size: 12,
            color: selected ? color : AppStyle.textDarkSecondary,
          ),
        ),
      ),
    );
  }

  Widget _deadlineRow() {
    final deadline = _selectedDeadline;
    return GestureDetector(
      onTap: _pickDeadline,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppStyle.cardDarkAlt,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(Icons.schedule, size: 16.r, color: AppStyle.textDarkFaint),
            8.horizontalSpace,
            Expanded(
              child: Text(
                deadline == null
                    ? 'No deadline'
                    : kTaskDeadlineFormat.format(deadline),
                style: AppStyle.interNormal(
                  size: 13,
                  color: deadline == null
                      ? AppStyle.textDarkFaint
                      : AppStyle.textPrimary,
                ),
              ),
            ),
            if (deadline != null)
              GestureDetector(
                onTap: () => setState(() => _selectedDeadline = null),
                child: Icon(
                  Icons.close,
                  size: 15.r,
                  color: AppStyle.textDarkFaint,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// FLAG (c) — the sub-line is the honest half of this control.
  Widget _reminderToggle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Remind me',
                style: AppStyle.interSemi(
                  size: 13,
                  color: AppStyle.textPrimary,
                ),
              ),
              2.verticalSpace,
              Text(
                'a local notification at the deadline',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _isReminderSet,
          activeThumbColor: AppStyle.primary,
          onChanged: (value) => setState(() => _isReminderSet = value),
        ),
      ],
    );
  }

  /// Section 46 — the order rule, drawn as the toggle it is.
  Widget _stepsInOrderToggle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Steps in order',
                style: AppStyle.interSemi(
                  size: 13,
                  color: AppStyle.textPrimary,
                ),
              ),
              2.verticalSpace,
              Text(
                _stepsInOrder
                    ? 'a run opens them one at a time; the next unlocks when the one before is done'
                    : 'a checklist — tick them in any order',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _stepsInOrder,
          activeThumbColor: AppStyle.primary,
          onChanged: (value) => setState(() => _stepsInOrder = value),
        ),
      ],
    );
  }

  /// The two-clock row for the task being edited, when it has a reminder.
  List<Widget> _editingReminderRow() {
    final int index = _todos.indexWhere((t) => t['id'] == _editingId);
    if (index == -1) return const <Widget>[];
    final TaskViewModel task = TaskViewModel.fromMap(_todos[index]);
    if (!task.hasReminder) return const <Widget>[];
    return <Widget>[
      10.verticalSpace,
      TaskReminderRow(
        task: task,
        onSnooze: task.isDone ? null : () => _snooze(index),
      ),
    ];
  }

  /// CHIP 1064 — keep the task in the long-term band above the day's
  /// work. Set by hand: the surfacing rule frame 47m proposed awaits the
  /// owner's word and nothing derives it.
  Widget _longTermToggle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Long term',
                style: AppStyle.interSemi(
                  size: 13,
                  color: AppStyle.textPrimary,
                ),
              ),
              2.verticalSpace,
              Text(
                'kept in a band of its own above the day\'s work',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _isLongTerm,
          activeThumbColor: LongTermBandHeader.tint,
          onChanged: (value) => setState(() => _isLongTerm = value),
        ),
      ],
    );
  }

  /// CHIP 831 — dashed means nothing committed yet. Section 46 gave the
  /// composer two more fields: what to do on the step, and how long it
  /// takes (minutes; blank or 0 is an untimed step with no clock).
  Widget _subtaskComposer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _composerField(
          _subtaskController,
          'Name the step, then add it',
          onSubmitted: (_) => _addSubtask(),
        ),
        6.verticalSpace,
        _composerField(
          _subtaskInstructionController,
          'What to do on this step (optional)',
        ),
        6.verticalSpace,
        Row(
          children: [
            SizedBox(
              width: 110.w,
              child: _composerField(
                _subtaskMinutesController,
                'Minutes',
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addSubtask(),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Text(
                'blank or 0 = no clock, just a confirmation',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                ),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        SubtaskComposerRow(
          label: _editingId == null ? 'Add a step' : 'Add a subtask',
          onTap: _addSubtask,
        ),
      ],
    );
  }

  Widget _composerField(
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    ValueChanged<String>? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      style: AppStyle.interNormal(size: 12, color: AppStyle.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
        filled: true,
        fillColor: AppStyle.cardDarkAlt,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Delete / Save task at 1 : 1.5, per frame 44a.
  Widget _paneActions() {
    return Row(
      children: [
        if (_editingId != null) ...[
          Expanded(
            flex: 2,
            child: OutlinedButton(
              onPressed: () {
                final index =
                    _todos.indexWhere((t) => t['id'] == _editingId);
                if (index != -1) _removeTodo(index);
                _closePane();
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(0, 44.h),
                side: BorderSide(color: AppStyle.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Delete',
                style: AppStyle.interSemi(size: 13, color: AppStyle.red),
              ),
            ),
          ),
          10.horizontalSpace,
        ],
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              _saveTask();
              _closePane();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyle.primary,
              foregroundColor: AppStyle.blackColor,
              minimumSize: Size(0, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Save task',
              style:
                  AppStyle.interSemi(size: 13, color: AppStyle.blackColor),
            ),
          ),
        ),
      ],
    );
  }
}

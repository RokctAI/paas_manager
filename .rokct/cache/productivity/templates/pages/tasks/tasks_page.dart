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
    _selectedDay = _focusedDay;
    _initNotifications();
    _loadTodos();
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
  }

  Future<void> _saveTodos() async {
    await _repository.saveTodos(_todos);
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

          _todos[index] = {
            'id': id,
            'notifId': notifId,
            'title': title,
            'isDone': _todos[index]['isDone'],
            'deadline': deadlineStr,
            'reminder': _isReminderSet,
            'priority': _selectedPriority,
            'category': category,
            'recurrence': _recurrence,
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
      _selectedDeadline = null;
      _isReminderSet = false;
      _selectedPriority = 'Medium';
      _recurrence = 'None';
      _selectedCategory = null;
      _currentSubtasks = [];
    });
    _saveTodos();
  }

  void _addSubtask() {
    if (_subtaskController.text.trim().isNotEmpty) {
      setState(() {
        _currentSubtasks.add({
          'title': _subtaskController.text.trim(),
          'isDone': false,
        });
        _subtaskController.clear();
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
      _selectedDeadline = null;
      _isReminderSet = false;
      _selectedPriority = 'Medium';
      _recurrence = 'None';
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
      'subtasks':
          (task['subtasks'] as List?)?.map((s) {
            final copy = Map<String, dynamic>.from(s);
            copy['isDone'] = false;
            return copy;
          }).toList() ??
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
  // The mechanism is base_sdk's ListPlaneFlow, unchanged — the section
  // 38 list flow, whose lists already declare two and whose corner back
  // pill (canonical 347) is raised only while a pane is open.
  //
  // THREE FLAGS RIDE THIS SCREEN AND ARE DRAWN, NOT HIDDEN:
  //   (a) these tasks live on this device only — no remote store, no
  //       sync. The local-only strip (828) says so above the first
  //       card at EVERY width, phone included.
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
    return ListPlaneFlow(
      backIcon: Icons.arrow_back,
      listSpan: PlaneSpan.two,
      detailName: _editingId ?? (_paneOpen ? 'compose' : null),
      detailBuilder: _paneOpen ? (context) => _composePane(context) : null,
      onCloseDetail: _closePane,
      listBuilder: _listPlane,
    );
  }

  /// True while the last plane is carrying something — an edit (the
  /// detail pane, 829) or a new task (the compose lane, 830). Create and
  /// edit are ONE component with an empty model, exactly as the shipped
  /// page already treats them via `_editingId`.
  bool get _paneOpen => _editingId != null || _composing;

  bool _composing = false;

  void _openCompose() {
    _cancelEditing();
    setState(() => _composing = true);
  }

  void _closePane() {
    _cancelEditing();
    setState(() => _composing = false);
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
              // CHIP 828 — flag (a), above the first card at every
              // width. The headline fact is not a wide-read luxury.
              const LocalOnlyStrip(),
              12.verticalSpace,
              if (_showCalendar) ...[
                _calendar(),
                12.verticalSpace,
              ],
              Expanded(
                child: displayedTodos.isEmpty
                    ? _emptyList()
                    : ListView.separated(
                        padding: EdgeInsets.only(bottom: 88.h),
                        itemCount: displayedTodos.length,
                        separatorBuilder: (_, __) => 8.verticalSpace,
                        itemBuilder: (context, index) {
                          final originalIndex = displayedTodos[index].key;
                          final todo = displayedTodos[index].value;
                          final task = TaskViewModel.fromMap(todo);
                          return TaskCard(
                            task: task,
                            selected: _editingId == task.id,
                            // FRAME 44d: on one plane the card expands
                            // in place instead of pushing a pane.
                            expanded: singlePlane && _expandedId == task.id,
                            onToggleDone: () => _toggleTodo(originalIndex),
                            onTap: () => singlePlane
                                ? setState(() => _expandedId =
                                    _expandedId == task.id ? null : task.id)
                                : _startEditing(originalIndex),
                            onToggleSubtask: (i) =>
                                _toggleSubtaskStatus(originalIndex, i),
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
      child: Text(
        'Nothing here yet.',
        style: AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
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
              14.verticalSpace,
              _fieldLabel('SUBTASKS'),
              for (var i = 0; i < _currentSubtasks.length; i++)
                SubtaskCheckLine(
                  subtask: SubtaskViewModel.fromMap(_currentSubtasks[i]),
                  onToggle: () => _toggleFormSubtaskStatus(i),
                  onRemove: () =>
                      setState(() => _currentSubtasks.removeAt(i)),
                ),
              8.verticalSpace,
              _subtaskComposer(),
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

  /// CHIP 831 — dashed means nothing committed yet.
  Widget _subtaskComposer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _subtaskController,
          onSubmitted: (_) => _addSubtask(),
          style: AppStyle.interNormal(size: 12, color: AppStyle.textPrimary),
          decoration: InputDecoration(
            hintText: 'Name the step, then add it',
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
        ),
        8.verticalSpace,
        SubtaskComposerRow(
          label: _editingId == null ? 'Add a step' : 'Add a subtask',
          onTap: _addSubtask,
        ),
      ],
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

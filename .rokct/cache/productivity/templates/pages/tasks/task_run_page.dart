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

// Design strip section 46 — the guided run as a page of its own,
// `/tasks/run?task=<id>`.
//
// On a wide window the run lives in /tasks' detail plane (frame 46a — "the
// run is 44a's detail plane, no new push"; frame 47a — "46's mechanism,
// unchanged — no new plane"), and `tasks_page.dart` hosts `TaskRunView`
// there directly. So on a wide window THIS route hands the window to that
// workspace with the run open — list beside it, the corner pill popping
// the pane and then the route — rather than hosting the run on planes of
// its own, which is what the tablet audit of 2026-09-07 found it doing
// (two planes claimed, no list beside them). At one plane there is no
// detail plane to land in, so the phone pushes this page (46f): the same
// view, the whole screen, the corner pill as the way back. Any other SDK
// can open a run by route path without importing this one (ADR-005):
//
///   context.router.pushNamed('/tasks/run?task=$taskId');
//
// At one plane, "Mark done" on the finished card marks the task done. When
// the tasks list pushed the run (`caller=list`), the page pops `true` and
// the list ticks the task with its own recurrence and reminders. Opened
// any other way (another SDK's route push, a deep link), nobody is waiting
// on that result, so the page marks the task done itself through the same
// repository: it cancels the task's reminder, makes the next occurrence of
// a repeating task (TaskRecurrence, the same rule the list uses) and saves
// both, then pops `true`. On a wide window the workspace owns the list,
// ticks the task itself and pops nothing.
//
// The page persists exactly as the workspace does: the local store first,
// through the same repository, and the outbox push follows unawaited.

import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:comms_sdk/comms_sdk.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:productivity_sdk/productivity_sdk.dart';
import 'package:uuid/uuid.dart';

// The workspace this route yields a wide window to. Installed beside this
// file (manifest.json installs templates/pages/tasks as one directory), so
// the import is relative, as the crm templates import their widgets.
import 'tasks_page.dart';

@RoutePage(name: 'TaskRunRoute')
class TaskRunPage extends StatefulWidget {
  const TaskRunPage({
    super.key,
    @QueryParam('task') this.taskId,
    @QueryParam('caller') this.caller,
  });

  /// The local id of the task to run.
  final String? taskId;

  /// `list` when the tasks list pushed this page and will tick the task
  /// itself on a `true` result; anything else and this page does it.
  final String? caller;

  @override
  State<TaskRunPage> createState() => _TaskRunPageState();
}

class _TaskRunPageState extends State<TaskRunPage> {
  late final TodoRepositoryFacade _repository;

  Map<String, dynamic>? _task;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _repository = TodoRepositoryImpl(AppDatabase());
    _load();
  }

  Future<void> _load() async {
    final String id = widget.taskId ?? '';
    final List<Map<String, dynamic>> todos = await _repository.loadTodos();
    Map<String, dynamic>? found;
    for (final Map<String, dynamic> todo in todos) {
      if ('${todo['id'] ?? ''}' == id) {
        found = todo;
        break;
      }
    }
    if (!mounted) return;
    setState(() {
      _task = found;
      _loaded = true;
    });
  }

  /// The run wrote progress onto the task: hold it, save it. Local first;
  /// the push rides the outbox and nothing here waits for it. Frame 47d:
  /// a finished plant-setup run also becomes the device's plant record.
  void _onChanged(Map<String, dynamic> task) {
    setState(() => _task = task);
    _repository.saveTodos(<Map<String, dynamic>>[task]);
    unawaited(MaintenancePlantStore.local.captureFromRun(task));
  }

  /// "Mark done" on the finished card. See the file comment: the tasks
  /// list ticks the task itself, anyone else gets it ticked here.
  Future<void> _markDone() async {
    final Map<String, dynamic>? task = _task;
    if (widget.caller == 'list' || task == null || task['isDone'] == true) {
      if (mounted) await context.router.maybePop(true);
      return;
    }
    final Map<String, dynamic> done = <String, dynamic>{
      ...task,
      'isDone': true,
    };
    final Object? notifId = done['notifId'];
    if (notifId is int) LocalNotifications.cancelNotification(notifId);
    final int nextNotifId = Random().nextInt(100000);
    final Map<String, dynamic>? next = TaskRecurrence.spawnNext(
      done,
      newId: const Uuid().v4(),
      notifId: nextNotifId,
    );
    await _repository.saveTodos(<Map<String, dynamic>>[
      done,
      if (next != null) next,
    ]);
    if (next != null && next['reminder'] == true) {
      LocalNotifications.scheduleNotification(
        id: nextNotifId,
        title: 'Task Reminder',
        body: done['title'],
        scheduledDate: DateTime.parse(next['deadline'] as String),
      );
    }
    if (!mounted) return;
    setState(() => _task = done);
    await context.router.maybePop(true);
  }

  @override
  Widget build(BuildContext context) {
    // A BuildContext lookup for the mode, not the app-wide AppStyle.isDark
    // static (Ray, 2026-09-19: "glance doesnt change test immediately
    // untill you come back if you switched theme mode" — the same defect,
    // found in this page by the audit that followed).
    //
    // Read HERE, in the State's own build and outside the LayoutBuilder
    // below, so the dependency lands on this element: AppStyle's
    // mode-resolving statics carry the right value but are not an
    // inherited widget, so reading one registers nothing — and this page
    // is a pushed ModalRoute, which caches the widget it built, so an
    // ancestor rebuild provably never reaches it either. The run's ground
    // and its one absent-task line kept the previous mode's colours until
    // the reader popped the page and pushed it again.
    final Brightness brightness = Theme.of(context).brightness;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // FRAME 47a — the run is 44a's DETAIL plane, list beside it, and
        // claims no plane of its own: a wide window is the workspace's.
        // The same thresholds PlaneHost divides the window by, so "wide"
        // here is exactly where the workspace would show two planes.
        if (PlaneHost.planeCountFor(constraints.maxWidth) >= 2) {
          return TasksWorkspace(
            key: ValueKey<String>('run-workspace-${widget.taskId ?? ''}'),
            initialRunId: widget.taskId,
          );
        }
        return _onePlane(context, brightness);
      },
    );
  }

  /// FRAME 46f — the one-plane push: the run fills the screen.
  ///
  /// [brightness] is the mode the inherited theme reports, read in [build];
  /// every colour role here resolves against it rather than against the
  /// app-wide flag.
  Widget _onePlane(BuildContext context, Brightness brightness) {
    final Map<String, dynamic>? task = _task;
    return Scaffold(
      backgroundColor: AppStyle.surfaceFor(brightness),
      body: SafeArea(
        child: !_loaded
            ? const SizedBox.shrink()
            : task == null
            ? Center(
                child: Text(
                  'That task is not on this device.',
                  style: AppStyle.interNormal(
                    size: 13,
                    color: AppStyle.faintFor(brightness),
                  ),
                ),
              )
            : PlaneHost(
                stack: <PlanePage>[
                  PlanePage(
                    name: 'task-run-${task['id']}',
                    // One plane, never two (TasksPlaneClaims.run): this
                    // host only ever stands on a one-plane window now, and
                    // the claim says so rather than asking for a second.
                    span: TasksPlaneClaims.run,
                    builder: (BuildContext context) => TaskRunView(
                      key: ValueKey<String>('run-${task['id']}'),
                      task: task,
                      onChanged: _onChanged,
                      onLeave: () => context.router.maybePop(false),
                      onMarkDone: _markDone,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

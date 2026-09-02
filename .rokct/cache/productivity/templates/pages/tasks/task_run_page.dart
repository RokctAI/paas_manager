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
// run is 44a's detail plane, no new push"), and `tasks_page.dart` hosts
// `TaskRunView` there directly. At one plane there is no detail plane to
// land in, so the phone pushes THIS page (46f): the same view, the whole
// screen, the corner pill as the way back. Any other SDK can open a run
// by route path without importing this one (ADR-005):
//
///   context.router.pushNamed('/tasks/run?task=$taskId');
//
// It pops `true` when the user marks the task done from the finished card,
// so a caller that owns the list can tick it; a caller that ignores the
// result is left with every step done and the task itself still open,
// which is the honest state.
//
// The page persists exactly as the workspace does: the local store first,
// through the same repository, and the outbox push follows unawaited.

import 'package:auto_route/auto_route.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:productivity_sdk/productivity_sdk.dart';

@RoutePage(name: 'TaskRunRoute')
class TaskRunPage extends StatefulWidget {
  const TaskRunPage({super.key, @QueryParam('task') this.taskId});

  /// The local id of the task to run.
  final String? taskId;

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
  /// the push rides the outbox and nothing here waits for it.
  void _onChanged(Map<String, dynamic> task) {
    setState(() => _task = task);
    _repository.saveTodos(<Map<String, dynamic>>[task]);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? task = _task;
    return Scaffold(
      backgroundColor: AppStyle.surfaceDark,
      body: SafeArea(
        child: !_loaded
            ? const SizedBox.shrink()
            : task == null
            ? Center(
                child: Text(
                  'That task is not on this device.',
                  style: AppStyle.interNormal(
                    size: 13,
                    color: AppStyle.textDarkFaint,
                  ),
                ),
              )
            : PlaneHost(
                stack: <PlanePage>[
                  PlanePage(
                    name: 'task-run-${task['id']}',
                    span: PlaneSpan.two,
                    builder: (BuildContext context) => TaskRunView(
                      key: ValueKey<String>('run-${task['id']}'),
                      task: task,
                      onChanged: _onChanged,
                      onLeave: () => context.router.maybePop(false),
                      onMarkDone: () => context.router.maybePop(true),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

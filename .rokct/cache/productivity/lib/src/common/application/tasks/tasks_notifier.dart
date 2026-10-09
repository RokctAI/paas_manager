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

// ProcessingState is base_sdk's lifecycle enum (the one TaskModel.status
// carries and TaskService.transitionTask takes), so it comes from
// base_sdk's barrel. This package's own barrel does not re-export
// base_sdk, so importing productivity_sdk.dart alone never made the
// enum visible here.
import 'package:base_sdk/base_sdk.dart';
// `visibleForTesting` on the live-notifier count below.
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// The two members of this package this notifier names, imported directly
// rather than through productivity_sdk.dart: this library sits INSIDE the
// surface that barrel exports, and a file under src/ reaching back out
// through it is how the missing base_sdk import stayed hidden.
import '../../infrastructure/services/task_service.dart';
import '../../models/data/task_data.dart';
import 'tasks_state.dart';

class TasksNotifier extends StateNotifier<TasksState> {
  TasksNotifier(this._service) : super(TasksState()) {
    _live.add(this);
    loadTasks();
  }

  final TaskService _service;

  /// Every notifier this process is still holding.
  ///
  /// WHY A REGISTRY AND NOT `ref.invalidate`. `tasksStateProvider` is a plain
  /// `StateNotifierProvider`, not an `autoDispose` one, so it lives in the
  /// root scope for the whole process: a sign-out that empties the drift
  /// tables and then replaces the route rebuilds the page but re-reads THIS
  /// same notifier, and the tasks it is holding stay on screen until the app
  /// is restarted. Ray, 2026-09-19: "if on temp local user you logout all
  /// your tasks still show".
  ///
  /// The clear has to be reachable from users_sdk's `SessionEndHooks`, which
  /// is a plain callback with no `WidgetRef` and no `ProviderContainer` in
  /// reach -- there is no `ref` to invalidate with. So the notifier makes
  /// itself findable instead. Entries are removed in [dispose], so a
  /// disposed notifier is never held here and the set stays at the one or
  /// two notifiers a running app actually has.
  static final Set<TasksNotifier> _live = <TasksNotifier>{};

  /// How many notifiers are live. Test hook for the [dispose] bookkeeping:
  /// a registry that leaked would grow without bound.
  @visibleForTesting
  static int get liveCount => _live.length;

  @override
  void dispose() {
    _live.remove(this);
    super.dispose();
  }

  /// Forget every task held in memory, WITHOUT touching the store.
  ///
  /// Deliberately not a reload: at sign-out the rows are being deleted around
  /// this call, and a reload would race that deletion and could repopulate
  /// the list from rows that are on their way out.
  void clear() {
    state = TasksState();
  }

  /// Forget the tasks in every live notifier -- what a session end calls.
  ///
  /// `mounted` is checked because a notifier can be disposed between the
  /// `toList()` snapshot and the write, and setting state on a disposed
  /// `StateNotifier` throws.
  static void clearLive() {
    for (final TasksNotifier notifier in _live.toList()) {
      if (notifier.mounted) notifier.clear();
    }
  }

  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true);
    try {
      final tasks = await _service.getTasks();
      state = state.copyWith(tasks: tasks, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _service.addTask(task);
      await loadTasks();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _service.updateTask(task);
      await loadTasks();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _service.deleteTask(id);
      await loadTasks();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> transitionTask(String id, ProcessingState newState) async {
    try {
      await _service.transitionTask(id, newState);
      await loadTasks();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tasks_state.dart';
import 'package:productivity_sdk/productivity_sdk.dart';

class TasksNotifier extends StateNotifier<TasksState> {
  TasksNotifier(this._service) : super(TasksState()) {
    loadTasks();
  }

  final TaskService _service;

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

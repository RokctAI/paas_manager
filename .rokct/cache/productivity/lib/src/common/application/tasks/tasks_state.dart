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

// TaskModel is this package's own model, and this library names it in its
// field and in copyWith. It must be imported HERE rather than leaned on
// through whatever library happens to import this one: nothing in the
// public surface reached this file until the needs-attention glance did,
// and the day it did the missing import became a compile error in every
// app that composes this SDK.
import '../../models/data/task_data.dart';

class TasksState {
  final List<TaskModel> tasks;
  final bool isLoading;
  final String? errorMessage;

  TasksState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TasksState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:base_sdk/base_sdk.dart';
import 'package:drift/drift.dart';

import '../../models/data/task_data.dart';

class TaskService {
  final AppDatabase _database;

  TaskService(this._database);

  Future<List<TaskModel>> getTasks() async {
    final tasks = await _database.select(_database.tasksTable).get();
    return tasks.map((task) {
      if (task.data == null) return TaskModel.fromMap({});
      return TaskModel.fromJson(task.data!);
    }).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await _database.into(_database.tasksTable).insert(
      TasksTableCompanion.insert(
        id: Value(task.id),
        title: task.title,
        description: Value(task.description),
        isCompleted: Value(task.isCompleted),
        dueDate: Value(task.dueDate),
        createdAt: Value(task.lastUpdated),
        updatedAt: Value(task.lastUpdated),
        data: Value(task.toJson()),
      ),
    );
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    await _database.into(_database.tasksTable).insertOnConflictUpdate(
      TasksTableCompanion.insert(
        id: Value(updatedTask.id),
        title: updatedTask.title,
        description: Value(updatedTask.description),
        isCompleted: Value(updatedTask.isCompleted),
        dueDate: Value(updatedTask.dueDate),
        updatedAt: Value(updatedTask.lastUpdated),
        data: Value(updatedTask.toJson()),
      ),
    );
  }

  /// Transitions a task to a new state, enforcing the shared lifecycle
  /// rules (base_sdk's pure [ProcessingStateMachine]).
  Future<TaskModel> transitionTask(String id, ProcessingState newState) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((t) => t.id == id);
    if (index == -1) {
      throw ArgumentError('Task with ID $id not found.');
    }

    final currentTask = tasks[index];
    if (!ProcessingStateMachine.canTransition(currentTask.status, newState)) {
      throw StateError(
          'Invalid transition ${currentTask.status} -> $newState for task $id.');
    }

    final updatedTask = currentTask.copyWith(
      status: newState,
      lastUpdated: DateTime.now(),
    );

    await updateTask(updatedTask);
    return updatedTask;
  }

  Future<void> deleteTask(String id) async {
    await (_database.delete(_database.tasksTable)..where((t) => t.id.equals(id))).go();
  }
}

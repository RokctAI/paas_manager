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

import 'package:base_sdk/base_sdk.dart';
import 'package:drift/drift.dart';

import '../../models/data/task_data.dart';
import '../database/productivity_owner_scope.dart';

class TaskService {
  final AppDatabase _database;

  TaskService(this._database);

  Future<List<TaskModel>> getTasks() async {
    await ProductivityOwnerScope.ready(_database);
    final String owner = ProductivityOwnerScope.currentOwner;
    final tasks = await (_database.select(_database.tasksTable)
          ..where((t) => ownerVisible(t.owner, owner)))
        .get();
    return tasks.map((task) {
      if (task.data == null) return TaskModel.fromMap({});
      return TaskModel.fromJson(task.data!);
    }).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await ProductivityOwnerScope.ready(_database);
    await _database.into(_database.tasksTable).insert(
      TasksTableCompanion.insert(
        id: Value(task.id),
        owner: Value(ProductivityOwnerScope.currentOwner),
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
    await ProductivityOwnerScope.ready(_database);
    final String owner = ProductivityOwnerScope.currentOwner;
    // Same claim as the tasks store's: the upsert below conflicts on the
    // full {id, owner}, so a pre-scoping row for this id is taken over
    // rather than left beside the row being written.
    if (owner != kUnownedOwner) {
      await (_database.update(_database.tasksTable)
            ..where((t) =>
                t.id.equals(updatedTask.id) &
                t.owner.equals(kUnownedOwner)))
          .write(TasksTableCompanion(owner: Value(owner)));
    }
    await _database.into(_database.tasksTable).insertOnConflictUpdate(
      TasksTableCompanion.insert(
        id: Value(updatedTask.id),
        owner: Value(owner),
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
    await ProductivityOwnerScope.ready(_database);
    final String owner = ProductivityOwnerScope.currentOwner;
    await (_database.delete(_database.tasksTable)
          ..where((t) => t.id.equals(id) & ownerVisible(t.owner, owner)))
        .go();
  }
}

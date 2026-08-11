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

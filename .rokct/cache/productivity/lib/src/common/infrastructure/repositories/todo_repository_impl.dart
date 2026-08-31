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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../../domain/interface/todo_repository_facade.dart';

class TodoRepositoryImpl implements TodoRepositoryFacade {
  final AppDatabase _database;

  TodoRepositoryImpl(this._database);

  @override
  Future<List<Map<String, dynamic>>> loadTodos() async {
    final List<Map<String, dynamic>> todos = <Map<String, dynamic>>[];
    try {
      final tasks = await _database.select(_database.tasksTable).get();
      for (final task in tasks) {
        todos.add(rowToTodo(task));
      }
    } catch (e) {
      debugPrint('Error loading todos: $e');
    }
    return todos;
  }

  /// Rebuilds one in-memory todo map from its stored row.
  ///
  /// The typed columns only carry part of a task. Everything else the tasks
  /// surface keeps on the map - notifId, reminder, priority, category,
  /// recurrence and the subtask list - lives in the [TasksTable.data] JSON
  /// blob that [saveTodos] writes, so the blob has to be decoded here or all
  /// of it is silently dropped on the next start.
  ///
  /// The typed columns stay authoritative for the fields they own: they are
  /// written from the same map, they are what a migration or a sync would
  /// touch, and routing `deadline` through the DateTime column is what keeps
  /// the surface's `DateTime.parse` on it from throwing on a hand-edited row.
  @visibleForTesting
  static Map<String, dynamic> rowToTodo(TaskEntity task) {
    final Map<String, dynamic> todo = decodeTodoData(task.data);
    todo['id'] = task.id;
    todo['title'] = task.title;
    todo['description'] = task.description;
    todo['isDone'] = task.isCompleted;
    todo['deadline'] = task.dueDate?.toIso8601String();
    todo['createdAt'] = task.createdAt.toIso8601String();
    todo['updatedAt'] = task.updatedAt.toIso8601String();
    todo['createdBy'] = task.createdBy;
    return todo;
  }

  /// Decodes a stored [TasksTable.data] blob into the extra fields it holds.
  ///
  /// Rows written before the blob was ever read back, rows whose blob is null
  /// or empty, and rows holding something that is not a JSON object all have
  /// to keep loading: a throw here would take down the whole list and turn a
  /// silent loss of the extras into a dead tasks page. Every one of those
  /// degrades to no extras, and [rowToTodo] still fills the columns in.
  @visibleForTesting
  static Map<String, dynamic> decodeTodoData(String? data) {
    if (data == null || data.trim().isEmpty) return <String, dynamic>{};
    try {
      final Object? decoded = jsonDecode(data);
      if (decoded is! Map) return <String, dynamic>{};
      final Map<String, dynamic> todo = <String, dynamic>{};
      decoded.forEach((key, value) => todo[key.toString()] = value);
      // The blob is never part of the map the surface works with. Handing it
      // back would make the next saveTodos encode one blob inside the next,
      // growing the column on every write.
      todo.remove('data');
      return todo;
    } catch (e) {
      debugPrint('Error decoding stored task data, using columns only: $e');
      return <String, dynamic>{};
    }
  }

  @override
  Future<void> saveTodos(List<Map<String, dynamic>> todos) async {
    try {
      await _database.transaction(() async {
        for (final todo in todos) {
          // Resolve the id once so the row key and the blob agree; the blob
          // is what carries it back when the caller supplied no id.
          final String id = (todo['id'] ?? const Uuid().v4()).toString();
          await _database.into(_database.tasksTable).insertOnConflictUpdate(
            TasksTableCompanion.insert(
              id: Value(id),
              title: (todo['title'] ?? '').toString(),
              description: Value(todo['description']?.toString()),
              isCompleted: Value(todo['isDone'] == true),
              dueDate: Value(todo['deadline'] != null
                  ? DateTime.tryParse(todo['deadline'].toString())
                  : null),
              createdAt: Value((todo['createdAt'] != null
                      ? DateTime.tryParse(todo['createdAt'].toString())
                      : null) ??
                  DateTime.now()),
              updatedAt: Value(DateTime.now()),
              createdBy: Value(todo['createdBy']?.toString()),
              data: Value(encodeTodoData(todo, id)),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint('Error saving todos: $e');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    if (id.isEmpty) return;
    try {
      await (_database.delete(_database.tasksTable)
            ..where((t) => t.id.equals(id)))
          .go();
    } catch (e) {
      debugPrint('Error deleting todo $id: $e');
    }
  }

  /// Encodes the extra fields of one todo for the [TasksTable.data] column.
  ///
  /// A value the surface put on the map that json cannot encode would abort
  /// the surrounding transaction and lose the write for every task in the
  /// list, so one task's extras are dropped instead of all of them.
  @visibleForTesting
  static String encodeTodoData(Map<String, dynamic> todo, String id) {
    final Map<String, dynamic> payload = Map<String, dynamic>.from(todo)
      ..remove('data')
      ..['id'] = id;
    try {
      return jsonEncode(payload);
    } catch (e) {
      debugPrint('Error encoding task data for $id: $e');
      return jsonEncode(<String, dynamic>{'id': id});
    }
  }

  @override
  Future<void> exportTodos(List<Map<String, dynamic>> todos) async {

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/todos_backup.json');
      await file.writeAsString(json.encode(todos));
      await Share.shareXFiles([XFile(file.path)], text: 'My Todo Backup');
    } catch (e) {
      debugPrint('Error exporting data: $e');
    }
  }
}

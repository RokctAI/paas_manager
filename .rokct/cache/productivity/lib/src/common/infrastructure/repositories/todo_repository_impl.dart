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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../../domain/interface/todo_repository_facade.dart';
import '../../models/request/task_request.dart';
import '../services/task_pull_service.dart';
import '../services/task_sync_queue.dart';
import '../services/task_sync_store.dart';

/// The tasks surface's store.
///
/// LOCAL FIRST, AND LOCAL ONLY ON THE USER'S PATH. Every method here writes
/// drift and returns; not one of them awaits a network round trip. Sync is
/// bolted on ADDITIVELY: a save also drops a row in the SyncEngine outbox
/// and asks the engine to drain without waiting for it, so a device with no
/// backend, no network, or no account behaves exactly as it did before any
/// of this existed - the task is saved, the list redraws, nothing spins and
/// nothing fails.
///
/// There is deliberately NO offline branch. The same code runs whether or
/// not a server is reachable; the only difference is how long an op sits in
/// the outbox before it drains.
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
  ///
  /// Package-internal codec rather than a test hook: the sync store rebuilds
  /// the same map when it applies a pulled task or a handshake, and a second
  /// spelling of this decoding is how the two would drift apart.
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
    // The sync ids are columns, so the columns are authoritative for them
    // even when a stale blob disagrees.
    todo['clientId'] = task.clientId;
    todo['remoteId'] = task.remoteId;
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
    // (client_id, task) pairs whose stored state actually changed. Collected
    // inside the transaction and queued after it commits, so the outbox row
    // can never describe a local write that then rolled back.
    final List<MapEntry<String, Map<String, dynamic>>> pendingPush =
        <MapEntry<String, Map<String, dynamic>>>[];
    try {
      await _database.transaction(() async {
        for (final todo in todos) {
          // Resolve the id once so the row key and the blob agree; the blob
          // is what carries it back when the caller supplied no id.
          final String id = (todo['id'] ?? const Uuid().v4()).toString();
          final TaskEntity? existing = await (_database
                    .select(_database.tasksTable)
                  ..where((t) => t.id.equals(id)))
              .getSingleOrNull();
          // The client_id is minted ONCE and then never changes: it is the
          // key the server upserts on, so a task that gained a new one on
          // every save would be created afresh on the server every time.
          final String clientId = _resolveClientId(existing, todo);
          todo['clientId'] = clientId;
          if (existing?.remoteId != null) todo['remoteId'] = existing!.remoteId;
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
              clientId: Value(clientId),
              data: Value(encodeTodoData(todo, id)),
            ),
          );
          if (needsPush(existing, todo, clientId)) {
            pendingPush.add(
              MapEntry<String, Map<String, dynamic>>(
                clientId,
                Map<String, dynamic>.from(todo),
              ),
            );
          }
        }
      });
    } catch (e) {
      debugPrint('Error saving todos: $e');
      // The local write is what the user asked for; a failure here has
      // already been reported and there is nothing to push.
      return;
    }
    // Queueing is another local write plus a drain request that is NOT
    // awaited, so this loop stays off the network entirely.
    for (final MapEntry<String, Map<String, dynamic>> entry in pendingPush) {
      try {
        await TaskSyncQueue.queueUpsert(clientId: entry.key, todo: entry.value);
      } catch (e) {
        // The task is saved. Failing to queue its push must not turn a
        // successful save into a failure.
        debugPrint('Error queueing task push for ${entry.key}: $e');
      }
    }
  }

  /// The `client_id` this task keeps for good: the one already on the row,
  /// else one the caller carried, else a fresh one.
  static String _resolveClientId(TaskEntity? existing, Map<String, dynamic> todo) {
    final String stored = (existing?.clientId ?? '').toString();
    if (stored.isNotEmpty) return stored;
    final String carried = (todo['clientId'] ?? '').toString();
    if (carried.isNotEmpty) return carried;
    return TaskSyncStore.newClientId();
  }

  /// Whether this save changed anything the SERVER would care about.
  ///
  /// The tasks page saves the WHOLE list on every keystroke-sized action, so
  /// without this one tapped checkbox would queue an op for every task in
  /// the list. Comparing the wire payloads - not the maps - means a purely
  /// local change (a notification id, say) correctly queues nothing.
  @visibleForTesting
  static bool needsPush(
    TaskEntity? existing,
    Map<String, dynamic> todo,
    String clientId,
  ) {
    // Never stored, or stored before this device minted client ids: the
    // server has certainly not seen it.
    if (existing == null || (existing.clientId ?? '').isEmpty) return true;
    final String before = jsonEncode(
      TaskRequest.fromTodo(rowToTodo(existing), clientId).toJson(),
    );
    final String after =
        jsonEncode(TaskRequest.fromTodo(todo, clientId).toJson());
    return before != after;
  }

  @override
  Future<void> deleteTodo(String id) async {
    if (id.isEmpty) return;
    String clientId = '';
    try {
      // Read the client_id before the row goes: it is the only handle the
      // server has on this task.
      final TaskEntity? row = await (_database.select(_database.tasksTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      clientId = (row?.clientId ?? '').toString();
      await (_database.delete(_database.tasksTable)
            ..where((t) => t.id.equals(id)))
          .go();
    } catch (e) {
      debugPrint('Error deleting todo $id: $e');
      return;
    }
    if (clientId.isEmpty) return; // Never had a server identity to remove.
    try {
      // A queued upsert for a task that no longer exists locally is stale
      // whatever happens next, so it goes first.
      await TaskSyncQueue.dropQueuedUpsert(clientId);
      // The delete is queued unconditionally rather than only when the row
      // carried a remote id. A push that was in flight at this moment may
      // have created the task server-side a heartbeat after the local id was
      // read, and skipping the delete would strand it there forever. Asking
      // the server to delete something it never had is harmless - the
      // handler reads that 404 as "already gone".
      await TaskSyncQueue.queueDelete(clientId);
    } catch (e) {
      // Same rule as the save path: the row IS deleted locally, and a
      // queueing failure must not undo or report that.
      debugPrint('Error queueing task delete for $clientId: $e');
    }
  }

  @override
  Future<bool> snoozeReminder(String id, DateTime remindAt) async {
    if (id.isEmpty) return false;
    // Local guard, not a server one: the endpoint refuses a reminder in the
    // past, and finding that out through a parked outbox op minutes later is
    // no way to tell a user their snooze did not take.
    if (!remindAt.isAfter(DateTime.now())) return false;
    try {
      final TaskEntity? row = await (_database.select(_database.tasksTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) return false;
      final Object? counted = rowToTodo(row)['snoozeCount'];
      final Map<String, dynamic> todo = rowToTodo(row)
        ..['remindAt'] = remindAt.toIso8601String()
        ..['reminder'] = true
        ..['reminderFired'] = false
        // Chip 1060 counts itself. Device bookkeeping, not a server field:
        // the server acts on remind_at, not on how often it moved.
        ..['snoozeCount'] = (counted is num ? counted.toInt() : 0) + 1;
      final String clientId = _resolveClientId(row, todo);
      // dueDate is NOT in this write. A snooze moves the reminder and never
      // the deadline, and the surest way to keep that true is for the column
      // to be untouchable from this path.
      await (_database.update(_database.tasksTable)
            ..where((t) => t.id.equals(id)))
          .write(
        TasksTableCompanion(
          clientId: Value(clientId),
          data: Value(encodeTodoData(todo, row.id)),
          updatedAt: Value(DateTime.now()),
        ),
      );
      try {
        await TaskSyncQueue.queueSnooze(clientId: clientId, remindAt: remindAt);
      } catch (e) {
        debugPrint('Error queueing task snooze for $clientId: $e');
      }
      return true;
    } catch (e) {
      debugPrint('Error snoozing todo $id: $e');
      return false;
    }
  }

  @override
  Future<bool> syncNow() async {
    // Give any task that predates this device having client ids one, and
    // queue it, so a list that existed before sync was wired uploads itself
    // rather than waiting for each task to be edited.
    try {
      await _queueUnsynced();
    } catch (e) {
      debugPrint('Error queueing unsynced tasks: $e');
    }
    // Push first, then pull, so a task created a moment ago is on the server
    // before the pull that would otherwise not see it.
    try {
      await SyncEngine().kick();
    } catch (e) {
      debugPrint('Task push drain skipped: $e');
    }
    return await TaskPullService.pull() > 0;
  }

  /// Mints client ids for rows that have none and queues their first push.
  Future<void> _queueUnsynced() async {
    final List<TaskEntity> rows = await (_database.select(_database.tasksTable)
          ..where((t) => t.clientId.isNull()))
        .get();
    for (final TaskEntity row in rows) {
      final String clientId = TaskSyncStore.newClientId();
      final Map<String, dynamic> todo = rowToTodo(row)..['clientId'] = clientId;
      await (_database.update(_database.tasksTable)
            ..where((t) => t.id.equals(row.id)))
          .write(
        TasksTableCompanion(
          clientId: Value(clientId),
          data: Value(encodeTodoData(todo, row.id)),
        ),
      );
      await TaskSyncQueue.queueUpsert(clientId: clientId, todo: todo);
    }
  }

  /// Encodes the extra fields of one todo for the [TasksTable.data] column.
  ///
  /// A value the surface put on the map that json cannot encode would abort
  /// the surrounding transaction and lose the write for every task in the
  /// list, so one task's extras are dropped instead of all of them.
  ///
  /// Package-internal codec, for the same reason as [rowToTodo]: the sync
  /// store writes this blob too.
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

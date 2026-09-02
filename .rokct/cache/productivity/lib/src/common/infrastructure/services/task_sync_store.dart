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
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';

import '../repositories/todo_repository_impl.dart';
import '../../models/response/task_response.dart';

/// The local half of task sync: everything the push and pull paths need to
/// read from and write back to [TasksTable].
///
/// The counterpart of orders' `ManagerOrdersLocalStore` — the place the sync
/// path touches local state, so the handlers stay about the wire and the
/// repository stays about the surface.
///
/// EVERY method here is a local database call and nothing else. None of them
/// reaches the network, so none of them can fail because a backend is down.
/// That is the property the whole design rests on: the tasks list is a local
/// drift table first and a synced one second, and it behaves identically
/// when there is no server to sync with.
class TaskSyncStore {
  TaskSyncStore._();

  static const Uuid _uuid = Uuid();

  static AppDatabase get _db => AppDatabase();

  /// Box holding the incremental pull cursor.
  static const String cursorBox = 'productivity_task_sync';
  static const String cursorKey = 'pull_cursor';

  /// A fresh `client_id`.
  ///
  /// A plain uuid v4, deliberately NOT the engine's `offline:<uuid>` temp-id
  /// convention. The engine treats an `offline:` token as a temp id and
  /// rewrites it to the backend id inside every still-pending payload once
  /// it learns the mapping — which for a task would rewrite the `client_id`
  /// of a queued upsert into the server's `name`, and the next upsert would
  /// then key on the wrong value and create a DUPLICATE task. The handshake
  /// here is the same shape as an order's, but the id it hands over must
  /// stay the id the server upserts on, so it is kept out of that machinery
  /// on purpose.
  static String newClientId() => _uuid.v4();

  /// The row with this local [id], or null.
  static Future<TaskEntity?> rowById(String id) => (_db.select(
    _db.tasksTable,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  /// The row carrying this [clientId], or null.
  ///
  /// Takes the first match rather than insisting on exactly one. The column
  /// carries no uniqueness constraint - a caller that hands two tasks the
  /// same client id is doing something wrong, but it must not turn a
  /// reconciliation into a thrown error on a path nobody is waiting on.
  static Future<TaskEntity?> rowByClientId(String clientId) async {
    final List<TaskEntity> rows =
        await (_db.select(_db.tasksTable)
              ..where((t) => t.clientId.equals(clientId))
              ..limit(1))
            .get();
    return rows.isEmpty ? null : rows.first;
  }

  /// Writes [changes] onto the row carrying [clientId], merging [todoPatch]
  /// into its stored map. Returns whether a row was actually touched.
  ///
  /// A no-op when the task is gone locally — the user deleted it while the
  /// push was in flight, and resurrecting it would undo a deliberate act.
  static Future<bool> patchByClientId(
    String clientId, {
    String? remoteId,
    Map<String, dynamic> todoPatch = const <String, dynamic>{},
  }) async {
    final TaskEntity? row = await rowByClientId(clientId);
    if (row == null) return false;
    final Map<String, dynamic> todo = TodoRepositoryImpl.rowToTodo(row)
      ..addAll(todoPatch);
    await (_db.update(_db.tasksTable)..where((t) => t.id.equals(row.id))).write(
      TasksTableCompanion(
        // Absent, not null: an ack that carried no name must leave whatever
        // id the row already holds alone rather than clearing it.
        remoteId: remoteId == null ? const Value.absent() : Value(remoteId),
        data: Value(TodoRepositoryImpl.encodeTodoData(todo, row.id)),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return true;
  }

  /// Reconciles the handshake: the server's real id lands on the local row,
  /// alongside the reminder state the server owns.
  ///
  /// This is the temp-id to real-id step, done exactly where orders does it
  /// — in the handler's success path, against the local record — and it is
  /// the only thing the client learns from a successful push.
  static Future<bool> applyAck(TaskResponse ack) => patchByClientId(
    ack.clientId,
    remoteId: ack.name.isEmpty ? null : ack.name,
    todoPatch: <String, dynamic>{
      'remoteId': ack.name,
      'reminderFired': ack.reminderFired,
      if (ack.remindAt != null) 'remindAt': ack.remindAt!.toIso8601String(),
    },
  );

  /// Applies a snooze the server confirmed. `remind_at` and `reminder_fired`
  /// come back from the server rather than being assumed locally, because
  /// re-arming the one-shot latch happens inside `Task.validate_reminder`
  /// and only the server knows the result.
  ///
  /// The deadline is not written here AT ALL — not even to the value the
  /// response echoes — so this path structurally cannot move it.
  static Future<bool> applySnooze(TaskSnoozeResponse snooze) => patchByClientId(
    snooze.clientId,
    remoteId: snooze.name.isEmpty ? null : snooze.name,
    todoPatch: <String, dynamic>{
      'remindAt': snooze.remindAt?.toIso8601String(),
      'reminder': snooze.remindAt != null,
      'reminderFired': snooze.reminderFired,
    },
  );

  /// Writes one pulled task into the local store, creating the row when this
  /// device has never seen it (which is how a task typed on another handset
  /// arrives here).
  ///
  /// The local row id for a task first seen through a pull is its
  /// `client_id`: it is already a device-unique uuid, so every device ends
  /// up keying the same task the same way with nothing to negotiate.
  static Future<void> applyPulled(TaskResponse task) async {
    if (task.clientId.isEmpty) return;
    final TaskEntity? existing = await rowByClientId(task.clientId);
    final String id = existing?.id ?? task.clientId;
    final Map<String, dynamic> todo = task.toTodo(
      existing: existing == null
          ? null
          : TodoRepositoryImpl.rowToTodo(existing),
    );
    await _db
        .into(_db.tasksTable)
        .insertOnConflictUpdate(
          TasksTableCompanion.insert(
            id: Value(id),
            title: (todo['title'] ?? '').toString(),
            description: Value(todo['description']?.toString()),
            isCompleted: Value(task.isDone),
            dueDate: Value(task.deadline),
            createdAt: Value(existing?.createdAt ?? DateTime.now()),
            updatedAt: Value(DateTime.now()),
            createdBy: Value(existing?.createdBy),
            clientId: Value(task.clientId),
            remoteId: Value(task.name.isEmpty ? null : task.name),
            data: Value(TodoRepositoryImpl.encodeTodoData(todo, id)),
          ),
        );
  }

  /// The `modified_after` a pull should resume from, or null for a first
  /// full pull.
  static Future<String?> readCursor() async {
    final Map<String, dynamic>? record = await _db.getItem(
      cursorBox,
      cursorKey,
    );
    final Object? value = record?['modified_after'];
    final String text = (value ?? '').toString();
    return text.isEmpty ? null : text;
  }

  /// Stores the server clock the next pull resumes from, VERBATIM.
  ///
  /// The string the server sent is kept exactly as it arrived and handed
  /// straight back on the next call. Parsing it into a [DateTime] and
  /// re-formatting it would reinterpret a server-timezone stamp against the
  /// device's own clock, and a cursor that moves even a second the wrong way
  /// either replays or silently skips rows.
  static Future<void> writeCursor(String rawServerTime) => _db.putItem(
    cursorBox,
    cursorKey,
    <String, dynamic>{'modified_after': rawServerTime},
  );
}

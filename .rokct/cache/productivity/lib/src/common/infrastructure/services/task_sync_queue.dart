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

import 'dart:async';

import 'package:base_sdk/base_sdk.dart';
import 'package:flutter/foundation.dart';

import '../../application/sync/task_sync_state.dart';
import '../../models/request/task_request.dart';
import 'task_sync_handlers.dart';

/// Queues task pushes on the SyncEngine outbox. The counterpart of orders'
/// `PosSaleQueue`, and for the same reason Ray gave for it: the write is
/// local FIRST and the push rides the outbox, so a task NEVER blocks on the
/// network.
///
/// Every method here does exactly two local things — write a row to the
/// outbox table, then ask the engine to drain WITHOUT waiting for it. There
/// is no online branch and no offline branch: a device with a live backend
/// and a device that has never had one run the identical code, and the only
/// difference is how long the op sits in the outbox. That is what makes the
/// behaviour robust rather than conditionally robust.
///
/// Ops are queued with [SyncEngine.enqueueOrReplace] keyed on the task's
/// `client_id`, so a task edited ten times before it ever reaches a backend
/// costs one outbox row carrying the latest snapshot, not ten rows replaying
/// every intermediate state.
class TaskSyncQueue {
  TaskSyncQueue._();

  /// `sdk` column value for ops this SDK enqueues.
  static const String sdkName = 'productivity_sdk';

  /// Queue the upsert for one task. The payload is the full kwargs map
  /// `sync_personal_task` takes, so the op is a self-contained snapshot that
  /// still means the right thing whenever it eventually drains.
  static Future<String> queueUpsert({
    required String clientId,
    required Map<String, dynamic> todo,
  }) async {
    final String opId = await SyncEngine().enqueueOrReplace(
      opType: TaskUpsertSyncHandler.opType,
      sdk: sdkName,
      dedupeKey: clientId,
      payload: TaskRequest.fromTodo(todo, clientId).toJson(),
    );
    _kick();
    return opId;
  }

  /// Queue the delete for one task.
  static Future<String> queueDelete(String clientId) async {
    final String opId = await SyncEngine().enqueueOrReplace(
      opType: TaskDeleteSyncHandler.opType,
      sdk: sdkName,
      dedupeKey: clientId,
      payload: <String, dynamic>{'client_id': clientId},
    );
    _kick();
    return opId;
  }

  /// Queue a snooze: a new reminder time, and nothing else.
  ///
  /// Routed through `snooze_task_reminder` rather than folded into the
  /// upsert because that endpoint is the one that PROMISES the deadline is
  /// untouched and re-arms the fired latch as a consequence of the move. The
  /// payload carries no deadline field at all, so this op could not move one
  /// even if the server let it.
  static Future<String> queueSnooze({
    required String clientId,
    required DateTime remindAt,
  }) async {
    final String opId = await SyncEngine().enqueueOrReplace(
      opType: TaskSnoozeSyncHandler.opType,
      sdk: sdkName,
      dedupeKey: clientId,
      payload: <String, dynamic>{
        'client_id': clientId,
        'remind_at': frappeDateTime(remindAt),
      },
    );
    _kick();
    return opId;
  }

  /// The outbox id [SyncEngine.enqueueOrReplace] gives an op of [opType] for
  /// [clientId]. Deterministic by construction, which is what lets the pull
  /// ask "is this task still waiting to be pushed?" with one indexed lookup
  /// instead of scanning payloads.
  static String opIdFor(String opType, String clientId) => '$opType:$clientId';

  /// Whether this task still has an unsent local change.
  ///
  /// A pull must not overwrite a row in that state: the device's edit has
  /// not reached the server yet, so the server's copy is the STALE one and
  /// applying it would silently undo what the user just did.
  static Future<bool> hasPendingFor(String clientId) async {
    final AppDatabase db = AppDatabase();
    final List<String> ids = <String>[
      opIdFor(TaskUpsertSyncHandler.opType, clientId),
      opIdFor(TaskDeleteSyncHandler.opType, clientId),
      opIdFor(TaskSnoozeSyncHandler.opType, clientId),
    ];
    final List<OutboxEntry> rows =
        await (db.select(db.outboxTable)
              ..where((OutboxTable t) => t.id.isIn(ids))
              ..limit(1))
            .get();
    return rows.isNotEmpty;
  }

  /// Section 47n: where each task stands with the server, in ONE query.
  ///
  /// [remoteIdByClientId] maps a task's `client_id` to whether its row
  /// already carries the server's id. The answer is derived by
  /// [taskSyncStateFor] from that and from any outbox row still queued for
  /// the task; a task with no queued row and no remote id is "this device",
  /// which is the permanent, correct state on a device with no backend.
  static Future<Map<String, TaskSyncState>> statesFor(
    Map<String, bool> remoteIdByClientId,
  ) async {
    final Map<String, TaskSyncState> states = <String, TaskSyncState>{};
    if (remoteIdByClientId.isEmpty) return states;
    final Map<String, String> clientIdByOpId = <String, String>{};
    for (final String clientId in remoteIdByClientId.keys) {
      for (final String opType in <String>[
        TaskUpsertSyncHandler.opType,
        TaskDeleteSyncHandler.opType,
        TaskSnoozeSyncHandler.opType,
      ]) {
        clientIdByOpId[opIdFor(opType, clientId)] = clientId;
      }
    }
    final Map<String, OutboxStatus?> queued = <String, OutboxStatus?>{};
    try {
      final AppDatabase db = AppDatabase();
      final List<OutboxEntry> rows =
          await (db.select(db.outboxTable)
                ..where((OutboxTable t) => t.id.isIn(clientIdByOpId.keys)))
              .get();
      for (final OutboxEntry row in rows) {
        final String? clientId = clientIdByOpId[row.id];
        if (clientId == null) continue;
        final OutboxStatus? status = parseOutboxStatus(row.status);
        // A failure outranks a queued sibling op: the badge names the
        // thing a person has to resolve.
        final OutboxStatus? current = queued[clientId];
        if (current == null ||
            status == OutboxStatus.failed ||
            status == OutboxStatus.dead ||
            (status == OutboxStatus.inFlight && current == OutboxStatus.pending)) {
          queued[clientId] = status;
        }
      }
    } catch (e) {
      // No outbox to read (a host without the sync tables): every task is
      // on this device, which is exactly what the badge will say.
      debugPrint('==> task sync states unavailable: $e');
    }
    for (final MapEntry<String, bool> entry in remoteIdByClientId.entries) {
      states[entry.key] = taskSyncStateFor(
        hasRemoteId: entry.value,
        queued: queued[entry.key],
      );
    }
    return states;
  }

  /// Drops a queued upsert that is about to become meaningless.
  ///
  /// Used when a task is deleted before its create ever reached the server:
  /// pushing the create and then the delete would be two doomed round trips
  /// and a guaranteed 404 parked in the sync-issues list, when in truth the
  /// backend never heard of the task at all.
  static Future<bool> dropQueuedUpsert(String clientId) =>
      SyncEngine().deleteOp(opIdFor(TaskUpsertSyncHandler.opType, clientId));

  /// Ask the engine to drain, and DO NOT WAIT FOR IT.
  ///
  /// This is the line that keeps a task write off the network. `kick` reads
  /// the outbox and calls handlers that do real HTTP; awaiting it here would
  /// put a round trip — or a connection timeout — inside the user's save.
  /// Unawaited, a save is a local database write and nothing more, and the
  /// push happens whenever it happens.
  static void _kick() {
    // The error arm matters as much as the unawaited call: a future nobody
    // is holding that completes with an error is an unhandled error in the
    // enclosing zone, and a queueing helper must not be able to take the app
    // down on behalf of a push that failed.
    unawaited(
      SyncEngine().kick().catchError((Object error) {
        debugPrint('==> task sync drain failed: $error');
      }),
    );
  }
}

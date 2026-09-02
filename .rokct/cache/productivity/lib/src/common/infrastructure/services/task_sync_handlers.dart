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

import 'package:base_sdk/base_sdk.dart';
import 'package:flutter/foundation.dart';

import '../../models/response/task_response.dart';
import 'task_sync_store.dart';

/// Gateway command names, as the manifest routes them.
///
/// `projects/frappe/manifest.json` registers
/// `{app_name}.api.projects.<method>`; the platform gateway drops the leading
/// app segment and resolves the rest against the composed app's whitelist,
/// exactly as orders' `api.order.create_order` does.
const String _kSyncTaskCmd = 'api.projects.sync_personal_task';
const String _kDeleteTaskCmd = 'api.projects.delete_personal_task';
const String _kSnoozeTaskCmd = 'api.projects.snooze_task_reminder';

/// Classifies a thrown gateway error the way orders' `OrderCreateSyncHandler`
/// does: `getDioStatus` maps connection failures and timeouts to 500, so
/// >= 500 (plus 408) is transient and retried, while a concrete 4xx is the
/// backend having actually said no and is parked for the user.
SyncResult _classify(Object error) {
  final int status = NetworkExceptions.getDioStatus(error);
  final String message = AppHelpers.errorHandler(error);
  if (status >= 400 && status < 500 && status != 408) {
    return SyncResult.rejected(message);
  }
  return SyncResult.retryable(message);
}

Map<String, dynamic>? _decode(String payload) {
  try {
    final Object? decoded = jsonDecode(payload);
    return decoded is Map ? decoded.cast<String, dynamic>() : null;
  } catch (_) {
    return null;
  }
}

Map<String, dynamic> _asMap(Object? response) =>
    response is Map ? response.cast<String, dynamic>() : <String, dynamic>{};

/// Pushes `task.upsert` ops: a task created or edited on the device — very
/// possibly with no network in sight — is created or updated for real the
/// next time the engine drains.
///
/// This is the temp-id to real-id handshake, the same one orders runs for a
/// temp order: the task is born on the device with a locally minted
/// `client_id`, that id travels with every push, and the server upserts on
/// it and hands back its own `name`, which [TaskSyncStore.applyAck] writes
/// onto the local row.
///
/// No idempotency-key header is sent, and that is not an omission. The whole
/// point of `client_id` is that the server call IS idempotent: a retry after
/// an ambiguous failure updates the same Task rather than creating a second
/// one, which is the property an idempotency key would otherwise have to buy.
class TaskUpsertSyncHandler extends SyncHandler {
  /// Op type this handler serves.
  static const String opType = 'task.upsert';

  @override
  Future<SyncResult> push(OutboxEntry op) async {
    final Map<String, dynamic>? payload = _decode(op.payload);
    if (payload == null) {
      return const SyncResult.rejected('task.upsert payload unreadable');
    }
    final String clientId = (payload['client_id'] ?? '').toString();
    if (clientId.isEmpty) {
      return const SyncResult.rejected('task.upsert op missing client_id');
    }
    try {
      final Object? response = await const PlatformGateway().call(
        _kSyncTaskCmd,
        payload: payload,
      );
      final TaskResponse ack = TaskResponse.fromMap(_asMap(response));
      await TaskSyncStore.applyAck(ack);
      // No idMappings. The engine would store them and then rewrite every
      // still-pending payload that contains the key — which for a task means
      // rewriting a queued upsert's `client_id` into the server's `name`,
      // after which the next upsert keys on the wrong value and DUPLICATES
      // the task. The handshake is reconciled above, against the local row,
      // which is where it belongs.
      return const SyncResult.synced();
    } catch (e) {
      return _classify(e);
    }
  }
}

/// Pushes `task.delete` ops.
class TaskDeleteSyncHandler extends SyncHandler {
  static const String opType = 'task.delete';

  @override
  Future<SyncResult> push(OutboxEntry op) async {
    final Map<String, dynamic>? payload = _decode(op.payload);
    final String clientId = (payload?['client_id'] ?? '').toString();
    if (clientId.isEmpty) {
      return const SyncResult.rejected('task.delete op missing client_id');
    }
    try {
      await const PlatformGateway().call(
        _kDeleteTaskCmd,
        payload: <String, dynamic>{'client_id': clientId},
      );
      return const SyncResult.synced();
    } catch (e) {
      // `delete_personal_task` throws DoesNotExistError when no task of the
      // caller's matches. For a delete that is the goal state, not a
      // failure: the row is gone either way, and parking it would put an
      // error in front of the user for work that is already done.
      if (NetworkExceptions.getDioStatus(e) == 404) {
        return const SyncResult.synced();
      }
      return _classify(e);
    }
  }
}

/// Pushes `task.snooze` ops through `snooze_task_reminder`.
///
/// The endpoint moves `remind_at` and re-arms `reminder_fired`, and does not
/// touch `exp_end_date`. It echoes the deadline and a `deadline_moved` flag
/// back precisely so a client can assert that rather than trust it, and this
/// handler does assert it.
class TaskSnoozeSyncHandler extends SyncHandler {
  static const String opType = 'task.snooze';

  @override
  Future<SyncResult> push(OutboxEntry op) async {
    final Map<String, dynamic>? payload = _decode(op.payload);
    final String clientId = (payload?['client_id'] ?? '').toString();
    final String remindAt = (payload?['remind_at'] ?? '').toString();
    if (clientId.isEmpty || remindAt.isEmpty) {
      return const SyncResult.rejected(
        'task.snooze op missing client_id or remind_at',
      );
    }
    try {
      final Object? response = await const PlatformGateway().call(
        _kSnoozeTaskCmd,
        payload: <String, dynamic>{
          'client_id': clientId,
          'remind_at': remindAt,
        },
      );
      final TaskSnoozeResponse snooze = TaskSnoozeResponse.fromMap(
        _asMap(response),
      );
      if (snooze.deadlineMoved) {
        // The server says it moved the deadline. It is not supposed to be
        // able to, so the local copy is NOT updated from this response —
        // better a reminder that did not move than a deadline that did.
        debugPrint(
          '==> task snooze moved the deadline for $clientId; not applying',
        );
        return const SyncResult.rejected(
          'snooze moved the deadline; reminder not applied',
        );
      }
      await TaskSyncStore.applySnooze(snooze);
      return const SyncResult.synced();
    } catch (e) {
      return _classify(e);
    }
  }
}

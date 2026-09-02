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

// Design strip section 47n — the local-until-synced reminder, as the three
// states a task can be in plus the parked failure, DERIVED from what the
// device actually holds.
//
// There is no synced flag anywhere, and this file does not invent one.
// The outbox has pending / inFlight / failed / dead, and a pushed row is
// DELETED — its absence is the success signal (outbox_table.dart). So
// "the server knows" is read from two facts: no outbox row for the task,
// and the server's id on the local row. Every other combination is one of
// the honest in-between states.
//
// Pure Dart, no store: the queue looks the rows up and hands the facts
// here; the badge only draws the answer.

import 'package:base_sdk/src/sync/outbox_table.dart';

/// Where one task stands with the server.
enum TaskSyncState {
  /// Chip 1066: the task exists on this phone and the reminder will fire
  /// here and nowhere else. Either no push has been attempted yet, or the
  /// device has never had a server to push to.
  thisDevice,

  /// Chip 1067: the push is running. Nothing has changed for the user yet,
  /// and the badge must not promise multi-device delivery it cannot make.
  syncing,

  /// Chip 1068: the outbox row is gone and the server's id is on the local
  /// row. The backend has it and will remind on every device.
  synced,

  /// The push was rejected and parked for a person to resolve. Drawn
  /// because a reminder that quietly stops existing is worse than one that
  /// never synced.
  failed,
}

/// Derives the state from the two facts the device holds: whether the row
/// carries the server's id, and the status of any outbox op still queued
/// for it (null when none is).
TaskSyncState taskSyncStateFor({
  required bool hasRemoteId,
  OutboxStatus? queued,
}) {
  switch (queued) {
    case OutboxStatus.failed:
    case OutboxStatus.dead:
      return TaskSyncState.failed;
    case OutboxStatus.inFlight:
      return TaskSyncState.syncing;
    case OutboxStatus.pending:
      return TaskSyncState.thisDevice;
    case null:
      return hasRemoteId ? TaskSyncState.synced : TaskSyncState.thisDevice;
  }
}

/// Parses the outbox's status column, which stores the enum's name. An
/// unknown value (a future status this build does not know) reads as
/// pending — the safe reading is "still on this device".
OutboxStatus? parseOutboxStatus(String? name) {
  if (name == null || name.isEmpty) return null;
  for (final OutboxStatus status in OutboxStatus.values) {
    if (status.name == name) return status;
  }
  return OutboxStatus.pending;
}

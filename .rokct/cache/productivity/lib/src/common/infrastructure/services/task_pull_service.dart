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

import '../../models/response/task_response.dart';
import 'task_sync_queue.dart';
import 'task_sync_store.dart';

/// The pull half of task sync: `list_personal_tasks`, applied to the local
/// store.
///
/// This is what makes a task typed on one device show up on another. The
/// pull is incremental — it resumes from the server clock the previous pull
/// returned — so a device that already holds everything asks only for what
/// changed since.
///
/// NOTHING on a user-facing path waits for this. [pull] is called
/// unawaited; when it fails, because the device is on a train or has never
/// had a backend at all, it returns 0 and the local list is exactly what it
/// was. There is no offline branch here because there is nothing to branch
/// on: the local store already holds the answer either way.
///
/// A failure is NOT silent, though. It used to be: the catch dropped the
/// error on the floor, so a dead or uncomposed backend produced no
/// telemetry and no visible state at all. Now every failed pull does two
/// things before returning 0: it records a [TaskPullFailure] on
/// [lastFailure], which the tasks page watches, and it emits one event on
/// base_sdk's error lane ([TelemetryClient.logError]) carrying the gateway
/// cmd and the error's CLASS — never its text, which can hold a URL, a
/// token or server-authored copy.
class TaskPullService {
  TaskPullService._();

  /// Command name; see the note in `task_sync_handlers.dart`.
  static const String _cmd = 'api.projects.list_personal_tasks';

  /// Telemetry event type for a failed pull (the error lane's `type`).
  static const String failureEventType = 'task_pull_failed';

  /// The last pull's failure, or null while the last pull succeeded — or
  /// none has run yet. A [ValueNotifier] rather than a bare flag so the
  /// page can redraw when the answer changes without polling for it.
  /// Cleared by the next pull that completes.
  static final ValueNotifier<TaskPullFailure?> lastFailure =
      ValueNotifier<TaskPullFailure?>(null);

  /// Whether the last pull failed. Read by the tasks page's empty state.
  static bool get syncFailed => lastFailure.value != null;

  /// The server's own cap. Asking for more is silently clamped, so this
  /// mirrors it rather than pretending otherwise.
  static const int pageLimit = 200;

  /// Pull changed tasks and apply them locally. Returns how many rows were
  /// actually written, so a caller can decide whether a reload is worth it.
  ///
  /// Never throws: an unreachable backend is the ordinary case, not an
  /// error the caller has to handle. It is still an error the caller can
  /// SEE: a failure lands on [lastFailure] as a typed [TaskPullFailure]
  /// and in telemetry before this returns 0.
  static Future<int> pull() async {
    try {
      final String? cursor = await TaskSyncStore.readCursor();
      final Object? response = await const PlatformGateway().call(
        _cmd,
        payload: <String, dynamic>{
          if (cursor != null) 'modified_after': cursor,
          'limit': pageLimit,
        },
      );
      final TaskListResponse page = TaskListResponse.fromMap(
        response is Map
            ? response.cast<String, dynamic>()
            : <String, dynamic>{},
      );

      int applied = 0;
      for (final TaskResponse task in page.tasks) {
        if (task.clientId.isEmpty) continue;
        // A task with an unsent local change is skipped, not overwritten.
        // The device's edit has not reached the server yet, so the server's
        // copy is the stale one; applying it would silently undo what the
        // user just did. The queued op carries the newer state and will
        // settle it.
        if (await TaskSyncQueue.hasPendingFor(task.clientId)) continue;
        await TaskSyncStore.applyPulled(task);
        applied++;
      }

      // The cursor moves only after the page has been applied. Moving it
      // first would lose every row in a page that failed halfway.
      if (page.rawServerTime != null) {
        await TaskSyncStore.writeCursor(page.rawServerTime!);
      }
      lastFailure.value = null;
      return applied;
    } catch (e) {
      final TaskPullFailure failure = TaskPullFailure(
        cmd: _cmd,
        errorClass: e.runtimeType.toString(),
      );
      // Local trail only — the full error never leaves the device.
      debugPrint('==> task pull failed (${failure.errorClass}): $e');
      lastFailure.value = failure;
      // The same fire-and-forget shape as every other telemetry call in
      // this SDK: logError never throws, and nothing here waits on the
      // network a second time to say the network is down.
      unawaited(
        TelemetryClient.I.logError(
          type: failureEventType,
          context: <String, dynamic>{
            'cmd': failure.cmd,
            'error_class': failure.errorClass,
          },
        ),
      );
      return 0;
    }
  }
}

/// Why the last pull failed. Carries the gateway cmd and the error's type
/// name and deliberately nothing else: no message, no stack, no payload.
/// This is what telemetry receives and what the page may react to, and
/// neither is allowed to see more than this.
@immutable
class TaskPullFailure {
  const TaskPullFailure({required this.cmd, required this.errorClass});

  /// The gateway cmd the pull was issued under.
  final String cmd;

  /// `runtimeType.toString()` of what was caught — the class, never the
  /// text.
  final String errorClass;

  @override
  String toString() => 'TaskPullFailure($cmd: $errorClass)';
}

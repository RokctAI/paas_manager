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
class TaskPullService {
  TaskPullService._();

  /// Command name; see the note in `task_sync_handlers.dart`.
  static const String _cmd = 'api.projects.list_personal_tasks';

  /// The server's own cap. Asking for more is silently clamped, so this
  /// mirrors it rather than pretending otherwise.
  static const int pageLimit = 200;

  /// Pull changed tasks and apply them locally. Returns how many rows were
  /// actually written, so a caller can decide whether a reload is worth it.
  ///
  /// Never throws: an unreachable backend is the ordinary case, not an
  /// error the caller has to handle.
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
      return applied;
    } catch (e) {
      debugPrint('==> task pull skipped: $e');
      return 0;
    }
  }
}

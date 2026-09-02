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

// compliance-ignore-file: obs-flutter-trace (abstract facade interface; no HTTP calls in this file — flagged only by the repository/service filename heuristic)

abstract class TodoRepositoryFacade {
  /// Loads tasks from local storage
  Future<List<Map<String, dynamic>>> loadTodos();

  /// Saves the current list of tasks to local storage
  Future<void> saveTodos(List<Map<String, dynamic>> todos);

  /// Deletes one task from local storage by id.
  ///
  /// Deletion is its own operation rather than a side effect of [saveTodos]:
  /// the tasks surface is not the only writer of the underlying table, so a
  /// save that pruned every row absent from its list would delete rows that
  /// belong to another writer. Naming the id keeps the write to the one row
  /// the caller actually removed.
  Future<void> deleteTodo(String id);

  /// Exports the tasks to a file and triggers a share dialog
  Future<void> exportTodos(List<Map<String, dynamic>> todos);

  /// Moves one task's reminder to [remindAt] and NEVER its deadline.
  ///
  /// That separation is the whole reason the server keeps `remind_at` in its
  /// own column: pushing Saturday's reminder to Sunday has not renegotiated
  /// when the work is due. The push goes through `snooze_task_reminder`,
  /// which makes the same promise and echoes back a `deadline_moved` flag
  /// for the client to assert.
  ///
  /// Returns whether the snooze was applied locally. False for an unknown
  /// task or a time already past - never for an unreachable backend, which
  /// this call does not wait on.
  Future<bool> snoozeReminder(String id, DateTime remindAt);

  /// Drains queued task pushes and pulls whatever changed on the server into
  /// the local store. Returns whether the pull actually wrote anything, so a
  /// caller can decide whether a reload is worth doing.
  ///
  /// OPTIONAL BY DESIGN, and safe to never call. Nothing else here depends
  /// on it: [loadTodos] answers from the local store whether or not this has
  /// ever succeeded, and this call swallows an unreachable backend rather
  /// than surfacing one. It is what makes a task typed on ANOTHER device
  /// appear on this one.
  Future<bool> syncNow();
}

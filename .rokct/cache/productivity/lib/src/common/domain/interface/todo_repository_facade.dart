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
}

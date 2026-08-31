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

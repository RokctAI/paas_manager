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

import 'package:productivity_sdk/src/common/presentation/tasks/task_view_model.dart';

/// Which status filter the tasks list opens on — Ray, on the launcher's
/// Tasks page: "when thereis completed task switch from all to pending".
///
/// DERIVED, NEVER REMEMBERED. There is no stored preference behind this and
/// deliberately so: the answer is a fact about the list as it stands when
/// the page loads, so a device whose tasks are all still open opens on All
/// exactly as it always did, and one carrying finished work opens on the
/// work that is left. A persisted choice would outlive the list it was
/// right about.
///
/// AND NEVER OVER THE READER. The rule chooses an INITIAL value. Once the
/// reader has touched the tabs the page stops asking — see the caller's
/// touched flag — because a filter that keeps resetting itself is worse
/// than one that starts in the wrong place.
abstract final class InitialStatusFilter {
  /// The filter for a list holding [completedCount] completed tasks.
  ///
  /// Pure, and takes the count rather than the list, so the rule can be
  /// pinned without building a task map: the page derives the count from
  /// the same `isDone` field the tabs themselves count.
  static TaskStatusFilter forCompletedCount(int completedCount) =>
      completedCount > 0 ? TaskStatusFilter.pending : TaskStatusFilter.all;

  /// The rule applied to the task maps the /tasks surface holds.
  ///
  /// `isDone` is compared against `true` rather than read as a bool for the
  /// same reason every other reader on this surface does: the map is
  /// `Map<String, dynamic>` and a pulled or hand-edited row can carry
  /// anything at all in that key.
  static TaskStatusFilter forTodos(Iterable<Map<String, dynamic>> todos) =>
      forCompletedCount(todos.where((t) => t['isDone'] == true).length);
}

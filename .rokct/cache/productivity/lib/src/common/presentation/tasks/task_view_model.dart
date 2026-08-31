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

// The shipped /tasks page stores each task as an untyped
// `Map<String, dynamic>` and each subtask as another one. Design strip
// section 44 draws real components over that data, and a component that
// takes a raw map cannot be type-checked or sanely tested — so these two
// small value types sit between them.
//
// THEY ADD NO FIELDS. Every field below already exists in the shipped
// page's task map (`tasks_page.dart` `_saveTask`) or in `TasksTable`:
// id, title, isDone, deadline, reminder, priority, category, recurrence,
// createdAt, subtasks. Nothing is invented, and nothing is dropped —
// `notifId` stays on the map because it is storage bookkeeping, not
// something a card draws.

/// One entry of a task's `subtasks` list.
class SubtaskViewModel {
  const SubtaskViewModel({required this.title, this.isDone = false});

  final String title;
  final bool isDone;

  factory SubtaskViewModel.fromMap(Map<String, dynamic> map) =>
      SubtaskViewModel(
        title: '${map['title'] ?? ''}',
        isDone: map['isDone'] == true,
      );
}

/// One task, as the section-44 components read it.
class TaskViewModel {
  const TaskViewModel({
    required this.id,
    required this.title,
    this.isDone = false,
    this.deadline,
    this.hasReminder = false,
    this.priority = 'Medium',
    this.category,
    this.recurrence = 'None',
    this.createdAt,
    this.subtasks = const [],
  });

  final String id;
  final String title;
  final bool isDone;
  final DateTime? deadline;
  final bool hasReminder;

  /// One of Low / Medium / High — the shipped `_priorities` list.
  final String priority;

  final String? category;

  /// One of None / Daily / Weekly / Monthly — the shipped `_recurrences`.
  ///
  /// FLAG (b), STAMPED ON FRAME 44b AND STILL TRUE: this is STORED and
  /// NOTHING EVER ACTS ON IT. There is no scheduler, no rollover and no
  /// next-instance creation anywhere in the SDK, so a task marked Daily
  /// is a label. It is drawn because the field is real; it is flagged
  /// because the field does nothing.
  final String recurrence;

  final DateTime? createdAt;
  final List<SubtaskViewModel> subtasks;

  /// DERIVED, never read from a field — the same honesty rule section 41
  /// applied to mastery goals. There is no progress column to read.
  int get subtasksDone => subtasks.where((s) => s.isDone).length;

  bool get hasSubtasks => subtasks.isNotEmpty;

  /// 0..1, or null when there is nothing to derive it from.
  double? get subtaskProgress =>
      subtasks.isEmpty ? null : subtasksDone / subtasks.length;

  factory TaskViewModel.fromMap(Map<String, dynamic> map) {
    DateTime? parse(dynamic value) {
      if (value is DateTime) return value;
      if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
      return null;
    }

    return TaskViewModel(
      id: '${map['id'] ?? ''}',
      title: '${map['title'] ?? ''}',
      isDone: map['isDone'] == true,
      deadline: parse(map['deadline']),
      hasReminder: map['reminder'] == true,
      priority: '${map['priority'] ?? 'Medium'}',
      category: (map['category'] as String?)?.trim().isEmpty ?? true
          ? null
          : '${map['category']}',
      recurrence: '${map['recurrence'] ?? 'None'}',
      createdAt: parse(map['createdAt']),
      subtasks: List<Map<String, dynamic>>.from(
        map['subtasks'] ?? const [],
      ).map(SubtaskViewModel.fromMap).toList(),
    );
  }
}

/// The three sort values the shipped page offers, and no more — which is
/// exactly why chip 827 promotes them from a dropdown to a segment.
enum TaskSort { created, deadline, priority }

/// The three status filters the shipped page offers.
enum TaskStatusFilter { all, pending, completed }

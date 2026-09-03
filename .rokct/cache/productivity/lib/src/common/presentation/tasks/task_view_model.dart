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

// The shipped /tasks page stores each task as an untyped
// `Map<String, dynamic>` and each subtask as another one. Design strip
// section 44 draws real components over that data, and a component that
// takes a raw map cannot be type-checked or sanely tested — so these two
// small value types sit between them.
//
// THEY ADD NO FIELDS. Every field below already exists in the shipped
// page's task map (`tasks_page.dart` `_saveTask`), in `TasksTable`, or in
// the sync contract (`task_request.dart` / `task_response.dart`): id,
// title, isDone, deadline, reminder, remindAt, reminderFired, snoozeCount,
// priority, category, recurrence, isLongTerm, stepsAreSequential,
// strategicObjective (+ the strategicObjectiveTitle / -Pillar display
// pair the surface keeps beside it), createdAt, clientId, remoteId,
// subtasks — and on a subtask title,
// isDone, instruction, durationSeconds, startedAt, completedAt. Nothing is
// invented, and nothing is dropped — `notifId` stays on the map because it
// is storage bookkeeping, not something a card draws.

import 'package:productivity_sdk/src/common/application/run/task_run.dart';

/// One entry of a task's `subtasks` list.
class SubtaskViewModel {
  const SubtaskViewModel({
    required this.title,
    this.isDone = false,
    this.instruction,
    this.durationSeconds = 0,
    this.startedAt,
    this.completedAt,
  });

  final String title;
  final bool isDone;

  /// Section 46: the four generic step fields. A subtask IS a step.
  final String? instruction;
  final int durationSeconds;
  final DateTime? startedAt;
  final DateTime? completedAt;

  bool get isTimed => durationSeconds > 0;

  bool get hasInstruction => (instruction ?? '').trim().isNotEmpty;

  /// The sub-line a check line draws under the title: the instruction and
  /// the duration, whichever are set. Empty when neither is.
  String get detailLine {
    final List<String> parts = <String>[
      if (isTimed) formatRunDuration(Duration(seconds: durationSeconds)),
      if (hasInstruction) instruction!.trim(),
    ];
    return parts.join(' · ');
  }

  factory SubtaskViewModel.fromMap(Map<String, dynamic> map) {
    final TaskRunStep step = TaskRunStep.fromMap(map);
    return SubtaskViewModel(
      title: step.title,
      isDone: step.isDone,
      instruction: step.instruction,
      durationSeconds: step.durationSeconds,
      startedAt: step.startedAt,
      completedAt: step.completedAt,
    );
  }
}

/// One task, as the section-44 components read it.
class TaskViewModel {
  const TaskViewModel({
    required this.id,
    required this.title,
    this.isDone = false,
    this.deadline,
    this.hasReminder = false,
    this.remindAt,
    this.reminderFired = false,
    this.snoozeCount = 0,
    this.priority = 'Medium',
    this.category,
    this.recurrence = 'None',
    this.isLongTerm = false,
    this.stepsAreSequential = false,
    this.strategicObjective,
    this.strategicObjectiveTitle,
    this.strategicObjectivePillar,
    this.createdAt,
    this.clientId,
    this.remoteId,
    this.subtasks = const [],
  });

  final String id;
  final String title;
  final bool isDone;
  final DateTime? deadline;
  final bool hasReminder;

  /// Section 47k: when the reminder fires — a value of its own, separate
  /// from [deadline]. Null means "at the deadline" (never snoozed).
  final DateTime? remindAt;

  /// The server's one-shot latch, echoed back by the handshake.
  final bool reminderFired;

  /// Chip 1060 counts itself: how many times this reminder has been pushed.
  final int snoozeCount;

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

  /// Section 47m: kept in the long-term band above the day's work. A
  /// property of the task, set by hand — nothing derives it.
  final bool isLongTerm;

  /// Section 46: the subtasks are steps in order.
  final bool stepsAreSequential;

  /// Frame 44c — the M2 bridge: the `Strategic Objective` name this task
  /// is linked to, or null. The typed column on the server.
  final String? strategicObjective;

  /// The linked objective's title and pillar title as they read when the
  /// link was made: display bookkeeping kept on the map (the server holds
  /// only the name, and a Frappe name is a hash). Null on a device that
  /// pulled the link and has not opened the picker since; chip 833 falls
  /// back to the name then.
  final String? strategicObjectiveTitle;
  final String? strategicObjectivePillar;

  bool get hasStrategicObjective => (strategicObjective ?? '').isNotEmpty;

  final DateTime? createdAt;

  /// The sync ids, read off the columns. [remoteId] present means the
  /// server has this task.
  final String? clientId;
  final String? remoteId;

  final List<SubtaskViewModel> subtasks;

  /// DERIVED, never read from a field — the same honesty rule section 41
  /// applied to mastery goals. There is no progress column to read.
  int get subtasksDone => subtasks.where((s) => s.isDone).length;

  bool get hasSubtasks => subtasks.isNotEmpty;

  /// 0..1, or null when there is nothing to derive it from.
  double? get subtaskProgress =>
      subtasks.isEmpty ? null : subtasksDone / subtasks.length;

  /// The moment the reminder will fire: a snoozed time, else the deadline.
  DateTime? get effectiveRemindAt => remindAt ?? deadline;

  /// The subtasks read as a run — the derivation chip 859 draws from.
  TaskRun get run => TaskRun(
    steps: <TaskRunStep>[
      for (final SubtaskViewModel s in subtasks)
        TaskRunStep(
          title: s.title,
          instruction: s.instruction,
          durationSeconds: s.durationSeconds,
          startedAt: s.startedAt,
          completedAt: s.completedAt,
          isDone: s.isDone,
        ),
    ],
    sequential: stepsAreSequential,
  );

  factory TaskViewModel.fromMap(Map<String, dynamic> map) {
    DateTime? parse(dynamic value) {
      if (value is DateTime) return value;
      if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
      return null;
    }

    int count(dynamic value) {
      if (value is num) return value < 0 ? 0 : value.toInt();
      return int.tryParse('${value ?? ''}') ?? 0;
    }

    String? text(dynamic value) {
      final String trimmed = (value ?? '').toString().trim();
      return trimmed.isEmpty ? null : trimmed;
    }

    return TaskViewModel(
      id: '${map['id'] ?? ''}',
      title: '${map['title'] ?? ''}',
      isDone: map['isDone'] == true,
      deadline: parse(map['deadline']),
      hasReminder: map['reminder'] == true,
      remindAt: parse(map['remindAt']),
      reminderFired: map['reminderFired'] == true,
      snoozeCount: count(map['snoozeCount']),
      priority: '${map['priority'] ?? 'Medium'}',
      category: (map['category'] as String?)?.trim().isEmpty ?? true
          ? null
          : '${map['category']}',
      recurrence: '${map['recurrence'] ?? 'None'}',
      isLongTerm: map['isLongTerm'] == true,
      stepsAreSequential: map['stepsAreSequential'] == true,
      strategicObjective: text(map['strategicObjective']),
      strategicObjectiveTitle: text(map['strategicObjectiveTitle']),
      strategicObjectivePillar: text(map['strategicObjectivePillar']),
      createdAt: parse(map['createdAt']),
      clientId: (map['clientId'] as String?)?.isEmpty ?? true
          ? null
          : '${map['clientId']}',
      remoteId: (map['remoteId'] as String?)?.isEmpty ?? true
          ? null
          : '${map['remoteId']}',
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

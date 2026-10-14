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

import '../run/task_run.dart';
import 'long_term_rule.dart';

/// The next occurrence of a repeating task, built when the task is ticked.
///
/// Shared by the tasks workspace and the standalone `/tasks/run` page, so
/// both make the same next instance. Scheduling its reminder stays with the
/// caller: device notifications belong to the host, not to this SDK.
abstract final class TaskRecurrence {
  /// The key that records, on the ticked task, the id of the next instance
  /// it already spawned.
  static const String spawnedNextIdKey = 'spawnedNextId';

  /// Builds the next instance of [task], or returns null when there is
  /// none: no recurrence, no deadline, or one was ALREADY spawned. That
  /// last case is what stops untick-and-tick-again from making a second
  /// copy (and a second reminder) every time. On success the new id is
  /// written onto [task] under [spawnedNextIdKey], so the caller saves
  /// both maps; unticking leaves the spawned instance where it is.
  static Map<String, dynamic>? spawnNext(
    Map<String, dynamic> task, {
    required String newId,
    required int notifId,
    DateTime? now,
  }) {
    final String recurrence = (task['recurrence'] ?? 'None').toString();
    final DateTime? currentDeadline = DateTime.tryParse(
      '${task['deadline'] ?? ''}',
    );
    if (recurrence == 'None' || currentDeadline == null) return null;
    if ('${task[spawnedNextIdKey] ?? ''}'.isNotEmpty) return null;

    final DateTime nextDeadline;
    if (recurrence == 'Daily') {
      nextDeadline = currentDeadline.add(const Duration(days: 1));
    } else if (recurrence == 'Weekly') {
      nextDeadline = currentDeadline.add(const Duration(days: 7));
    } else if (recurrence == 'Monthly') {
      nextDeadline = DateTime(
        currentDeadline.year,
        currentDeadline.month + 1,
        currentDeadline.day,
        currentDeadline.hour,
        currentDeadline.minute,
      );
    } else {
      return null;
    }

    final DateTime createdAt = now ?? DateTime.now();
    task[spawnedNextIdKey] = newId;
    return <String, dynamic>{
      'id': newId,
      'notifId': notifId,
      'title': task['title'],
      'isDone': false,
      'deadline': nextDeadline.toIso8601String(),
      'reminder': task['reminder'] ?? false,
      'priority': task['priority'],
      'category': task['category'],
      'recurrence': recurrence,
      'createdAt': createdAt.toIso8601String(),
      'stepsAreSequential': task['stepsAreSequential'] == true,
      // The next instance is measured on its OWN dates, not the finished
      // one's: a weekly task whose next deadline is seven days out is not
      // long term however the instance before it was banded.
      'isLongTerm': LongTermRule.isLongTerm(
        endDate: nextDeadline,
        createdAt: createdAt,
      ),
      // Frame 44c: the objective is part of the procedure, not of the
      // progress — the next instance serves the same objective.
      if (task.containsKey('strategicObjective')) ...<String, dynamic>{
        'strategicObjective': task['strategicObjective'],
        'strategicObjectiveTitle': task['strategicObjectiveTitle'],
        'strategicObjectivePillar': task['strategicObjectivePillar'],
      },
      // The next instance starts with the PROCEDURE (title, instruction,
      // duration) and none of the run's progress: isDone cleared, and the
      // step timestamps with it.
      'subtasks':
          (task['subtasks'] as List?)
              ?.map((s) => TaskRunStep.freshCopy(Map<String, dynamic>.from(s)))
              .toList() ??
          <Map<String, dynamic>>[],
    };
  }
}

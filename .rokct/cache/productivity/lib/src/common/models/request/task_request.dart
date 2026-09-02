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

/// The request half of the personal-task sync contract.
///
/// Shaped against the real endpoint, `projects/frappe/src/task_sync.py`'s
/// `sync_personal_task`, whose keyword arguments are exactly:
///
///     client_id, title, description, deadline, remind_at, priority,
///     category, recurrence, is_long_term, is_done, subtasks,
///     steps_are_sequential
///
/// Three details of that signature are load-bearing and are honoured here:
///
/// * `client_id` is the only required argument and the key the upsert runs
///   on — the temp-id to real-id handshake. It is never null.
/// * every OTHER argument is `None`-defaulted and the server writes a field
///   only when the device actually sent it (`if x is not None`). A partial
///   update must therefore OMIT keys rather than send nulls, which is why
///   [toJson] drops absent fields instead of encoding them as null. Sending
///   `is_done: null` would be read as "no opinion"; sending the key at all
///   with a false value re-opens a task.
/// * `deadline` and `remind_at` are separate columns. Snoozing moves the
///   reminder and NEVER the deadline (Ray's recorded rule), so they are
///   separate fields here too and nothing derives one from the other on the
///   way out.
class TaskRequest {
  const TaskRequest({
    required this.clientId,
    this.title,
    this.description,
    this.deadline,
    this.remindAt,
    this.priority,
    this.category,
    this.recurrence,
    this.isLongTerm,
    this.isDone,
    this.subtasks,
    this.stepsAreSequential,
  });

  /// Device-minted id the server upserts on. Required.
  final String clientId;

  /// Task subject. Required by the server on CREATE only; an update that
  /// does not touch the title may leave it null.
  final String? title;

  final String? description;

  /// The commitment — Task's `exp_end_date`.
  final DateTime? deadline;

  /// When to remind — Task's `remind_at`. Not the deadline.
  final DateTime? remindAt;

  /// One of Low / Medium / High / Urgent. Anything else is coerced to
  /// Medium server-side rather than rejected, so a stray label never fails
  /// a sync.
  final String? priority;

  final String? category;

  /// One of None / Daily / Weekly / Monthly, coerced the same way.
  final String? recurrence;

  final bool? isLongTerm;

  /// Done-ness. Null means "no opinion" — see the class doc.
  final bool? isDone;

  /// Child rows, each `{title, isDone}` plus the step fields of section 46
  /// (`instruction`, `durationSeconds`, `startedAt`, `completedAt`). The
  /// server accepts either that vocabulary or its own (`subject` /
  /// `is_done` / `duration_seconds` ...) and drops untitled rows; it writes
  /// the step fields through a whitelist checked against its own meta.
  final List<TaskSubtaskRequest>? subtasks;

  /// Task's `steps_are_sequential`: the subtasks are steps in order.
  final bool? stepsAreSequential;

  /// Builds a request from the map the /tasks surface keeps a task in.
  ///
  /// That map is the surface's own vocabulary (`title`, `isDone`,
  /// `deadline`, `remindAt`, `reminder`, `priority`, `category`,
  /// `recurrence`, `isLongTerm`, `stepsAreSequential`, `subtasks`); this is
  /// the single place it is translated to the wire.
  factory TaskRequest.fromTodo(Map<String, dynamic> todo, String clientId) {
    DateTime? parse(Object? value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      return DateTime.tryParse(value.toString());
    }

    final DateTime? deadline = parse(todo['deadline']);
    // The surface has one reminder switch and no reminder time of its own,
    // so an un-snoozed reminder is due at the deadline. Once a snooze has
    // moved it, `remindAt` is on the map and wins — and the deadline above
    // is read separately, so the two can never be conflated.
    final DateTime? remindAt =
        parse(todo['remindAt']) ?? (todo['reminder'] == true ? deadline : null);

    final Object? rawSubtasks = todo['subtasks'];
    final List<TaskSubtaskRequest>? subtasks = rawSubtasks is List
        ? <TaskSubtaskRequest>[
            for (final Object? row in rawSubtasks)
              if (row is Map)
                TaskSubtaskRequest.fromMap(row.cast<String, dynamic>()),
          ]
        : null;

    return TaskRequest(
      clientId: clientId,
      title: todo['title']?.toString(),
      description: todo['description']?.toString(),
      deadline: deadline,
      remindAt: remindAt,
      priority: todo['priority']?.toString(),
      category: todo['category']?.toString(),
      recurrence: todo['recurrence']?.toString(),
      isLongTerm: todo['isLongTerm'] == true,
      isDone: todo['isDone'] == true,
      subtasks: subtasks,
      stepsAreSequential: todo['stepsAreSequential'] == true,
    );
  }

  /// The `payload` kwargs for `api.projects.sync_personal_task`.
  ///
  /// Absent fields are OMITTED, never sent as null — the server reads a
  /// present key as an instruction and an absent one as silence.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'client_id': clientId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      // Frappe parses a Datetime field from 'YYYY-MM-DD HH:MM:SS'; an ISO-8601
      // string with its 'T' and timezone suffix is not that. Both columns go
      // out in the server's own format, in local time, because that is the
      // clock `remind_at` is compared against by the reminder cron.
      if (deadline != null) 'deadline': frappeDateTime(deadline!),
      if (remindAt != null) 'remind_at': frappeDateTime(remindAt!),
      if (priority != null) 'priority': priority,
      if (category != null) 'category': category,
      if (recurrence != null) 'recurrence': recurrence,
      if (isLongTerm != null) 'is_long_term': isLongTerm! ? 1 : 0,
      if (isDone != null) 'is_done': isDone! ? 1 : 0,
      if (subtasks != null)
        'subtasks': <Map<String, dynamic>>[
          for (final TaskSubtaskRequest subtask in subtasks!) subtask.toJson(),
        ],
      if (stepsAreSequential != null)
        'steps_are_sequential': stepsAreSequential! ? 1 : 0,
    };
  }
}

/// One child row of [TaskRequest.subtasks] — the `Task Subtask` doctype's
/// `subject` / `is_done` pair plus its four step fields, in the device's
/// own vocabulary.
class TaskSubtaskRequest {
  const TaskSubtaskRequest({
    required this.title,
    required this.isDone,
    this.instruction,
    this.durationSeconds = 0,
    this.startedAt,
    this.completedAt,
  });

  final String title;
  final bool isDone;
  final String? instruction;

  /// Always sent, zero included: the server replaces the whole child table
  /// on every upsert, so an omitted duration would come back as the
  /// column default rather than as the value the device still holds.
  final int durationSeconds;

  /// Sent only when set. A cleared start (Start over) is an ABSENT key —
  /// the server reads absence as "no value" and the column stays null.
  final DateTime? startedAt;
  final DateTime? completedAt;

  factory TaskSubtaskRequest.fromMap(Map<String, dynamic> row) {
    DateTime? parse(Object? value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      return DateTime.tryParse(value.toString());
    }

    final Object? rawDuration = row['durationSeconds'] ?? row['duration_seconds'];
    final int duration = rawDuration is num
        ? rawDuration.toInt()
        : int.tryParse('${rawDuration ?? ''}') ?? 0;
    final String instruction = (row['instruction'] ?? '').toString().trim();
    return TaskSubtaskRequest(
      title: (row['title'] ?? row['subject'] ?? '').toString(),
      isDone: row['isDone'] == true || row['is_done'] == true,
      instruction: instruction.isEmpty ? null : instruction,
      durationSeconds: duration < 0 ? 0 : duration,
      startedAt: parse(row['startedAt'] ?? row['started_at']),
      completedAt: parse(row['completedAt'] ?? row['completed_at']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'isDone': isDone,
    'durationSeconds': durationSeconds,
    if (instruction != null) 'instruction': instruction,
    if (startedAt != null) 'startedAt': frappeDateTime(startedAt!),
    if (completedAt != null) 'completedAt': frappeDateTime(completedAt!),
  };
}

/// Formats [value] the way Frappe's `get_datetime` expects a Datetime field:
/// `YYYY-MM-DD HH:MM:SS`, local time, no timezone suffix.
///
/// Public because the snooze path sends a `remind_at` too and must format it
/// identically — two spellings of the same wire format is how one of them
/// ends up wrong.
String frappeDateTime(DateTime value) {
  final DateTime local = value.isUtc ? value.toLocal() : value;
  String two(int n) => n.toString().padLeft(2, '0');
  return '${local.year.toString().padLeft(4, '0')}-${two(local.month)}-'
      '${two(local.day)} ${two(local.hour)}:${two(local.minute)}:'
      '${two(local.second)}';
}

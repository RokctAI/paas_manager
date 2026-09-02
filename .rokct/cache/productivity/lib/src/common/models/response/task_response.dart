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

/// The response half of the personal-task sync contract.
///
/// Shaped against `projects/frappe/src/task_sync.py`, which answers in three
/// shapes:
///
/// * `sync_personal_task` -> the handshake:
///   `{name, client_id, created, status, remind_at, reminder_fired, modified}`
/// * `list_personal_tasks` -> `{tasks: [...PULL_FIELDS + subtasks], server_time}`
/// * `snooze_task_reminder` ->
///   `{name, client_id, remind_at, reminder_fired, exp_end_date, deadline_moved}`
///
/// [TaskResponse] covers the first two: they are the same Task seen at two
/// levels of detail, and every field the handshake returns is also a
/// `PULL_FIELDS` entry, so one tolerant reader serves both rather than two
/// near-identical classes drifting apart. Fields the narrower shape does not
/// carry come back null, which is the truth about them.
class TaskResponse {
  const TaskResponse({
    required this.name,
    required this.clientId,
    this.subject,
    this.description,
    this.status,
    this.priority,
    this.category,
    this.recurrence,
    this.isLongTerm,
    this.stepsAreSequential,
    this.deadline,
    this.remindAt,
    this.reminderFired = false,
    this.modified,
    this.created,
    this.subtasks = const <TaskSubtaskResponse>[],
  });

  /// The server's id for this Task. The real half of the handshake.
  final String name;

  /// The device-minted id it was upserted on. Echoed back so a device can
  /// match the row it already holds without guessing.
  final String clientId;

  /// Task's `subject` — the device calls it the title.
  final String? subject;

  final String? description;

  /// Task's Select: Open / Working / Pending Review / Overdue / Template /
  /// Completed / Cancelled. The device only distinguishes done from not, and
  /// [isDone] is that reading.
  final String? status;

  final String? priority;
  final String? category;
  final String? recurrence;
  final bool? isLongTerm;

  /// Task's `steps_are_sequential`. Null on the handshake, which does not
  /// carry it.
  final bool? stepsAreSequential;

  /// Task's `exp_end_date` — the commitment.
  final DateTime? deadline;

  /// Task's `remind_at` — when to remind, which is NOT the deadline.
  final DateTime? remindAt;

  /// The one-shot latch the reminder cron sets when it has fired.
  final bool reminderFired;

  /// Server-side `modified`; the cursor a later incremental pull resumes
  /// from.
  final DateTime? modified;

  /// Handshake only: whether this call created the Task rather than
  /// updating one. Null on a pulled row, which says nothing about it.
  final bool? created;

  final List<TaskSubtaskResponse> subtasks;

  /// Done-ness as the device understands it. `Completed` is done; every
  /// other status — including `Cancelled` — is not, because the device has
  /// no vocabulary for cancelled and showing it as ticked would claim the
  /// work happened.
  bool get isDone => status == 'Completed';

  factory TaskResponse.fromMap(Map<String, dynamic> map) {
    return TaskResponse(
      name: (map['name'] ?? '').toString(),
      clientId: (map['client_id'] ?? '').toString(),
      subject: map['subject']?.toString(),
      description: map['description']?.toString(),
      status: map['status']?.toString(),
      priority: map['priority']?.toString(),
      category: map['category']?.toString(),
      recurrence: map['recurrence']?.toString(),
      isLongTerm: map.containsKey('is_long_term')
          ? _asBool(map['is_long_term'])
          : null,
      stepsAreSequential: map.containsKey('steps_are_sequential')
          ? _asBool(map['steps_are_sequential'])
          : null,
      deadline: _asDate(map['exp_end_date']),
      remindAt: _asDate(map['remind_at']),
      reminderFired: _asBool(map['reminder_fired']),
      modified: _asDate(map['modified']),
      created: map.containsKey('created') ? _asBool(map['created']) : null,
      subtasks: <TaskSubtaskResponse>[
        if (map['subtasks'] is List)
          for (final Object? row in map['subtasks'] as List)
            if (row is Map) TaskSubtaskResponse.fromMap(row),
      ],
    );
  }

  /// This task as the /tasks surface's own map, merged onto [existing] so
  /// the fields the server does not own — the local notification id above
  /// all — survive a pull instead of being wiped by it.
  Map<String, dynamic> toTodo({Map<String, dynamic>? existing}) {
    final Map<String, dynamic> todo = <String, dynamic>{
      ...?existing,
      'title': subject ?? existing?['title'] ?? '',
      'description': description,
      'isDone': isDone,
      'deadline': deadline?.toIso8601String(),
      'remindAt': remindAt?.toIso8601String(),
      'reminder': remindAt != null,
      'reminderFired': reminderFired,
      'priority': priority ?? existing?['priority'],
      'category': category,
      'recurrence': recurrence ?? existing?['recurrence'],
      'isLongTerm': isLongTerm ?? existing?['isLongTerm'] ?? false,
      'stepsAreSequential':
          stepsAreSequential ?? existing?['stepsAreSequential'] ?? false,
      'clientId': clientId,
      'remoteId': name,
    };
    if (subtasks.isNotEmpty || existing?['subtasks'] == null) {
      todo['subtasks'] = <Map<String, dynamic>>[
        for (final TaskSubtaskResponse subtask in subtasks) subtask.toMap(),
      ];
    }
    return todo;
  }
}

/// One `Task Subtask` child row: the checklist pair plus the four step
/// fields of section 46, under their doctype names.
class TaskSubtaskResponse {
  const TaskSubtaskResponse({
    required this.subject,
    required this.isDone,
    this.instruction,
    this.durationSeconds = 0,
    this.startedAt,
    this.completedAt,
  });

  final String subject;
  final bool isDone;
  final String? instruction;
  final int durationSeconds;
  final DateTime? startedAt;
  final DateTime? completedAt;

  factory TaskSubtaskResponse.fromMap(Map<Object?, Object?> map) {
    final Object? rawDuration = map['duration_seconds'];
    final int duration = rawDuration is num
        ? rawDuration.toInt()
        : int.tryParse('${rawDuration ?? ''}') ?? 0;
    final String instruction = (map['instruction'] ?? '').toString().trim();
    return TaskSubtaskResponse(
      subject: (map['subject'] ?? '').toString(),
      isDone: _asBool(map['is_done']),
      instruction: instruction.isEmpty ? null : instruction,
      durationSeconds: duration < 0 ? 0 : duration,
      startedAt: _asDate(map['started_at']),
      completedAt: _asDate(map['completed_at']),
    );
  }

  /// The surface's vocabulary for a subtask. Timestamps only when set, so
  /// a row the server holds with no start does not land as a null key that
  /// a later reader might mistake for a value.
  Map<String, dynamic> toMap() => <String, dynamic>{
    'title': subject,
    'isDone': isDone,
    'durationSeconds': durationSeconds,
    if (instruction != null) 'instruction': instruction,
    if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
    if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
  };
}

/// `list_personal_tasks` — `{tasks: [...], server_time: ...}`.
///
/// [serverTime] is the next pull's `modified_after`. It is the SERVER's
/// clock on purpose: resuming from a device clock would silently skip
/// everything written in the gap between the two.
class TaskListResponse {
  const TaskListResponse({required this.tasks, this.rawServerTime});

  final List<TaskResponse> tasks;

  /// The server clock, kept as the exact string the server sent.
  ///
  /// It is handed back on the next pull untouched. Parsing and re-formatting
  /// it would reinterpret a server-timezone stamp against the device's clock,
  /// and a cursor off by a second either replays rows or skips them.
  final String? rawServerTime;

  factory TaskListResponse.fromMap(Map<String, dynamic> map) {
    final String serverTime = (map['server_time'] ?? '').toString().trim();
    return TaskListResponse(
      tasks: <TaskResponse>[
        if (map['tasks'] is List)
          for (final Object? row in map['tasks'] as List)
            if (row is Map) TaskResponse.fromMap(row.cast<String, dynamic>()),
      ],
      rawServerTime: serverTime.isEmpty ? null : serverTime,
    );
  }
}

/// `snooze_task_reminder`.
///
/// [deadlineMoved] is the endpoint's own audit of the promise it makes —
/// a snooze moves the reminder and never the deadline — and is echoed back
/// precisely so a client can assert it rather than trust it.
class TaskSnoozeResponse {
  const TaskSnoozeResponse({
    required this.name,
    required this.clientId,
    this.remindAt,
    this.reminderFired = false,
    this.deadline,
    this.deadlineMoved = false,
  });

  final String name;
  final String clientId;
  final DateTime? remindAt;
  final bool reminderFired;

  /// Task's `exp_end_date`, echoed unchanged.
  final DateTime? deadline;

  /// Must be false. See the class doc.
  final bool deadlineMoved;

  factory TaskSnoozeResponse.fromMap(Map<String, dynamic> map) {
    return TaskSnoozeResponse(
      name: (map['name'] ?? '').toString(),
      clientId: (map['client_id'] ?? '').toString(),
      remindAt: _asDate(map['remind_at']),
      reminderFired: _asBool(map['reminder_fired']),
      deadline: _asDate(map['exp_end_date']),
      deadlineMoved: _asBool(map['deadline_moved']),
    );
  }
}

/// Frappe hands Check fields back as 0/1 and JSON booleans survive a
/// round trip as themselves; both readings mean the same thing.
bool _asBool(Object? value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  final String text = (value ?? '').toString().toLowerCase();
  return text == '1' || text == 'true';
}

/// Frappe emits Datetime as `YYYY-MM-DD HH:MM:SS[.ffffff]`, which
/// `DateTime.parse` accepts as local time — the same clock the values were
/// written on. An unparseable or absent value is null rather than a throw:
/// one bad timestamp must not cost the whole pull.
DateTime? _asDate(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  final String text = value.toString().trim();
  if (text.isEmpty) return null;
  return DateTime.tryParse(text);
}

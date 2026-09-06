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

// Design strip section 46 — the guided run, as DERIVED STATE.
//
// A run is not a thing of its own. It is a task's subtasks read as steps:
// the current step is the first one not yet complete, a step's remaining
// time is its duration minus what has elapsed since it started, and
// "finished" is every step done. Nothing here is a counter kept in
// memory — every number is recomputed from the four step fields the
// server also carries (`instruction`, `duration_seconds`, `started_at`,
// `completed_at`) on each read. That is what makes ruling three true:
// kill the app mid-step and the clock on relaunch reads exactly what
// the wall clock says, because the clock IS the wall clock.
//
// This file imports nothing from Flutter and touches no store, so the
// derivation is testable as plain Dart. The view (`task_run_view.dart`)
// only draws it and the host page only persists the maps it hands back.
//
// Rulings rendered here, from the approved frames:
//   * a blocked step cannot be skipped (46b) — the only block in the
//     generic model is a clock that has not run out, and [TaskRun.complete]
//     refuses until it has;
//   * abandoning keeps progress (46c) — leaving is the host's business and
//     nothing here ever clears a step except [TaskRun.restart], which is
//     the one destructive act and is named as such;
//   * a confirm-only step (duration 0) never auto-completes: its clock does
//     not exist, so its Continue is live at once and it is complete only
//     when somebody says so.
//
// Generic on purpose. There is no field for a vertical here and no
// vocabulary that belongs to one.
//
// Design strip section 47 (47h / 47i) added two KINDS of step on top of
// the plain confirmation and the clock: a READING step, which carries a
// list of named values with a spec (min / max) and is blocked — by data,
// not time — until every value is present and in spec, or an out-of-spec
// one is explained in the note ("re-test, or record why it is out of
// spec"); and a PHOTO step, which carries a picture's path and a note and
// blocks nothing. A step may also be OPTIONAL, which gives it a Skip that
// completes it as skipped. The kind is still generic: a reading is a
// labelled number, not a water quantity, and the templates that name
// TDS or pressure live in `maintenance_templates.dart`, not here.
//
// Every one of these fields lives in the same subtask map the four step
// fields do, and so in the device's `TasksTable.data` blob — local-first.
// None of them is on the wire yet: see `TaskSubtaskRequest`.

/// What kind of step a subtask is. A clock is not a kind: any kind may
/// carry a `durationSeconds` and is then timed as well.
enum StepKind {
  /// A confirmation, with or without a clock — section 46's whole model.
  plain,

  /// 47h — named values with a spec. Blocks until satisfied.
  reading,

  /// 47i — a picture and a note. Never blocks.
  photo,
}

/// Where one reading stands against its spec.
enum ReadingStatus { empty, inSpec, outOfSpec }

/// One named value on a reading step: its label, unit and spec, and the
/// value recorded against it. A date reading (`isDate`) carries a calendar
/// date instead of a number and has no min / max.
class ReadingSpec {
  const ReadingSpec({
    required this.label,
    this.unit = '',
    this.min,
    this.max,
    this.isDate = false,
    this.value,
  });

  final String label;
  final String unit;
  final num? min;
  final num? max;
  final bool isDate;

  /// What was recorded, as typed. Null or blank is "nothing yet".
  final String? value;

  bool get hasValue => (value ?? '').trim().isNotEmpty;

  /// The value as a number, or null when blank or not a number.
  double? get number => isDate ? null : double.tryParse((value ?? '').trim());

  /// The value as a date, or null when blank or not a date.
  DateTime? get date => isDate ? DateTime.tryParse((value ?? '').trim()) : null;

  /// DERIVED, never a flag: out of spec is the number against min / max.
  ReadingStatus get status {
    if (!hasValue) return ReadingStatus.empty;
    if (isDate) {
      return date == null ? ReadingStatus.empty : ReadingStatus.inSpec;
    }
    final double? n = number;
    if (n == null) return ReadingStatus.empty;
    if (min != null && n < min!) return ReadingStatus.outOfSpec;
    if (max != null && n > max!) return ReadingStatus.outOfSpec;
    return ReadingStatus.inSpec;
  }

  bool get isInSpec => status == ReadingStatus.inSpec;

  /// The spec as the frame draws it: "≤ 400", "≥ 1.0", "6.0–10.0"; empty
  /// when there is none.
  String get specLabel {
    if (isDate) return '';
    if (min != null && max != null) return '${_n(min!)}–${_n(max!)}';
    if (max != null) return '≤ ${_n(max!)}';
    if (min != null) return '≥ ${_n(min!)}';
    return '';
  }

  /// The spec with its unit: "≤ 50 ppm".
  String get specWithUnit =>
      <String>[specLabel, unit].where((String s) => s.isNotEmpty).join(' ');

  /// The value with its unit: "212 ppm".
  String get valueWithUnit =>
      <String>[(value ?? '').trim(), unit].where((String s) => s.isNotEmpty).join(' ');

  ReadingSpec withValue(String? next) => ReadingSpec(
    label: label,
    unit: unit,
    min: min,
    max: max,
    isDate: isDate,
    value: (next ?? '').trim().isEmpty ? null : next!.trim(),
  );

  factory ReadingSpec.fromMap(Map<String, dynamic> map) => ReadingSpec(
    label: '${map['label'] ?? ''}',
    unit: '${map['unit'] ?? ''}',
    min: _number(map['min']),
    max: _number(map['max']),
    isDate: map['date'] == true,
    value: TaskRunStep._text(map['value']),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'label': label,
    if (unit.isNotEmpty) 'unit': unit,
    if (min != null) 'min': min,
    if (max != null) 'max': max,
    if (isDate) 'date': true,
    if (hasValue) 'value': value!.trim(),
  };

  /// [map] with the recorded value stripped — a template's row.
  static Map<String, dynamic> freshCopy(Map<String, dynamic> map) =>
      Map<String, dynamic>.from(map)..remove('value');

  static num? _number(Object? value) {
    if (value is num) return value;
    return num.tryParse('${value ?? ''}');
  }

  /// An integer spec prints as one ("400"); a fractional one keeps a
  /// decimal ("1.0"), exactly as it was written into the template.
  static String _n(num value) =>
      value is int ? '$value' : value.toStringAsFixed(1);
}

/// One subtask, read as one STEP of a run.
class TaskRunStep {
  const TaskRunStep({
    required this.title,
    this.instruction,
    this.durationSeconds = 0,
    this.startedAt,
    this.completedAt,
    this.isDone = false,
    this.kind = StepKind.plain,
    this.optional = false,
    this.readings = const <ReadingSpec>[],
    this.value,
    this.note,
    this.skipped = false,
  });

  final String title;

  /// Section 47: plain, reading or photo. Plain when the map says nothing.
  final StepKind kind;

  /// 47i — an optional step has a Skip that completes it as skipped.
  /// Required (the default) blocks until it is genuinely done.
  final bool optional;

  /// 47h — the named values on a reading step, each with its own spec and
  /// recorded value. Empty for every other kind.
  final List<ReadingSpec> readings;

  /// 47i — the photo's path on a photo step. Generic on purpose: a path
  /// string, whatever picked it.
  final String? value;

  /// 47i's note, and 47h's "record why it is out of spec".
  final String? note;

  /// Completed by Skip rather than by doing it. Only an optional step can
  /// carry this, and it is cleared the moment the step is re-opened.
  final bool skipped;

  /// What to do on this step — shown under the title while it is active.
  final String? instruction;

  /// How long the step takes once started. 0 means UNTIMED: a plain
  /// confirmation with no clock.
  final int durationSeconds;

  /// Written once, when the step is started, and never rewritten: there is
  /// no pause in v1, so the elapsed time is always `now - startedAt`.
  final DateTime? startedAt;

  final DateTime? completedAt;

  /// The subtask's own done flag — authoritative for "complete".
  final bool isDone;

  bool get isTimed => durationSeconds > 0;

  bool get isStarted => startedAt != null;

  bool get hasInstruction => (instruction ?? '').trim().isNotEmpty;

  bool get isReading => kind == StepKind.reading;

  bool get isPhoto => kind == StepKind.photo;

  bool get hasValue => (value ?? '').trim().isNotEmpty;

  bool get hasNote => (note ?? '').trim().isNotEmpty;

  /// Whether the step's own data lets it finish. Trivially true for a
  /// plain or photo step. A reading step is satisfied when every reading
  /// has a value and each is in spec — or, for one out of spec, the note
  /// says why (47h's route out: "re-test, or record why it is out of
  /// spec, to continue"). DERIVED on every read; there is no flag.
  bool get isSatisfied => firstUnmetReading == null;

  /// The first reading standing in the way, or null when none does.
  ReadingSpec? get firstUnmetReading {
    if (!isReading) return null;
    for (final ReadingSpec reading in readings) {
      switch (reading.status) {
        case ReadingStatus.empty:
          return reading;
        case ReadingStatus.outOfSpec:
          if (!hasNote) return reading;
        case ReadingStatus.inSpec:
          break;
      }
    }
    return null;
  }

  /// CHIP 856 for a reading step — the refusal, in the frame's words:
  /// "Permeate TDS 212 ppm is outside 50 ppm" for a value out of spec,
  /// or which value is still missing. Null when nothing blocks.
  String? get refusal {
    final ReadingSpec? unmet = firstUnmetReading;
    if (unmet == null) return null;
    if (unmet.status == ReadingStatus.outOfSpec) {
      return '${unmet.label} ${unmet.valueWithUnit} is outside ${unmet.specWithUnit}';
    }
    return '${unmet.label} has no value yet';
  }

  Duration get duration => Duration(seconds: durationSeconds);

  /// Time spent on the step: from start to completion, or to [now] while
  /// it is still open. Zero before it starts.
  Duration elapsedAt(DateTime now) {
    final DateTime? started = startedAt;
    if (started == null) return Duration.zero;
    final Duration elapsed = (completedAt ?? now).difference(started);
    return elapsed.isNegative ? Duration.zero : elapsed;
  }

  /// What is left on the clock at [now]. The full duration before the step
  /// starts, zero once it has run out, zero always for an untimed step.
  Duration remainingAt(DateTime now) {
    if (!isTimed) return Duration.zero;
    if (!isStarted) return duration;
    final Duration remaining = duration - elapsedAt(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// Whether the clock, if there is one, has run out — the condition the
  /// forward control waits on. Trivially true for an untimed step.
  bool clockElapsedAt(DateTime now) =>
      !isTimed || (isStarted && remainingAt(now) == Duration.zero);

  TaskRunStep _copy({
    DateTime? startedAt,
    bool clearStartedAt = false,
    DateTime? completedAt,
    bool clearCompletedAt = false,
    bool? isDone,
    List<ReadingSpec>? readings,
    String? value,
    bool clearValue = false,
    String? note,
    bool clearNote = false,
    bool? skipped,
  }) {
    return TaskRunStep(
      title: title,
      instruction: instruction,
      durationSeconds: durationSeconds,
      startedAt: clearStartedAt ? null : (startedAt ?? this.startedAt),
      completedAt: clearCompletedAt ? null : (completedAt ?? this.completedAt),
      isDone: isDone ?? this.isDone,
      kind: kind,
      optional: optional,
      readings: readings ?? this.readings,
      value: clearValue ? null : (value ?? this.value),
      note: clearNote ? null : (note ?? this.note),
      skipped: skipped ?? this.skipped,
    );
  }

  /// The step with reading [index] recorded as [raw]. Blank clears it.
  /// Nothing else moves: recording is not completing.
  TaskRunStep withReading(int index, String? raw) {
    if (index < 0 || index >= readings.length) return this;
    final List<ReadingSpec> next = List<ReadingSpec>.from(readings);
    next[index] = readings[index].withValue(raw);
    return _copy(readings: next);
  }

  /// The step with its value (a photo's path) set, or cleared by null.
  TaskRunStep withValue(String? next) {
    final String trimmed = (next ?? '').trim();
    return trimmed.isEmpty ? _copy(clearValue: true) : _copy(value: trimmed);
  }

  /// The step with its note set, or cleared by blank.
  TaskRunStep withNote(String? next) {
    final String trimmed = (next ?? '').trim();
    return trimmed.isEmpty ? _copy(clearNote: true) : _copy(note: trimmed);
  }

  /// The step with its clock started at [now]. A step already started is
  /// returned unchanged — `startedAt` is written once.
  TaskRunStep started(DateTime now) =>
      isStarted ? this : _copy(startedAt: now);

  /// The step marked complete at [now]. A step completed without ever being
  /// started (an untimed confirmation) is stamped as started then too, so
  /// the record never shows a completion with no start.
  TaskRunStep completed(DateTime now) => _copy(
    startedAt: startedAt ?? now,
    completedAt: now,
    isDone: true,
    skipped: false,
  );

  /// 47i — the step completed by Skip: done, stamped, and marked as
  /// skipped so the rail says so. What was typed on it is kept.
  TaskRunStep skippedAt(DateTime now) => _copy(
    startedAt: startedAt ?? now,
    completedAt: now,
    isDone: true,
    skipped: true,
  );

  /// The step re-opened by the run's Back. The completion goes; the start
  /// stays, so a timed step keeps the time it already spent. A skipped
  /// step is no longer skipped: it is open again.
  TaskRunStep reopened() =>
      _copy(clearCompletedAt: true, isDone: false, skipped: false);

  /// The step as it was before the run touched it. Progress is gone —
  /// timestamps, readings, photo, note — and the procedure (title,
  /// instruction, duration, kind, spec) is kept.
  TaskRunStep reset() => _copy(
    clearStartedAt: true,
    clearCompletedAt: true,
    isDone: false,
    readings: <ReadingSpec>[for (final ReadingSpec r in readings) r.withValue(null)],
    clearValue: true,
    clearNote: true,
    skipped: false,
  );

  /// Reads a step off the /tasks surface's subtask map or a pulled row.
  /// Both vocabularies are accepted, matching the server's own reader.
  factory TaskRunStep.fromMap(Map<String, dynamic> map) {
    return TaskRunStep(
      title: '${map['title'] ?? map['subject'] ?? ''}',
      instruction: _text(map['instruction']),
      durationSeconds: _seconds(map['durationSeconds'] ?? map['duration_seconds']),
      startedAt: _date(map['startedAt'] ?? map['started_at']),
      completedAt: _date(map['completedAt'] ?? map['completed_at']),
      isDone: map['isDone'] == true || map['is_done'] == true ||
          map['is_done'] == 1,
      kind: _kind(map['kind']),
      optional: map['optional'] == true || map['optional'] == 1,
      readings: <ReadingSpec>[
        if (map['readings'] is List)
          for (final Object? row in map['readings'] as List)
            if (row is Map) ReadingSpec.fromMap(row.cast<String, dynamic>()),
      ],
      value: _text(map['value']),
      note: _text(map['note']),
      skipped: map['skipped'] == true || map['skipped'] == 1,
    );
  }

  /// The step as the /tasks surface stores it. Timestamps are written only
  /// when set — absent is silence to the server, and a cleared start must
  /// not travel as a null that reads like a value.
  Map<String, dynamic> toMap() => <String, dynamic>{
    'title': title,
    'isDone': isDone,
    'durationSeconds': durationSeconds,
    if (hasInstruction) 'instruction': instruction!.trim(),
    if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
    if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
    // Section 47's keys, written only when they say something: a plain
    // required step's map is exactly what section 46 wrote.
    if (kind != StepKind.plain) 'kind': kind.name,
    if (optional) 'optional': true,
    if (readings.isNotEmpty)
      'readings': <Map<String, dynamic>>[for (final ReadingSpec r in readings) r.toMap()],
    if (hasValue) 'value': value!.trim(),
    if (hasNote) 'note': note!.trim(),
    if (skipped) 'skipped': true,
  };

  /// The keys of a step map that describe the RUN of it rather than the
  /// procedure — what [freshCopy] strips, and what a pull must keep from
  /// the device's row because the server does not carry them.
  static const List<String> deviceOnlyKeys = <String>[
    'kind',
    'optional',
    'readings',
    'value',
    'note',
    'skipped',
  ];

  /// [map] with this run's progress stripped and its procedure kept — what
  /// a fresh copy of a task (a rolled-over recurrence, a task made from a
  /// template) starts from.
  static Map<String, dynamic> freshCopy(Map<String, dynamic> map) {
    final Map<String, dynamic> copy = Map<String, dynamic>.from(map)
      ..['isDone'] = false
      ..remove('startedAt')
      ..remove('completedAt')
      ..remove('started_at')
      ..remove('completed_at')
      ..remove('value')
      ..remove('note')
      ..remove('skipped');
    final Object? readings = copy['readings'];
    if (readings is List) {
      copy['readings'] = <Map<String, dynamic>>[
        for (final Object? row in readings)
          if (row is Map) ReadingSpec.freshCopy(row.cast<String, dynamic>()),
      ];
    }
    return copy;
  }

  static StepKind _kind(Object? value) {
    final String name = '${value ?? ''}'.trim();
    for (final StepKind kind in StepKind.values) {
      if (kind.name == name) return kind;
    }
    return StepKind.plain;
  }

  static String? _text(Object? value) {
    if (value == null) return null;
    final String text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static int _seconds(Object? value) {
    if (value is num) return value < 0 ? 0 : value.toInt();
    final int parsed = int.tryParse('${value ?? ''}') ?? 0;
    return parsed < 0 ? 0 : parsed;
  }

  static DateTime? _date(Object? value) {
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
    return null;
  }
}

/// What the runner may do with one step right now.
enum StepGate {
  /// Complete already.
  done,

  /// Behind an incomplete earlier step while the steps are in order.
  locked,

  /// Timed and not yet started: the only move is Start.
  notStarted,

  /// Timed, started, and the clock has not run out — BLOCKED, and the
  /// block is a clock (46b / 47b). Nothing but time opens it.
  running,

  /// Unlocked, no clock in the way, and the step's own data is not there
  /// yet — BLOCKED by a value (47h): a reading missing or out of spec.
  /// Nothing but the value opens it.
  incomplete,

  /// Continue is live: untimed, or the clock has run out.
  ready,
}

/// A task's subtasks read as a run. Immutable; every move returns a new
/// run, and the host persists the maps it hands back.
class TaskRun {
  const TaskRun({required this.steps, this.sequential = false});

  final List<TaskRunStep> steps;

  /// Task's `steps_are_sequential`: when set the next step unlocks only
  /// once the one before it is complete. Unset (the default) is today's
  /// any-order checklist.
  final bool sequential;

  /// Reads the run off the /tasks surface's task map.
  factory TaskRun.fromTask(Map<String, dynamic> task) {
    final Object? raw = task['subtasks'];
    return TaskRun(
      steps: <TaskRunStep>[
        if (raw is List)
          for (final Object? row in raw)
            if (row is Map)
              TaskRunStep.fromMap(row.cast<String, dynamic>()),
      ],
      sequential: task['stepsAreSequential'] == true ||
          task['steps_are_sequential'] == true ||
          task['steps_are_sequential'] == 1,
    );
  }

  int get total => steps.length;

  bool get hasSteps => steps.isNotEmpty;

  int get doneCount => steps.where((TaskRunStep s) => s.isDone).length;

  int get leftCount => total - doneCount;

  bool get isFinished => hasSteps && doneCount == total;

  /// Whether the run has been touched at all — a step started or done.
  bool get isStarted => steps.any((TaskRunStep s) => s.isDone || s.isStarted);

  /// Mid-run: touched and not finished. The state chip 859 announces.
  bool get isInProgress => isStarted && !isFinished;

  /// The step to work on — the FIRST not-complete step — or null when the
  /// run is finished or empty. Derived on every read.
  int? get currentIndex {
    for (int i = 0; i < steps.length; i++) {
      if (!steps[i].isDone) return i;
    }
    return null;
  }

  /// 1-based, for "Step 3 of 9".
  int? get currentNumber {
    final int? index = currentIndex;
    return index == null ? null : index + 1;
  }

  /// The most recent timestamp on any step — when the run was last touched.
  DateTime? get lastTouched {
    DateTime? latest;
    for (final TaskRunStep step in steps) {
      for (final DateTime? stamp in <DateTime?>[step.startedAt, step.completedAt]) {
        if (stamp != null && (latest == null || stamp.isAfter(latest))) {
          latest = stamp;
        }
      }
    }
    return latest;
  }

  /// Whether a step is still running against its clock at [now] — what
  /// the view's single ticker keys on.
  bool hasRunningClockAt(DateTime now) => steps.any(
    (TaskRunStep s) =>
        !s.isDone && s.isTimed && s.isStarted && s.remainingAt(now) > Duration.zero,
  );

  /// The unlock gate: whether [index] may be worked on now.
  bool isUnlocked(int index) {
    if (index < 0 || index >= total) return false;
    if (steps[index].isDone) return false;
    if (!sequential) return true;
    return index == currentIndex;
  }

  StepGate gateAt(int index, DateTime now) {
    final TaskRunStep step = steps[index];
    if (step.isDone) return StepGate.done;
    if (!isUnlocked(index)) return StepGate.locked;
    if (step.isTimed) {
      if (!step.isStarted) return StepGate.notStarted;
      if (step.remainingAt(now) > Duration.zero) return StepGate.running;
    }
    if (!step.isSatisfied) return StepGate.incomplete;
    return StepGate.ready;
  }

  /// 47i — whether [index] may be skipped: optional, open and unlocked.
  /// A required step has no Skip, whatever else is true of it.
  bool canSkipAt(int index) =>
      index >= 0 && index < total && steps[index].optional && isUnlocked(index);

  bool canStartAt(int index, DateTime now) =>
      gateAt(index, now) == StepGate.notStarted;

  bool canCompleteAt(int index, DateTime now) =>
      gateAt(index, now) == StepGate.ready;

  /// The most recently completed step before [index], or null — what the
  /// run's Back (855) re-opens. Back moves ONE step.
  int? previousDoneBefore(int index) {
    for (int i = index - 1; i >= 0; i--) {
      if (steps[i].isDone) return i;
    }
    return null;
  }

  /// The next open step at or after [index], else the first open step
  /// anywhere, else null. Where focus lands after a step is completed or
  /// skipped past.
  int? nextOpenFrom(int index) {
    for (int i = index; i < total; i++) {
      if (!steps[i].isDone) return i;
    }
    return currentIndex;
  }

  /// The first open step strictly after [index], else null — the Skip
  /// pill's target. Only meaningful while the steps are NOT in order; a
  /// sequential run has no skip.
  int? skipTargetFrom(int index) {
    if (sequential) return null;
    for (int i = index + 1; i < total; i++) {
      if (!steps[i].isDone) return i;
    }
    return null;
  }

  TaskRun _replace(int index, TaskRunStep step) {
    final List<TaskRunStep> next = List<TaskRunStep>.from(steps);
    next[index] = step;
    return TaskRun(steps: next, sequential: sequential);
  }

  /// Start the clock on [index]. A no-op unless the gate says notStarted.
  TaskRun start(int index, DateTime now) =>
      canStartAt(index, now) ? _replace(index, steps[index].started(now)) : this;

  /// Complete [index]. REFUSED while its clock runs — a blocked step cannot
  /// be skipped — and refused for a locked step.
  TaskRun complete(int index, DateTime now) => canCompleteAt(index, now)
      ? _replace(index, steps[index].completed(now))
      : this;

  /// 47i — complete [index] as skipped. Refused unless [canSkipAt].
  TaskRun skip(int index, DateTime now) =>
      canSkipAt(index) ? _replace(index, steps[index].skippedAt(now)) : this;

  /// 47h — record reading [reading] on step [index]. Recording is not
  /// completing: the gate re-derives from the new value on the next read.
  TaskRun recordReading(int index, int reading, String? raw) =>
      _unlockedForData(index)
      ? _replace(index, steps[index].withReading(reading, raw))
      : this;

  /// 47i — set (or clear) the value on step [index]: the photo's path.
  TaskRun recordValue(int index, String? value) => _unlockedForData(index)
      ? _replace(index, steps[index].withValue(value))
      : this;

  /// 47h / 47i — set (or clear) the note on step [index].
  TaskRun recordNote(int index, String? note) => _unlockedForData(index)
      ? _replace(index, steps[index].withNote(note))
      : this;

  /// Data may be written on any open, unlocked step — a running clock
  /// does not stop the operator typing the reading they are watching.
  bool _unlockedForData(int index) =>
      index >= 0 && index < total && isUnlocked(index);

  /// Back from [index]: re-open the step completed just before it.
  TaskRun back(int index) {
    final int? previous = previousDoneBefore(index);
    return previous == null ? this : _replace(previous, steps[previous].reopened());
  }

  /// Start over. THE one destructive act: every step's progress goes.
  TaskRun restart() => TaskRun(
    steps: <TaskRunStep>[for (final TaskRunStep s in steps) s.reset()],
    sequential: sequential,
  );

  /// The steps back in the /tasks surface's vocabulary, ready to be put on
  /// the task map's `subtasks` and saved.
  List<Map<String, dynamic>> toSubtaskMaps() =>
      <Map<String, dynamic>>[for (final TaskRunStep s in steps) s.toMap()];

  /// [task] with this run's steps written back onto it.
  Map<String, dynamic> applyTo(Map<String, dynamic> task) =>
      Map<String, dynamic>.from(task)..['subtasks'] = toSubtaskMaps();

  /// "Step 3 of 9" while mid-run; null otherwise. The words on the 859
  /// badge and the rail count.
  String? get positionLabel {
    final int? number = currentNumber;
    if (number == null || !isStarted) return null;
    return 'Step $number of $total';
  }
}

/// A clock for the step card: `m:ss`, or `h:mm:ss` from an hour up.
String formatRunClock(Duration value) {
  final int total = value.inSeconds < 0 ? 0 : value.inSeconds;
  final int hours = total ~/ 3600;
  final int minutes = (total % 3600) ~/ 60;
  final int seconds = total % 60;
  String two(int n) => n.toString().padLeft(2, '0');
  if (hours > 0) return '$hours:${two(minutes)}:${two(seconds)}';
  return '$minutes:${two(seconds)}';
}

/// A duration for a step row: "30 min", "1 h 30 min", "45 s".
String formatRunDuration(Duration value) {
  final int total = value.inSeconds < 0 ? 0 : value.inSeconds;
  if (total < 60) return '$total s';
  final int hours = total ~/ 3600;
  final int minutes = (total % 3600) ~/ 60;
  if (hours == 0) return '$minutes min';
  return minutes == 0 ? '$hours h' : '$hours h $minutes min';
}

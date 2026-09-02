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

/// One subtask, read as one STEP of a run.
class TaskRunStep {
  const TaskRunStep({
    required this.title,
    this.instruction,
    this.durationSeconds = 0,
    this.startedAt,
    this.completedAt,
    this.isDone = false,
  });

  final String title;

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
  }) {
    return TaskRunStep(
      title: title,
      instruction: instruction,
      durationSeconds: durationSeconds,
      startedAt: clearStartedAt ? null : (startedAt ?? this.startedAt),
      completedAt: clearCompletedAt ? null : (completedAt ?? this.completedAt),
      isDone: isDone ?? this.isDone,
    );
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
  );

  /// The step re-opened by the run's Back. The completion goes; the start
  /// stays, so a timed step keeps the time it already spent.
  TaskRunStep reopened() => _copy(clearCompletedAt: true, isDone: false);

  /// The step as it was before the run touched it. Progress is gone; the
  /// procedure (title, instruction, duration) is kept.
  TaskRunStep reset() => _copy(
    clearStartedAt: true,
    clearCompletedAt: true,
    isDone: false,
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
  };

  /// [map] with this run's progress stripped and its procedure kept — what
  /// a fresh copy of a task (a rolled-over recurrence, a task made from a
  /// template) starts from.
  static Map<String, dynamic> freshCopy(Map<String, dynamic> map) {
    final Map<String, dynamic> copy = Map<String, dynamic>.from(map)
      ..['isDone'] = false
      ..remove('startedAt')
      ..remove('completedAt')
      ..remove('started_at')
      ..remove('completed_at');
    return copy;
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
    if (!step.isTimed) return StepGate.ready;
    if (!step.isStarted) return StepGate.notStarted;
    if (step.remainingAt(now) > Duration.zero) return StepGate.running;
    return StepGate.ready;
  }

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

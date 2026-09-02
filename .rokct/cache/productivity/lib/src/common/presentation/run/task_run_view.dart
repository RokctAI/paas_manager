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

// Design strip section 46 — the guided run, drawn. Chips 852 (the step
// rail), 853 (the step card), 854 Continue, 855 the run's Back, 856 the
// blocked reason, 857 Continue-blocked, 858 the route out, 860 the resume
// card, 862 Skip, 865 the compact rail, 866 Leave, and 872 the step clock
// section 47 added.
//
// THIS WIDGET OWNS NO RUN STATE. Everything it draws is derived by
// `TaskRun` from the task map its host hands it, and every move it makes
// is handed straight back through [TaskRunView.onChanged] as a new map for
// the host to persist. Kill the app, reopen the task, and the clock reads
// what the wall clock says, because that is where it is read from.
//
// ONE TICKER FOR THE WHOLE PAGE, and only while a clock is running. It
// does nothing but ask for a repaint; the remaining time is recomputed
// from `started_at` on each paint. (paas_pos's stage dialog ran two
// Timer.periodic per stage and counted down in memory, ~2x fast, and lost
// the elapsed credit on resume. That design is deliberately not ported.)
//
// Copy is generic: "Run", "Step 3 of 9", "Continue", "Back". There is no
// word for a vertical anywhere in this file.

import 'dart:async';

import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:productivity_sdk/src/common/application/run/task_run.dart';

/// The moment format on the resume card and the rail's outcomes.
final DateFormat _kMomentFormat = DateFormat('MMM dd, hh:mm a');

/// The guided run for one task.
class TaskRunView extends StatefulWidget {
  const TaskRunView({
    super.key,
    required this.task,
    required this.onChanged,
    this.onLeave,
    this.onMarkDone,
    this.now,
  });

  /// The task, in the /tasks surface's own map. Its `subtasks` are the
  /// steps and `stepsAreSequential` is the order rule.
  final Map<String, dynamic> task;

  /// The task with the run's progress written onto it. The host persists
  /// it (drift first, then the outbox) and hands it back as [task].
  final ValueChanged<Map<String, dynamic>> onChanged;

  /// Chip 866 — Leave, progress kept. Null hides the control (a host that
  /// has its own way out, such as a pushed page's corner pill).
  final VoidCallback? onLeave;

  /// Offered once every step is done: mark the TASK done. Null hides it.
  final VoidCallback? onMarkDone;

  /// The clock. Tests inject one; production reads the wall clock.
  final DateTime Function()? now;

  /// Keys for hosts and tests.
  static const Key continueKey = Key('task-run-continue');
  static const Key backKey = Key('task-run-back');
  static const Key skipKey = Key('task-run-skip');
  static const Key leaveKey = Key('task-run-leave');
  static const Key resumeKey = Key('task-run-resume');
  static const Key startOverKey = Key('task-run-start-over');
  static const Key markDoneKey = Key('task-run-mark-done');

  @override
  State<TaskRunView> createState() => _TaskRunViewState();
}

class _TaskRunViewState extends State<TaskRunView>
    with WidgetsBindingObserver {
  Timer? _ticker;

  /// The step the card shows, when the user has moved off the derived
  /// current step (Skip, or tapping a rail row on an any-order run). Null
  /// means "the current step".
  int? _focus;

  /// Chip 860: a run found mid-way opens on the resume card until the
  /// user chooses Resume or Start over.
  bool _resumeChosen = false;

  DateTime _now() => widget.now?.call() ?? DateTime.now();

  String get _taskId => '${widget.task['id'] ?? ''}';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _syncTicker();
  }

  @override
  void didUpdateWidget(TaskRunView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ('${oldWidget.task['id'] ?? ''}' != _taskId) {
      _focus = null;
      _resumeChosen = false;
    }
    _syncTicker();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Back from the background: repaint at once rather than waiting for
    // the next tick, and re-arm the ticker the platform may have paused.
    if (state == AppLifecycleState.resumed && mounted) {
      setState(_syncTicker);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    super.dispose();
  }

  /// The one ticker: alive only while some step's clock is running.
  void _syncTicker() {
    final bool needed = TaskRun.fromTask(widget.task).hasRunningClockAt(_now());
    if (needed && _ticker == null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        // Repaint first so the tick that reaches zero is drawn, then
        // decide whether there is still a clock to follow.
        setState(() {});
        if (!TaskRun.fromTask(widget.task).hasRunningClockAt(_now())) {
          _ticker?.cancel();
          _ticker = null;
        }
      });
    } else if (!needed && _ticker != null) {
      _ticker!.cancel();
      _ticker = null;
    }
  }

  void _emit(TaskRun run) => widget.onChanged(run.applyTo(widget.task));

  void _track(String event, Map<String, dynamic> properties) {
    unawaited(TelemetryClient.I.track(event, properties: properties));
  }

  int _focusFor(TaskRun run) {
    final int? current = run.currentIndex;
    final int? focus = _focus;
    if (focus != null && focus < run.total && !run.steps[focus].isDone) {
      return focus;
    }
    return current ?? 0;
  }

  void _start(TaskRun run, int index) {
    final DateTime now = _now();
    if (!run.canStartAt(index, now)) return;
    if (!run.isStarted) {
      _track('task_run_started', <String, dynamic>{
        'steps': run.total,
        'sequential': run.sequential,
      });
    }
    _emit(run.start(index, now));
  }

  void _complete(TaskRun run, int index) {
    final DateTime now = _now();
    if (!run.canCompleteAt(index, now)) return;
    final TaskRunStep step = run.steps[index];
    if (!run.isStarted) {
      _track('task_run_started', <String, dynamic>{
        'steps': run.total,
        'sequential': run.sequential,
      });
    }
    final TaskRun next = run.complete(index, now);
    _track('task_run_step_completed', <String, dynamic>{
      'step': index + 1,
      'steps': run.total,
      'timed': step.isTimed,
      'duration_seconds': step.durationSeconds,
      'elapsed_seconds': step.elapsedAt(now).inSeconds,
    });
    if (next.isFinished) {
      _track('task_run_finished', <String, dynamic>{'steps': run.total});
    }
    setState(() => _focus = next.nextOpenFrom(index));
    _emit(next);
  }

  void _back(TaskRun run, int index) {
    final int? previous = run.previousDoneBefore(index);
    if (previous == null) return;
    setState(() => _focus = previous);
    _emit(run.back(index));
  }

  void _skip(TaskRun run, int index) {
    final int? target = run.skipTargetFrom(index);
    if (target == null) return;
    setState(() => _focus = target);
  }

  void _restart(TaskRun run) {
    _track('task_run_restarted', <String, dynamic>{'steps': run.total});
    setState(() {
      _focus = null;
      _resumeChosen = true;
    });
    _emit(run.restart());
  }

  /// One plane (the phone, or a narrow window) folds the rail to segments
  /// (46f). Inside a PlaneHost the count is published; a standalone page
  /// derives it from its own width by the same thresholds.
  int _planeCount(BuildContext context) =>
      Planes.maybeOf(context)?.count ??
      PlaneHost.planeCountFor(MediaQuery.sizeOf(context).width);

  @override
  Widget build(BuildContext context) {
    final TaskRun run = TaskRun.fromTask(widget.task);
    final DateTime now = _now();
    final bool compact = _planeCount(context) < 2;

    final List<Widget> body;
    if (!run.hasSteps) {
      body = <Widget>[_notice('This task has no steps yet.')];
    } else if (run.isInProgress && !_resumeChosen) {
      body = <Widget>[
        _ResumeCard(
          run: run,
          onResume: () => setState(() => _resumeChosen = true),
          onStartOver: () => _restart(run),
        ),
      ];
    } else if (run.isFinished) {
      body = <Widget>[
        _FinishedCard(
          run: run,
          onMarkDone: widget.onMarkDone,
          taskDone: widget.task['isDone'] == true,
        ),
      ];
    } else {
      final int focus = _focusFor(run);
      body = <Widget>[
        if (compact)
          _CompactRail(run: run, focus: focus, now: now)
        else
          _StepRail(
            run: run,
            focus: focus,
            now: now,
            onPick: run.sequential
                ? null
                : (int i) => setState(() => _focus = i),
          ),
        12.verticalSpace,
        _StepCard(
          run: run,
          index: focus,
          now: now,
          compact: compact,
          onStart: () => _start(run, focus),
          onContinue: () => _complete(run, focus),
          onBack: run.previousDoneBefore(focus) == null
              ? null
              : () => _back(run, focus),
          onSkip: run.skipTargetFrom(focus) == null
              ? null
              : () => _skip(run, focus),
        ),
      ];
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
      children: <Widget>[
        _header(run),
        12.verticalSpace,
        ...body,
      ],
    );
  }

  /// The task's title, the word Run, and chip 866.
  Widget _header(TaskRun run) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'RUN',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                  letterSpacing: 0.8,
                ),
              ),
              2.verticalSpace,
              Text(
                '${widget.task['title'] ?? ''}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.interSemi(size: 18, color: AppStyle.textPrimary),
              ),
            ],
          ),
        ),
        if (widget.onLeave != null)
          TextButton(
            key: TaskRunView.leaveKey,
            onPressed: widget.onLeave,
            child: Text(
              run.isInProgress ? 'Leave · progress kept' : 'Leave',
              style: AppStyle.interNormal(
                size: 12,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _notice(String text) => Text(
    text,
    style: AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
  );
}

// ------------------------------------------------------------- the rail

/// Position and remaining work, in one object: "STEP 3 OF 9", "6 left",
/// and a three-state hairline. Shared by the full and compact rails.
class _RailHead extends StatelessWidget {
  const _RailHead({required this.run, required this.focus, required this.now});

  final TaskRun run;
  final int focus;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final bool blocked = run.gateAt(focus, now) == StepGate.running;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'STEP ${focus + 1} OF ${run.total}',
              style: AppStyle.interSemi(
                size: 11,
                color: AppStyle.textPrimary,
                letterSpacing: 0.8,
              ),
            ),
            const Spacer(),
            Text(
              '${run.leftCount} left',
              style: AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
            ),
          ],
        ),
        8.verticalSpace,
        // The hairline: done green, current primary (amber while its
        // clock blocks it), ahead grey.
        Row(
          children: <Widget>[
            for (int i = 0; i < run.total; i++) ...[
              if (i > 0) 3.horizontalSpace,
              Expanded(
                child: Container(
                  height: 3.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: run.steps[i].isDone
                        ? AppStyle.green
                        : i == focus
                        ? (blocked ? AppStyle.starColor : AppStyle.primary)
                        : AppStyle.strokeDarkSubtle,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// CHIP 852 — the full rail: one row per step, done ones ticked with their
/// outcome kept beside them, the current one ringed, the ones ahead
/// numbered and dim.
class _StepRail extends StatelessWidget {
  const _StepRail({
    required this.run,
    required this.focus,
    required this.now,
    this.onPick,
  });

  final TaskRun run;
  final int focus;
  final DateTime now;

  /// Null while the steps are in order — a row is then not a door.
  final void Function(int index)? onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _RailHead(run: run, focus: focus, now: now),
          8.verticalSpace,
          for (int i = 0; i < run.total; i++) _row(i),
        ],
      ),
    );
  }

  Widget _row(int i) {
    final TaskRunStep step = run.steps[i];
    final bool current = i == focus;
    final StepGate gate = run.gateAt(i, now);
    final Color ring = gate == StepGate.running ? AppStyle.starColor : AppStyle.primary;
    final Widget lead;
    if (step.isDone) {
      lead = Container(
        width: 18.r,
        height: 18.r,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppStyle.green),
        child: Icon(Icons.check, size: 12.r, color: AppStyle.blackColor),
      );
    } else {
      lead = Container(
        width: 18.r,
        height: 18.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: current ? ring : AppStyle.strokeDark,
            width: current ? 1.6 : 1,
          ),
        ),
        child: Text(
          '${i + 1}',
          style: AppStyle.interSemi(
            size: 9,
            color: current ? ring : AppStyle.textDarkFaint,
          ),
        ),
      );
    }
    final Color titleColor = step.isDone
        ? AppStyle.textDarkSecondary
        : current
        ? AppStyle.textPrimary
        : AppStyle.textDarkFaint;
    final VoidCallback? pick = onPick == null || step.isDone || current
        ? null
        : () => onPick!(i);
    return InkWell(
      onTap: pick,
      borderRadius: BorderRadius.circular(6.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: <Widget>[
            lead,
            8.horizontalSpace,
            Expanded(
              child: Text(
                step.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: current
                    ? AppStyle.interSemi(size: 12, color: titleColor)
                    : AppStyle.interNormal(size: 12, color: titleColor),
              ),
            ),
            6.horizontalSpace,
            Text(
              _outcome(step, gate),
              style: AppStyle.interNormal(
                size: 11,
                color: gate == StepGate.running
                    ? AppStyle.starColor
                    : AppStyle.textDarkFaint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The outcome kept beside a done step, the clock beside a running one,
  /// the duration beside one ahead.
  String _outcome(TaskRunStep step, StepGate gate) {
    if (step.isDone) {
      if (step.isTimed) return 'took ${formatRunClock(step.elapsedAt(now))}';
      final DateTime? at = step.completedAt;
      return at == null ? 'done' : DateFormat('hh:mm a').format(at);
    }
    if (gate == StepGate.running) return formatRunClock(step.remainingAt(now));
    if (step.isTimed) return formatRunDuration(step.duration);
    return '';
  }
}

/// CHIP 865 — the compact rail for one plane: the same count, the same
/// hairline as segments, and the current/next pair by name.
class _CompactRail extends StatelessWidget {
  const _CompactRail({required this.run, required this.focus, required this.now});

  final TaskRun run;
  final int focus;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final int? next = run.nextOpenFrom(focus + 1);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _RailHead(run: run, focus: focus, now: now),
          8.verticalSpace,
          Text(
            run.steps[focus].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interSemi(size: 12, color: AppStyle.textPrimary),
          ),
          if (next != null && next != focus) ...[
            2.verticalSpace,
            Text(
              'Next: ${run.steps[next].title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
            ),
          ],
        ],
      ),
    );
  }
}

// ------------------------------------------------------------- the card

/// CHIP 853 — one step, its instruction, its clock, and its own Back and
/// Continue. Nothing from the other steps.
class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.run,
    required this.index,
    required this.now,
    required this.compact,
    required this.onStart,
    required this.onContinue,
    this.onBack,
    this.onSkip,
  });

  final TaskRun run;
  final int index;
  final DateTime now;
  final bool compact;
  final VoidCallback onStart;
  final VoidCallback onContinue;
  final VoidCallback? onBack;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    final TaskRunStep step = run.steps[index];
    final StepGate gate = run.gateAt(index, now);
    final bool last = run.leftCount == 1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: gate == StepGate.running ? AppStyle.starColor : AppStyle.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'STEP ${index + 1} OF ${run.total}',
            style: AppStyle.interNormal(
              size: 11,
              color: AppStyle.textDarkFaint,
              letterSpacing: 0.8,
            ),
          ),
          4.verticalSpace,
          Text(
            step.title,
            style: AppStyle.interSemi(size: 16, color: AppStyle.textPrimary),
          ),
          if (step.hasInstruction) ...[
            6.verticalSpace,
            Text(
              step.instruction!.trim(),
              style: AppStyle.interNormal(
                size: 13,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ],
          if (step.isTimed) ...[12.verticalSpace, _clock(step, gate)],
          if (gate == StepGate.running) ...[12.verticalSpace, _blocked(step)],
          16.verticalSpace,
          _actions(gate, last),
          if (onSkip != null) ...[
            8.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                key: TaskRunView.skipKey,
                onPressed: onSkip,
                child: Text(
                  'Skip for now',
                  style: AppStyle.interNormal(
                    size: 12,
                    color: AppStyle.textDarkSecondary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// CHIP 872 — the step clock: the full duration before Start, the live
  /// countdown while it runs, "time's up" once it has run out.
  Widget _clock(TaskRunStep step, StepGate gate) {
    final String reading;
    final String caption;
    final Color tint;
    switch (gate) {
      case StepGate.notStarted:
      case StepGate.locked:
        reading = formatRunClock(step.duration);
        caption = 'Start the clock when you begin';
        tint = AppStyle.textDarkSecondary;
      case StepGate.running:
        reading = formatRunClock(step.remainingAt(now));
        caption = 'left on this step';
        tint = AppStyle.starColor;
      case StepGate.ready:
        reading = formatRunClock(Duration.zero);
        caption = "time's up · took ${formatRunClock(step.elapsedAt(now))}";
        tint = AppStyle.green;
      case StepGate.done:
        reading = formatRunClock(step.elapsedAt(now));
        caption = 'taken';
        tint = AppStyle.green;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          reading,
          style: AppStyle.interSemi(size: 32, color: tint),
        ),
        10.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              caption,
              style: AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
            ),
          ),
        ),
      ],
    );
  }

  /// CHIPS 856 / 858 — the blocked reason, which here is a clock, and the
  /// route out, which honestly says there is none but time. Amber, never
  /// red: nothing has gone wrong. At one plane (46g) it also lists what is
  /// NOT blocked, because a blocked phone screen can read as a dead end.
  Widget _blocked(TaskRunStep step) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppStyle.starColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppStyle.starColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.hourglass_top, size: 14.r, color: AppStyle.starColor),
              6.horizontalSpace,
              Text(
                'Not finished yet',
                style: AppStyle.interSemi(size: 12, color: AppStyle.starColor),
              ),
            ],
          ),
          4.verticalSpace,
          Text(
            '${formatRunClock(step.remainingAt(now))} left on this step\'s clock. '
            'Continue unlocks when it runs out — there is no way past this but time.',
            style: AppStyle.interNormal(size: 12, color: AppStyle.textDarkSecondary),
          ),
          if (compact) ...[
            8.verticalSpace,
            Text(
              'Only forward is blocked. Back still moves a step, Leave still '
              'keeps your progress, and what you have done is already saved.',
              style: AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
            ),
          ],
        ],
      ),
    );
  }

  /// CHIPS 855 / 854 / 857 — the run's Back and the forward control.
  /// Continue is present and disabled with a lock while a clock blocks it,
  /// never hidden.
  Widget _actions(StepGate gate, bool last) {
    final bool blocked = gate == StepGate.running;
    final bool starting = gate == StepGate.notStarted;
    final String forward = starting
        ? 'Start'
        : last
        ? 'Finish run'
        : 'Continue';
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: OutlinedButton(
            key: TaskRunView.backKey,
            onPressed: onBack,
            style: OutlinedButton.styleFrom(
              minimumSize: Size(0, 44.h),
              side: BorderSide(color: AppStyle.strokeDark),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Back',
              style: AppStyle.interSemi(
                size: 13,
                color: onBack == null
                    ? AppStyle.textDarkFaint
                    : AppStyle.textPrimary,
              ),
            ),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          flex: 3,
          child: ElevatedButton.icon(
            key: TaskRunView.continueKey,
            onPressed: blocked
                ? null
                : starting
                ? onStart
                : onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyle.primary,
              foregroundColor: AppStyle.blackColor,
              disabledBackgroundColor: AppStyle.cardDarkAlt,
              disabledForegroundColor: AppStyle.textDarkFaint,
              minimumSize: Size(0, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            icon: Icon(
              blocked
                  ? Icons.lock_outline
                  : starting
                  ? Icons.play_arrow
                  : Icons.check,
              size: 16.r,
            ),
            label: Text(
              forward,
              style: AppStyle.interSemi(
                size: 13,
                color: blocked ? AppStyle.textDarkFaint : AppStyle.blackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------ resume / finish

/// CHIP 860 — "Pick up where you left off": the position, when it was
/// last touched, and what survived, itemised. Resume is primary; Start
/// over is the only thing on the screen that can lose work, and looks it.
class _ResumeCard extends StatelessWidget {
  const _ResumeCard({
    required this.run,
    required this.onResume,
    required this.onStartOver,
  });

  final TaskRun run;
  final VoidCallback onResume;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    final DateTime? touched = run.lastTouched;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppStyle.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Pick up where you left off',
            style: AppStyle.interSemi(size: 16, color: AppStyle.textPrimary),
          ),
          4.verticalSpace,
          Text(
            <String>[
              run.positionLabel ?? '',
              if (touched != null) 'last touched ${_kMomentFormat.format(touched)}',
            ].where((String s) => s.isNotEmpty).join(' · '),
            style: AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
          ),
          10.verticalSpace,
          for (int i = 0; i < run.total; i++)
            if (run.steps[i].isDone || run.steps[i].isStarted)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Row(
                  children: <Widget>[
                    Icon(
                      run.steps[i].isDone ? Icons.check_circle : Icons.timelapse,
                      size: 14.r,
                      color: run.steps[i].isDone ? AppStyle.green : AppStyle.starColor,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        run.steps[i].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.textDarkSecondary,
                        ),
                      ),
                    ),
                    Text(
                      run.steps[i].isDone ? 'kept' : 'clock kept running',
                      style: AppStyle.interNormal(
                        size: 11,
                        color: AppStyle.textDarkFaint,
                      ),
                    ),
                  ],
                ),
              ),
          14.verticalSpace,
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  key: TaskRunView.startOverKey,
                  onPressed: onStartOver,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(0, 44.h),
                    side: BorderSide(color: AppStyle.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Start over',
                    style: AppStyle.interSemi(size: 13, color: AppStyle.red),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  key: TaskRunView.resumeKey,
                  onPressed: onResume,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.primary,
                    foregroundColor: AppStyle.blackColor,
                    minimumSize: Size(0, 44.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Resume',
                    style: AppStyle.interSemi(size: 13, color: AppStyle.blackColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Every step done. The run is over; whether the TASK is done is the
/// host's call, offered here as one button.
class _FinishedCard extends StatelessWidget {
  const _FinishedCard({
    required this.run,
    required this.taskDone,
    this.onMarkDone,
  });

  final TaskRun run;
  final bool taskDone;
  final VoidCallback? onMarkDone;

  @override
  Widget build(BuildContext context) {
    final DateTime? finished = run.lastTouched;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppStyle.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle, size: 18.r, color: AppStyle.green),
              8.horizontalSpace,
              Text(
                'All ${run.total} steps done',
                style: AppStyle.interSemi(size: 16, color: AppStyle.textPrimary),
              ),
            ],
          ),
          if (finished != null) ...[
            4.verticalSpace,
            Text(
              'finished ${_kMomentFormat.format(finished)}',
              style: AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
            ),
          ],
          if (onMarkDone != null && !taskDone) ...[
            14.verticalSpace,
            ElevatedButton(
              key: TaskRunView.markDoneKey,
              onPressed: onMarkDone,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyle.primary,
                foregroundColor: AppStyle.blackColor,
                minimumSize: Size(0, 44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Mark task done',
                style: AppStyle.interSemi(size: 13, color: AppStyle.blackColor),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

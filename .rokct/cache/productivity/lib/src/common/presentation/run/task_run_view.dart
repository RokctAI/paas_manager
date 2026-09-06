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
//
// Design strip section 47 rides the same card. 47h: a READING step draws
// its values as fields with their spec beside them and, while one is
// missing or out of spec, the amber block (856) names the value in the
// frame's words and the route out (858) is to re-test or record why;
// Continue stays present, locked. 47i: a PHOTO step draws the photo slot
// and the note, blocks nothing, and — being optional — carries a live
// Skip beside a working Finish. The photo is a path string picked
// through base_sdk's ImgService; a host or a test may hand in its own
// picker. What is typed is handed back through [TaskRunView.onChanged]
// as it is typed, so a kill mid-entry loses nothing recorded.

import 'dart:async';

import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/img_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:productivity_sdk/src/common/application/run/task_run.dart';
import 'package:productivity_sdk/src/common/presentation/plane_back_clearance.dart';

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
    this.pickPhoto,
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

  /// 47i — how a photo step gets its picture: a path, or null for none.
  /// Null uses base_sdk's ImgService (camera or gallery, the user's
  /// choice). Tests hand in a path.
  final Future<String?> Function(BuildContext context)? pickPhoto;

  /// Keys for hosts and tests.
  static const Key continueKey = Key('task-run-continue');
  static const Key backKey = Key('task-run-back');
  static const Key skipKey = Key('task-run-skip');
  static const Key leaveKey = Key('task-run-leave');
  static const Key resumeKey = Key('task-run-resume');
  static const Key startOverKey = Key('task-run-start-over');
  static const Key markDoneKey = Key('task-run-mark-done');

  /// 47i — the Skip that completes an optional step, not the focus move.
  static const Key skipStepKey = Key('task-run-skip-step');
  static const Key photoKey = Key('task-run-photo');
  static const Key removePhotoKey = Key('task-run-remove-photo');
  static const Key noteKey = Key('task-run-note');

  /// 47h — the field for reading [index] on the step card.
  static Key readingKey(int index) => Key('task-run-reading-$index');

  /// The card's foot while it is pinned above the keyboard.
  static const Key pinnedFooterKey = Key('task-run-pinned-footer');

  @override
  State<TaskRunView> createState() => _TaskRunViewState();
}

class _TaskRunViewState extends State<TaskRunView> with WidgetsBindingObserver {
  Timer? _ticker;

  /// The step the card shows, when the user has moved off the derived
  /// current step (Skip, or tapping a rail row on an any-order run). Null
  /// means "the current step".
  int? _focus;

  /// Chip 860: a run found mid-way opens on the resume card until the
  /// user chooses Resume or Start over.
  bool _resumeChosen = false;

  /// True while a reading or note field on the step card holds the
  /// focus — the keyboard is up, or about to be. Tour run 34040758271,
  /// still 11 (phone): with the numeric keyboard raised the amber block
  /// (856) and the actions row scrolled off under it, so the user could
  /// not see WHY Continue was locked. While this is true the view lifts
  /// the gate notice and the actions out of the card and pins them at
  /// its foot, above the keyboard; the moment focus leaves, they return
  /// to the card and the layout is exactly what it was.
  ///
  /// Read from focus, not from `MediaQuery.viewInsets`: a resizing
  /// Scaffold strips the bottom inset from its body, so inside this view
  /// the inset reads 0 while the keyboard is up.
  bool _typing = false;

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

  /// 47i — Skip on an optional step completes it as skipped.
  void _skipStep(TaskRun run, int index) {
    if (!run.canSkipAt(index)) return;
    final DateTime now = _now();
    final TaskRun next = run.skip(index, now);
    _track('task_run_step_skipped', <String, dynamic>{
      'step': index + 1,
      'steps': run.total,
    });
    if (next.isFinished) {
      _track('task_run_finished', <String, dynamic>{'steps': run.total});
    }
    setState(() => _focus = next.nextOpenFrom(index));
    _emit(next);
  }

  void _recordReading(TaskRun run, int index, int reading, String raw) =>
      _emit(run.recordReading(index, reading, raw));

  void _recordNote(TaskRun run, int index, String note) =>
      _emit(run.recordNote(index, note));

  Future<void> _pickPhoto(TaskRun run, int index) async {
    final String? path =
        await (widget.pickPhoto ?? _pickWithImgService)(context);
    if (!mounted || path == null || path.trim().isEmpty) return;
    _emit(run.recordValue(index, path));
  }

  void _removePhoto(TaskRun run, int index) =>
      _emit(run.recordValue(index, null));

  /// The default picker: camera or gallery, the user's choice, through
  /// base_sdk's ImgService. Returns the picked file's path.
  Future<String?> _pickWithImgService(BuildContext context) async {
    final bool? camera = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppStyle.cardDark,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_camera_outlined,
                  color: AppStyle.textPrimary),
              title: Text(
                'Take a photo',
                style:
                    AppStyle.interNormal(size: 14, color: AppStyle.textPrimary),
              ),
              onTap: () => Navigator.of(context).pop(true),
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined,
                  color: AppStyle.textPrimary),
              title: Text(
                'Choose from the gallery',
                style:
                    AppStyle.interNormal(size: 14, color: AppStyle.textPrimary),
              ),
              onTap: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
    if (camera == null) return null;
    final Object? picked =
        camera ? await ImgService.getCamera() : await ImgService.getGallery();
    return picked is String ? picked : null;
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

  /// Focus entered or left the view's fields. Once the pinned layout has
  /// laid out, the field being typed in is brought back into the (now
  /// shorter) list — the row's own listener ran before the re-flow.
  void _onTypingChanged(bool typing) {
    if (!mounted || typing == _typing) return;
    setState(() => _typing = typing);
    if (!typing) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? focused = FocusManager.instance.primaryFocus?.context;
      if (focused != null && focused.mounted) _revealInScrollable(focused);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TaskRun run = TaskRun.fromTask(widget.task);
    final DateTime now = _now();
    final bool compact = _planeCount(context) < 2;

    final List<Widget> body;
    _StepCard? card;
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
      card = _StepCard(
        run: run,
        index: focus,
        now: now,
        compact: compact,
        footerPinned: _typing,
        onStart: () => _start(run, focus),
        onContinue: () => _complete(run, focus),
        onBack: run.previousDoneBefore(focus) == null
            ? null
            : () => _back(run, focus),
        onSkip:
            run.skipTargetFrom(focus) == null ? null : () => _skip(run, focus),
        onSkipStep: run.canSkipAt(focus) ? () => _skipStep(run, focus) : null,
        onReading: (int reading, String raw) =>
            _recordReading(run, focus, reading, raw),
        onNote: (String note) => _recordNote(run, focus, note),
        onPickPhoto: () => _pickPhoto(run, focus),
        onRemovePhoto: () => _removePhoto(run, focus),
      );
      body = <Widget>[
        if (compact)
          _CompactRail(run: run, focus: focus, now: now)
        else
          _StepRail(
            run: run,
            focus: focus,
            now: now,
            onPick:
                run.sequential ? null : (int i) => setState(() => _focus = i),
          ),
        12.verticalSpace,
        card,
      ];
    }

    final Widget list = ListView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
      children: <Widget>[
        _header(run),
        12.verticalSpace,
        ...body,
      ],
    );
    // The list is ALWAYS the first child of this column, pinned or not,
    // so the re-flow never re-parents it: the field being typed in keeps
    // its element, its text and its focus across the switch.
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onFocusChange: _onTypingChanged,
      child: Column(
        children: <Widget>[
          Expanded(child: list),
          if (_typing && card != null) card.pinnedFooter(context),
        ],
      ),
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
                style:
                    AppStyle.interSemi(size: 18, color: AppStyle.textPrimary),
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
    final StepGate gate = run.gateAt(focus, now);
    final bool blocked =
        gate == StepGate.running || gate == StepGate.incomplete;
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
              style:
                  AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
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
    final Color ring = gate == StepGate.running || gate == StepGate.incomplete
        ? AppStyle.starColor
        : AppStyle.primary;
    final Widget lead;
    if (step.isDone) {
      lead = Container(
        width: 18.r,
        height: 18.r,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppStyle.green),
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
    final VoidCallback? pick =
        onPick == null || step.isDone || current ? null : () => onPick!(i);
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
      if (step.skipped) return 'skipped';
      if (step.isReading) return 'recorded';
      if (step.isPhoto) return step.hasValue ? 'photo kept' : 'noted';
      if (step.isTimed) return 'took ${formatRunClock(step.elapsedAt(now))}';
      final DateTime? at = step.completedAt;
      return at == null ? 'done' : DateFormat('hh:mm a').format(at);
    }
    if (gate == StepGate.running) return formatRunClock(step.remainingAt(now));
    if (step.isTimed) return formatRunDuration(step.duration);
    if (step.optional) return 'optional';
    if (step.isReading) return 'required';
    return '';
  }
}

/// CHIP 865 — the compact rail for one plane: the same count, the same
/// hairline as segments, and the current/next pair by name.
class _CompactRail extends StatelessWidget {
  const _CompactRail(
      {required this.run, required this.focus, required this.now});

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
              style:
                  AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
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
    required this.onReading,
    required this.onNote,
    required this.onPickPhoto,
    required this.onRemovePhoto,
    this.footerPinned = false,
    this.onBack,
    this.onSkip,
    this.onSkipStep,
  });

  final TaskRun run;
  final int index;
  final DateTime now;
  final bool compact;

  /// True while the view draws the card's foot — the gate notice, the
  /// actions row and Skip for now — as [pinnedFooter] above the keyboard
  /// instead of inside the card. Nothing is removed: the same widgets
  /// move, and move back when focus leaves.
  final bool footerPinned;
  final VoidCallback onStart;
  final VoidCallback onContinue;
  final VoidCallback? onBack;

  /// Chip 862 — the focus move on an any-order run.
  final VoidCallback? onSkip;

  /// 47i — Skip that completes an optional step. Null on a required one.
  final VoidCallback? onSkipStep;

  /// 47h — a reading typed: which one, and what.
  final void Function(int reading, String raw) onReading;

  /// 47h / 47i — the note typed.
  final ValueChanged<String> onNote;

  /// 47i — the photo slot.
  final VoidCallback onPickPhoto;
  final VoidCallback onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    final TaskRunStep step = run.steps[index];
    final StepGate gate = run.gateAt(index, now);
    final bool last = run.leftCount == 1;
    final bool blocked =
        gate == StepGate.running || gate == StepGate.incomplete;
    // 47h's route out: an out-of-spec reading may be explained. The note
    // is drawn as soon as one reading is out of spec, and stays once
    // written.
    final bool explainable = step.isReading &&
        (step.hasNote ||
            step.readings.any(
              (ReadingSpec r) => r.status == ReadingStatus.outOfSpec,
            ));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: blocked ? AppStyle.starColor : AppStyle.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'STEP ${index + 1} OF ${run.total}',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                  letterSpacing: 0.8,
                ),
              ),
              // 47h / 47i — the step says which it is, up front.
              if (step.optional || step.isReading) ...<Widget>[
                const Spacer(),
                Text(
                  step.optional ? 'OPTIONAL' : 'REQUIRED',
                  style: AppStyle.interSemi(
                    size: 10,
                    color: step.optional
                        ? AppStyle.textDarkFaint
                        : AppStyle.starColor,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ],
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
          if (step.isReading) ...[
            12.verticalSpace,
            for (int i = 0; i < step.readings.length; i++) ...[
              if (i > 0) 8.verticalSpace,
              _ReadingRow(
                key: ValueKey<String>('reading-$index-$i'),
                index: i,
                reading: step.readings[i],
                enabled: !step.isDone,
                onChanged: (String raw) => onReading(i, raw),
              ),
            ],
          ],
          if (step.isPhoto) ...[12.verticalSpace, _photo(step)],
          if (step.isPhoto || explainable) ...[
            10.verticalSpace,
            _NoteField(
              key: ValueKey<String>('note-$index'),
              note: step.note,
              hint: step.isPhoto
                  ? 'Anything worth remembering next time…'
                  : 'Why it is out of spec',
              onChanged: onNote,
            ),
          ],
          if (!footerPinned) ..._foot(step, gate, last, pinned: false),
        ],
      ),
    );
  }

  /// The card's foot: the gate notice (blocked by time, or by data —
  /// 856's amber block), the actions row, and Skip for now. Inside the
  /// card it follows the fields; pinned, it is drawn by [pinnedFooter].
  List<Widget> _foot(
    TaskRunStep step,
    StepGate gate,
    bool last, {
    required bool pinned,
  }) {
    final Widget? notice = switch (gate) {
      StepGate.running => _blocked(step),
      StepGate.incomplete => _incomplete(step),
      _ => null,
    };
    return <Widget>[
      if (notice != null) ...<Widget>[
        if (!pinned) 12.verticalSpace,
        notice,
        (pinned ? 10 : 16).verticalSpace,
      ] else if (!pinned)
        16.verticalSpace,
      _actions(gate, last),
      if (onSkip != null) ...<Widget>[
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
    ];
  }

  /// The foot, pinned at the bottom of the view while a field is being
  /// typed in (tour run 34040758271, still 11): the amber block and the
  /// actions stay in sight above the keyboard, so a locked Continue is
  /// never a mystery. Same tint and border as the card it came from.
  ///
  /// Two insets under it: the keyboard's, for a host whose Scaffold does
  /// not resize its body (a resizing one strips the inset and this reads
  /// 0), and on a wide window the corner Back pill's — PlaneHost floats
  /// the pill over the pane's foot on /tasks, exactly the room the list
  /// already leaves under its last child. The phone pushes the run as a
  /// page of its own with no pill over it, so it keeps every pixel.
  Widget pinnedFooter(BuildContext context) {
    final TaskRunStep step = run.steps[index];
    final StepGate gate = run.gateAt(index, now);
    final bool last = run.leftCount == 1;
    final bool blocked =
        gate == StepGate.running || gate == StepGate.incomplete;
    return Container(
      key: TaskRunView.pinnedFooterKey,
      padding: EdgeInsets.fromLTRB(
        16.w,
        10.h,
        16.w,
        10.h +
            MediaQuery.viewInsetsOf(context).bottom +
            (compact ? 0 : planeBackClearance()),
      ),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        border: Border(
          top: BorderSide(
            color: blocked ? AppStyle.starColor : AppStyle.primary,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _foot(step, gate, last, pinned: true),
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
      case StepGate.incomplete:
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
              style:
                  AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
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
            style: AppStyle.interNormal(
                size: 12, color: AppStyle.textDarkSecondary),
          ),
          if (compact) ...[
            8.verticalSpace,
            Text(
              'Only forward is blocked. Back still moves a step, Leave still '
              'keeps your progress, and what you have done is already saved.',
              style:
                  AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
            ),
          ],
        ],
      ),
    );
  }

  /// 47h — CHIPS 856 / 858 for a reading step: the block is a VALUE,
  /// named in the frame's words ("Permeate TDS 212 ppm is outside 50
  /// ppm"), and the route out is to re-test or record why. Amber, never
  /// red: a reading out of spec is a fact about the plant, not an error
  /// in the app.
  Widget _incomplete(TaskRunStep step) {
    final ReadingSpec? unmet = step.firstUnmetReading;
    final bool outOfSpec = unmet?.status == ReadingStatus.outOfSpec;
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
              Icon(Icons.rule, size: 14.r, color: AppStyle.starColor),
              6.horizontalSpace,
              Text(
                outOfSpec ? 'Out of spec' : 'Reading missing',
                style: AppStyle.interSemi(size: 12, color: AppStyle.starColor),
              ),
            ],
          ),
          4.verticalSpace,
          Text(
            step.refusal ?? '',
            style: AppStyle.interSemi(size: 12, color: AppStyle.textPrimary),
          ),
          2.verticalSpace,
          Text(
            outOfSpec
                ? 'Re-test, or record why it is out of spec, to continue.'
                : 'Every reading needs a value before this step can continue.',
            style: AppStyle.interNormal(
                size: 12, color: AppStyle.textDarkSecondary),
          ),
          if (compact) ...[
            8.verticalSpace,
            Text(
              'Only forward is blocked. Back still moves a step, Leave still '
              'keeps your progress, and what you have recorded is already saved.',
              style:
                  AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
            ),
          ],
        ],
      ),
    );
  }

  /// 47i — the photo slot: a tile to add one, or the picked file's name
  /// with a way to drop it. A path, never a preview: the run keeps the
  /// path and nothing here reads the file.
  Widget _photo(TaskRunStep step) {
    if (step.hasValue) {
      final String name = step.value!.split(RegExp(r'[\\/]')).last;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppStyle.cardDarkAlt,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppStyle.strokeDarkSubtle),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.photo_outlined, size: 18.r, color: AppStyle.green),
            8.horizontalSpace,
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    AppStyle.interNormal(size: 12, color: AppStyle.textPrimary),
              ),
            ),
            if (!step.isDone)
              TextButton(
                key: TaskRunView.removePhotoKey,
                onPressed: onRemovePhoto,
                child: Text(
                  'Remove',
                  style: AppStyle.interNormal(
                    size: 12,
                    color: AppStyle.textDarkSecondary,
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return InkWell(
      key: TaskRunView.photoKey,
      onTap: step.isDone ? null : onPickPhoto,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppStyle.strokeDark),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.add_a_photo_outlined,
                size: 18.r, color: AppStyle.textDarkSecondary),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Add a photo',
                    style: AppStyle.interSemi(
                        size: 13, color: AppStyle.textPrimary),
                  ),
                  Text(
                    'of the vessel head or the meter',
                    style: AppStyle.interNormal(
                        size: 11, color: AppStyle.textDarkFaint),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CHIPS 855 / 854 / 857 — the run's Back and the forward control.
  /// Continue is present and disabled with a lock while a clock blocks it,
  /// never hidden. 47i adds Skip between them on an optional step.
  Widget _actions(StepGate gate, bool last) {
    final bool blocked =
        gate == StepGate.running || gate == StepGate.incomplete;
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
        if (onSkipStep != null) ...<Widget>[
          10.horizontalSpace,
          Expanded(
            flex: 2,
            child: OutlinedButton(
              key: TaskRunView.skipStepKey,
              onPressed: onSkipStep,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(0, 44.h),
                side: BorderSide(color: AppStyle.strokeDark),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Skip',
                style:
                    AppStyle.interSemi(size: 13, color: AppStyle.textPrimary),
              ),
            ),
          ),
        ],
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

// ---------------------------------------------------- reading / note

/// Scrolls the nearest list so [context]'s widget is wholly in view —
/// pulled up if it sits below the trailing edge (the usual case once the
/// keyboard has shortened the list), down if it sits above the leading
/// one, and left alone when it is already visible. A jump, not a glide:
/// the keyboard's own animation is the only motion on screen.
Future<void> _revealInScrollable(BuildContext context) async {
  await Scrollable.ensureVisible(
    context,
    alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
  );
  if (!context.mounted) return;
  await Scrollable.ensureVisible(
    context,
    alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
  );
}

/// 47h — one reading: label, spec, the field and its unit. The field's
/// text is the one thing this widget keeps, so typing survives the
/// repaint each keystroke causes; the value itself lives on the map.
class _ReadingRow extends StatefulWidget {
  const _ReadingRow({
    super.key,
    required this.index,
    required this.reading,
    required this.enabled,
    required this.onChanged,
  });

  final int index;
  final ReadingSpec reading;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  State<_ReadingRow> createState() => _ReadingRowState();
}

class _ReadingRowState extends State<_ReadingRow> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.reading.value ?? '');
  late final FocusNode _focus = FocusNode()..addListener(_onFocus);

  /// Focus arrived: bring the whole row — label, spec and field — into
  /// the list once the keyboard's re-flow has laid out.
  void _onFocus() {
    if (!_focus.hasFocus) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _revealInScrollable(context);
    });
  }

  @override
  void didUpdateWidget(_ReadingRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The map moved under us (Start over, a pull): follow it. Our own
    // keystrokes come back as the same text and change nothing.
    final String next = widget.reading.value ?? '';
    if (next != (oldWidget.reading.value ?? '') && next != _controller.text) {
      _controller.text = next;
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.reading.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    widget.onChanged(
      '${picked.year.toString().padLeft(4, '0')}-'
      '${picked.month.toString().padLeft(2, '0')}-'
      '${picked.day.toString().padLeft(2, '0')}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final ReadingSpec reading = widget.reading;
    final ReadingStatus status = reading.status;
    final Color tint = switch (status) {
      ReadingStatus.empty => AppStyle.strokeDark,
      ReadingStatus.inSpec => AppStyle.green,
      ReadingStatus.outOfSpec => AppStyle.starColor,
    };
    final Widget field;
    if (reading.isDate) {
      field = InkWell(
        key: TaskRunView.readingKey(widget.index),
        onTap: widget.enabled ? _pickDate : null,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
            color: AppStyle.cardDarkAlt,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: tint),
          ),
          child: Text(
            reading.hasValue ? reading.value! : 'Pick a date',
            style: AppStyle.interNormal(
              size: 13,
              color: reading.hasValue
                  ? AppStyle.textPrimary
                  : AppStyle.textDarkFaint,
            ),
          ),
        ),
      );
    } else {
      field = TextField(
        key: TaskRunView.readingKey(widget.index),
        controller: _controller,
        focusNode: _focus,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: AppStyle.interSemi(size: 15, color: AppStyle.textPrimary),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppStyle.cardDarkAlt,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: tint),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppStyle.primary),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: tint),
          ),
        ),
      );
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                reading.label,
                style:
                    AppStyle.interNormal(size: 12, color: AppStyle.textPrimary),
              ),
              if (reading.specLabel.isNotEmpty)
                Text(
                  reading.specLabel,
                  style: AppStyle.interNormal(
                    size: 11,
                    color: status == ReadingStatus.outOfSpec
                        ? AppStyle.starColor
                        : AppStyle.textDarkFaint,
                  ),
                ),
            ],
          ),
        ),
        8.horizontalSpace,
        SizedBox(width: reading.isDate ? 140.w : 90.w, child: field),
        if (reading.unit.isNotEmpty) ...<Widget>[
          6.horizontalSpace,
          SizedBox(
            width: 34.w,
            child: Text(
              reading.unit,
              style:
                  AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
            ),
          ),
        ],
      ],
    );
  }
}

/// 47i's note ("anything worth remembering next time") and 47h's "record
/// why it is out of spec". Same keep-the-text rule as [_ReadingRow].
class _NoteField extends StatefulWidget {
  const _NoteField({
    super.key,
    required this.note,
    required this.hint,
    required this.onChanged,
  });

  final String? note;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<_NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<_NoteField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.note ?? '');
  late final FocusNode _focus = FocusNode()..addListener(_onFocus);

  void _onFocus() {
    if (!_focus.hasFocus) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _revealInScrollable(context);
    });
  }

  @override
  void didUpdateWidget(_NoteField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final String next = widget.note ?? '';
    if (next != (oldWidget.note ?? '') && next != _controller.text) {
      _controller.text = next;
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: TaskRunView.noteKey,
      controller: _controller,
      focusNode: _focus,
      onChanged: widget.onChanged,
      minLines: 2,
      maxLines: 4,
      style: AppStyle.interNormal(size: 13, color: AppStyle.textPrimary),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle:
            AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
        filled: true,
        fillColor: AppStyle.cardDarkAlt,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
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
              if (touched != null)
                'last touched ${_kMomentFormat.format(touched)}',
            ].where((String s) => s.isNotEmpty).join(' · '),
            style:
                AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
          ),
          10.verticalSpace,
          for (int i = 0; i < run.total; i++)
            if (run.steps[i].isDone || run.steps[i].isStarted)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Row(
                  children: <Widget>[
                    Icon(
                      run.steps[i].isDone
                          ? Icons.check_circle
                          : Icons.timelapse,
                      size: 14.r,
                      color: run.steps[i].isDone
                          ? AppStyle.green
                          : AppStyle.starColor,
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
                      run.steps[i].isDone
                          ? (run.steps[i].skipped ? 'skipped' : 'kept')
                          : run.steps[i].isTimed
                              ? 'clock kept running'
                              : 'kept',
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
                    style: AppStyle.interSemi(
                        size: 13, color: AppStyle.blackColor),
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
                style:
                    AppStyle.interSemi(size: 16, color: AppStyle.textPrimary),
              ),
            ],
          ),
          if (finished != null) ...[
            4.verticalSpace,
            Text(
              'finished ${_kMomentFormat.format(finished)}',
              style:
                  AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
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

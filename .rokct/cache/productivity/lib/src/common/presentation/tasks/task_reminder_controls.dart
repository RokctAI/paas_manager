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

// Design strip section 47, the visible half — the three task-level
// behaviours the owner asked for on tasks, generic to every task:
//
//   47k  1060 the snooze control (it counts itself), 1061 the two-clock
//        row REMIND / DUE, 1063 the invariant written on the screen;
//   47l  1062 the snooze sheet — three fixed offsets and a free pick, the
//        weekend case pre-selected, the invariant restated at the point
//        of choosing;
//   47m  1064 the long-term band header;
//   47n  1066 / 1067 / 1068 the sync-state badge — this device, syncing,
//        synced — plus the parked-failure state the exhibit insists on.
//
// THE DEADLINE DOES NOT MOVE. Nothing in this file can write one: the
// sheet hands back a reminder time and nothing else, and the row draws
// both clocks side by side precisely so an operator can see that.
//
// The long-term band keys off the task's own `isLongTerm` flag. The
// surfacing rule frame 47m proposed (recurrence not None and a cycle of
// seven days or more) awaits the owner's word and is deliberately NOT
// derived here.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:productivity_sdk/src/common/application/sync/task_sync_state.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/task_view_model.dart';

/// The shipped deadline format, so REMIND and DUE read alike.
final DateFormat _kClockFormat = DateFormat('EEE dd MMM, hh:mm a');

/// CHIPS 1060 / 1061 / 1063 — the two-clock row with the snooze control.
///
/// Drawn only for a task with a reminder. REMIND is the effective reminder
/// time (a snoozed one, else the deadline); DUE is the deadline and is
/// never anything else.
class TaskReminderRow extends StatelessWidget {
  const TaskReminderRow({super.key, required this.task, this.onSnooze});

  final TaskViewModel task;

  /// Chip 1060. Null hides the control (a done task, or a host that does
  /// not snooze).
  final VoidCallback? onSnooze;

  static const Key snoozeKey = Key('task-snooze-control');

  @override
  Widget build(BuildContext context) {
    final DateTime? remind = task.effectiveRemindAt;
    final DateTime? due = task.deadline;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _clock(
                  'REMIND',
                  remind,
                  icon: Icons.notifications_none,
                  tint: AppStyle.primary,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: _clock(
                  'DUE',
                  due,
                  icon: Icons.schedule,
                  tint: AppStyle.textPrimary,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Snoozing moves the reminder, never the deadline.',
                  style: AppStyle.interNormal(
                    size: 11,
                    color: AppStyle.textDarkFaint,
                  ),
                ),
              ),
              if (onSnooze != null) ...[
                8.horizontalSpace,
                _SnoozeControl(count: task.snoozeCount, onTap: onSnooze!),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _clock(
    String label,
    DateTime? at, {
    required IconData icon,
    required Color tint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: AppStyle.interNormal(
            size: 10,
            color: AppStyle.textDarkFaint,
            letterSpacing: 0.8,
          ),
        ),
        3.verticalSpace,
        Row(
          children: <Widget>[
            Icon(icon, size: 13.r, color: tint),
            4.horizontalSpace,
            Expanded(
              child: Text(
                at == null ? 'not set' : _kClockFormat.format(at),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.interSemi(size: 12, color: tint),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// CHIP 1060 — one tap, and it counts itself.
class _SnoozeControl extends StatelessWidget {
  const _SnoozeControl({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: TaskReminderRow.snoozeKey,
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppStyle.primary),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.snooze, size: 13.r, color: AppStyle.primary),
            4.horizontalSpace,
            Text(
              count > 0 ? 'Snoozed ×$count' : 'Snooze',
              style: AppStyle.interSemi(size: 12, color: AppStyle.primary),
            ),
          ],
        ),
      ),
    );
  }
}

/// One choice on the snooze sheet.
class SnoozeOption {
  const SnoozeOption({required this.label, required this.remindAt});

  final String label;
  final DateTime remindAt;
}

/// CHIP 1062 — the fixed choices, computed from [now]. Pure, so the sheet's
/// arithmetic can be pinned without a widget tree.
///
/// The second option — tomorrow morning — is the pre-selected one: the
/// owner's own case is a Saturday reminder on a job meant for Sunday.
List<SnoozeOption> snoozeOptions(DateTime now) {
  DateTime morningOf(DateTime day) => DateTime(day.year, day.month, day.day, 7);
  final DateTime tomorrow = now.add(const Duration(days: 1));
  final DateTime nextWeek = now.add(const Duration(days: 7));
  return <SnoozeOption>[
    SnoozeOption(label: 'In an hour', remindAt: now.add(const Duration(hours: 1))),
    SnoozeOption(label: 'Tomorrow morning', remindAt: morningOf(tomorrow)),
    SnoozeOption(label: 'Next week', remindAt: morningOf(nextWeek)),
  ];
}

/// The index of the pre-selected option in [snoozeOptions].
const int kSnoozeDefaultOption = 1;

/// CHIP 1062 — the snooze sheet. Overlays; takes no planes.
///
/// Resolves to the new reminder time, or null when dismissed. It returns a
/// reminder time ONLY — a caller cannot get a deadline out of it.
Future<DateTime?> showSnoozeSheet(
  BuildContext context, {
  required TaskViewModel task,
  DateTime? now,
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: AppStyle.cardDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (BuildContext context) =>
        _SnoozeSheet(task: task, now: now ?? DateTime.now()),
  );
}

class _SnoozeSheet extends StatefulWidget {
  const _SnoozeSheet({required this.task, required this.now});

  final TaskViewModel task;
  final DateTime now;

  @override
  State<_SnoozeSheet> createState() => _SnoozeSheetState();
}

class _SnoozeSheetState extends State<_SnoozeSheet> {
  late final List<SnoozeOption> _options = snoozeOptions(widget.now);
  int _selected = kSnoozeDefaultOption;
  DateTime? _picked;

  DateTime get _chosen => _picked ?? _options[_selected].remindAt;

  Future<void> _pick() async {
    final DateTime seed = _picked ?? _options[_selected].remindAt;
    final DateTime? day = await showDatePicker(
      context: context,
      initialDate: seed,
      firstDate: widget.now,
      lastDate: DateTime(2100),
    );
    if (day == null || !mounted) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(seed),
    );
    if (time == null || !mounted) return;
    setState(() {
      _picked = DateTime(day.year, day.month, day.day, time.hour, time.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? due = widget.task.deadline;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Snooze the reminder',
              style: AppStyle.interSemi(size: 16, color: AppStyle.textPrimary),
            ),
            4.verticalSpace,
            Text(
              widget.task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
            ),
            12.verticalSpace,
            for (int i = 0; i < _options.length; i++)
              _row(
                label: _options[i].label,
                when: _options[i].remindAt,
                selected: _picked == null && _selected == i,
                onTap: () => setState(() {
                  _picked = null;
                  _selected = i;
                }),
              ),
            _row(
              label: 'Pick a time',
              when: _picked,
              selected: _picked != null,
              onTap: _pick,
            ),
            12.verticalSpace,
            // CHIP 1063, restated at the point of choosing: this is the
            // moment an operator could believe he is buying more time.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppStyle.cardDarkAlt,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                due == null
                    ? 'Only the reminder moves.'
                    : 'Still due ${_kClockFormat.format(due)} — a snooze moves '
                          'the reminder, never the deadline.',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkSecondary,
                ),
              ),
            ),
            12.verticalSpace,
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_chosen),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyle.primary,
                foregroundColor: AppStyle.blackColor,
                minimumSize: Size(0, 44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Remind me ${_kClockFormat.format(_chosen)}',
                style: AppStyle.interSemi(size: 13, color: AppStyle.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The tick is drawn on the selected row rather than a radio column,
  /// matching the sheet idiom the strip already uses.
  Widget _row({
    required String label,
    required DateTime? when,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 4.w),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: AppStyle.interSemi(
                  size: 13,
                  color: selected ? AppStyle.primary : AppStyle.textPrimary,
                ),
              ),
            ),
            Text(
              when == null ? '' : _kClockFormat.format(when),
              style: AppStyle.interNormal(
                size: 11,
                color: AppStyle.textDarkFaint,
              ),
            ),
            8.horizontalSpace,
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              size: 16.r,
              color: selected ? AppStyle.primary : AppStyle.strokeDark,
            ),
          ],
        ),
      ),
    );
  }
}

/// CHIP 1064 — the long-term band's header: a labelled band above the
/// day's work, carrying its count.
class LongTermBandHeader extends StatelessWidget {
  const LongTermBandHeader({super.key, required this.count});

  final int count;

  /// The band's tint, shared with the card marker so the two read as one.
  static Color get tint => AppStyle.blueBonus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: <Widget>[
          Icon(Icons.horizontal_rule, size: 14.r, color: tint),
          6.horizontalSpace,
          Text(
            'LONG TERM',
            style: AppStyle.interSemi(size: 11, color: tint, letterSpacing: 0.8),
          ),
          6.horizontalSpace,
          Text(
            '$count',
            style: AppStyle.interNormal(size: 11, color: AppStyle.textDarkFaint),
          ),
          8.horizontalSpace,
          Expanded(child: Divider(color: tint.withValues(alpha: 0.35), height: 1)),
        ],
      ),
    );
  }
}

/// CHIPS 1066 / 1067 / 1068 — the sync-state badge, plus the parked
/// failure the exhibit insists is drawn rather than dropped.
class TaskSyncBadge extends StatelessWidget {
  const TaskSyncBadge({super.key, required this.state});

  final TaskSyncState state;

  /// The words on each state. "This device" is the claim the badge can
  /// honestly make before the server has the task; "Synced" is earned only
  /// once the outbox row is gone and the server's id is on the row.
  static String labelFor(TaskSyncState state) => switch (state) {
    TaskSyncState.thisDevice => 'This device',
    TaskSyncState.syncing => 'Syncing',
    TaskSyncState.synced => 'Synced',
    TaskSyncState.failed => 'Sync failed',
  };

  static IconData iconFor(TaskSyncState state) => switch (state) {
    TaskSyncState.thisDevice => Icons.smartphone,
    TaskSyncState.syncing => Icons.sync,
    TaskSyncState.synced => Icons.cloud_done_outlined,
    TaskSyncState.failed => Icons.error_outline,
  };

  static Color tintFor(TaskSyncState state) => switch (state) {
    TaskSyncState.thisDevice => AppStyle.textDarkSecondary,
    TaskSyncState.syncing => AppStyle.starColor,
    TaskSyncState.synced => AppStyle.green,
    TaskSyncState.failed => AppStyle.red,
  };

  @override
  Widget build(BuildContext context) {
    final Color color = tintFor(state);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(iconFor(state), size: 11.r, color: color),
          4.horizontalSpace,
          Text(
            labelFor(state),
            style: AppStyle.interNormal(size: 11, color: color),
          ),
        ],
      ),
    );
  }
}

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

// CHIPS 825 and 826 of design strip section 44 — the task card and the
// subtask check line.
//
// EVERY FIELD ON THE CARD IS A REAL FIELD. Priority, deadline, category,
// recurrence and reminder all exist in the shipped page's task map; the
// deadline keeps the shipped `DateFormat('MMM dd, hh:mm a')` exactly.
//
// SUBTASK PROGRESS IS DERIVED FROM THE LIST, NEVER READ. There is no
// progress field anywhere to read — the same honesty rule section 41
// used for mastery goals. `TaskViewModel.subtaskProgress` does the
// deriving and this widget only draws it.
//
// The check line is DELIBERATELY the same shape as 41c's ToDo check line
// so that a task's subtasks and a mastery goal's todos read alike.
//
// Sections 46 and 47 add to the card without changing its shape: chip 859
// (the run badge and the Run pill, drawn only for a task with steps), the
// 47n sync-state badge in the meta run, the 47m long-term marker, and —
// when the card is expanded on the fold — the 47k two-clock row with its
// snooze control. Every one of them is derived from the task map.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:productivity_sdk/src/common/application/run/task_run.dart';
import 'package:productivity_sdk/src/common/application/sync/task_sync_state.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/task_reminder_controls.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/task_view_model.dart';

/// The shipped deadline format, kept verbatim.
final DateFormat kTaskDeadlineFormat = DateFormat('MMM dd, hh:mm a');

/// The shipped `_priorities` tinting: High red, Medium amber, Low blue.
Color taskPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return AppStyle.red;
    case 'low':
      return AppStyle.blue;
    default:
      return AppStyle.starColor;
  }
}

/// CHIP 825 — the full-width section-33 list card.
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleDone,
    this.onTap,
    this.selected = false,
    this.expanded = false,
    this.onToggleSubtask,
    this.onRemoveSubtask,
    this.onRun,
    this.runLabel,
    this.syncState,
    this.onSnooze,
  });

  final TaskViewModel task;
  final VoidCallback onToggleDone;
  final VoidCallback? onTap;

  /// CHIP 859 — opens the guided run. Drawn only for an open task with
  /// steps; null hides the pill.
  final VoidCallback? onRun;

  /// The words on the run pill: "Run" for an untouched run, "Resume ·
  /// Step 3 of 6" for one mid-way. Derived by the host from [TaskRun];
  /// null falls back to "Run".
  final String? runLabel;

  /// CHIPS 1066 / 1067 / 1068 — where this task stands with the server.
  /// Null draws no badge.
  final TaskSyncState? syncState;

  /// CHIP 1060 — snooze, offered on the expanded card. Null hides the
  /// control; the two clocks are still drawn for a task with a reminder.
  final VoidCallback? onSnooze;

  /// Lit while this card's task holds the detail or compose plane.
  final bool selected;

  /// FRAME 44d — the phone fold. The card expands IN PLACE so the detail
  /// plane's subtask check lines still reach the phone rather than
  /// becoming a second push. The expansion IS the fold; there is no
  /// separate phone detail screen.
  final bool expanded;

  final void Function(int index)? onToggleSubtask;
  final void Function(int index)? onRemoveSubtask;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppStyle.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppStyle.cardDark,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? AppStyle.primary : AppStyle.strokeDarkSubtle,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _checkbox(),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          task.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppStyle.interSemi(
                                size: 14,
                                color: task.isDone
                                    ? AppStyle.textDarkFaint
                                    : AppStyle.textPrimary,
                              ).copyWith(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                        ),
                        if (_metaChips.isNotEmpty) ...[
                          6.verticalSpace,
                          Wrap(
                            spacing: 6.w,
                            runSpacing: 4.h,
                            children: _metaChips,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (task.hasSubtasks) ...[8.verticalSpace, _subtaskProgress()],
              if (expanded && task.hasReminder) ...[
                8.verticalSpace,
                TaskReminderRow(
                  task: task,
                  onSnooze: task.isDone ? null : onSnooze,
                ),
              ],
              if (expanded && task.hasSubtasks) ...[
                8.verticalSpace,
                for (var i = 0; i < task.subtasks.length; i++)
                  SubtaskCheckLine(
                    subtask: task.subtasks[i],
                    onToggle: onToggleSubtask == null
                        ? null
                        : () => onToggleSubtask!(i),
                    onRemove: onRemoveSubtask == null
                        ? null
                        : () => onRemoveSubtask!(i),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// The key on the done checkbox, so a caller (and this SDK's tests)
  /// can reach it without depending on widget-tree order.
  static const Key doneCheckboxKey = Key('task-card-done-checkbox');

  /// The key on the run pill (859).
  static const Key runKey = Key('task-card-run');

  /// The 19px round checkbox on `isDone`.
  Widget _checkbox() {
    return GestureDetector(
      key: doneCheckboxKey,
      onTap: onToggleDone,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 19.r,
        height: 19.r,
        margin: EdgeInsets.only(top: 2.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: task.isDone ? AppStyle.primary : AppStyle.transparent,
          border: Border.all(
            color: task.isDone ? AppStyle.primary : AppStyle.strokeDark,
            width: 1.5,
          ),
        ),
        child: task.isDone
            ? Icon(Icons.check, size: 13.r, color: AppStyle.blackColor)
            : null,
      ),
    );
  }

  /// The meta chip run: priority flag, deadline, category, recurrence,
  /// reminder bell — each drawn only when the field carries something.
  List<Widget> get _metaChips {
    final chips = <Widget>[
      _chip(
        icon: Icons.flag,
        label: task.priority,
        tint: taskPriorityColor(task.priority),
      ),
    ];
    final deadline = task.deadline;
    if (deadline != null) {
      chips.add(
        _chip(
          icon: Icons.schedule,
          label: kTaskDeadlineFormat.format(deadline),
        ),
      );
    }
    final category = task.category;
    if (category != null && category.isNotEmpty) {
      chips.add(_chip(icon: Icons.label_outline, label: category));
    }
    // FLAG (b): drawn because the field is real, flagged because nothing
    // acts on it. None is not drawn — an absent repeat is not a label.
    if (task.recurrence.isNotEmpty && task.recurrence != 'None') {
      chips.add(_chip(icon: Icons.repeat, label: task.recurrence));
    }
    // FLAG (c): a reminder is a LOCAL notification at the deadline and
    // nothing more — until it syncs (47n), and the badge below says which.
    if (task.hasReminder) {
      chips.add(
        _chip(
          icon: Icons.notifications_none,
          label: task.snoozeCount > 0 ? '×${task.snoozeCount}' : null,
        ),
      );
    }
    // CHIP 1064's marker on the card, in the band's own tint.
    if (task.isLongTerm) {
      chips.add(
        _chip(
          icon: Icons.horizontal_rule,
          label: 'Long term',
          tint: LongTermBandHeader.tint,
        ),
      );
    }
    final TaskSyncState? sync = syncState;
    if (sync != null) chips.add(TaskSyncBadge(state: sync));
    return chips;
  }

  Widget _chip({required IconData icon, String? label, Color? tint}) {
    final color = tint ?? AppStyle.textDarkSecondary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.r, color: color),
          if (label != null) ...[
            4.horizontalSpace,
            Text(label, style: AppStyle.interNormal(size: 11, color: color)),
          ],
        ],
      ),
    );
  }

  /// "N of M" over a 3px bar. Both numbers are counted from the list.
  /// Beside it, chip 859: the run pill, which says where a run stopped
  /// without the task being opened.
  Widget _subtaskProgress() {
    final progress = task.subtaskProgress ?? 0;
    final TaskRun run = task.run;
    final String position = run.positionLabel ?? '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                position.isEmpty
                    ? '${task.subtasksDone} of ${task.subtasks.length}'
                    : '${task.subtasksDone} of ${task.subtasks.length} · $position',
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkFaint,
                ),
              ),
              4.verticalSpace,
              ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: SizedBox(
                  height: 3.h,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppStyle.strokeDarkSubtle,
                    valueColor: AlwaysStoppedAnimation<Color>(AppStyle.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (onRun != null && !task.isDone) ...[
          10.horizontalSpace,
          GestureDetector(
            key: runKey,
            onTap: onRun,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppStyle.primary.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppStyle.primary),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    run.isInProgress ? Icons.play_circle_outline : Icons.play_arrow,
                    size: 13.r,
                    color: AppStyle.primary,
                  ),
                  4.horizontalSpace,
                  Text(
                    runLabel ?? (run.isInProgress ? 'Resume' : 'Run'),
                    style: AppStyle.interSemi(size: 11, color: AppStyle.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// CHIP 826 — one `subtasks` entry as a check line.
class SubtaskCheckLine extends StatelessWidget {
  const SubtaskCheckLine({
    super.key,
    required this.subtask,
    this.onToggle,
    this.onRemove,
  });

  final SubtaskViewModel subtask;
  final VoidCallback? onToggle;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 16.r,
              height: 16.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: subtask.isDone ? AppStyle.primary : AppStyle.transparent,
                border: Border.all(
                  color: subtask.isDone
                      ? AppStyle.primary
                      : AppStyle.strokeDark,
                  width: 1.4,
                ),
              ),
              child: subtask.isDone
                  ? Icon(Icons.check, size: 11.r, color: AppStyle.blackColor)
                  : null,
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtask.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppStyle.interNormal(
                        size: 12,
                        color: subtask.isDone
                            ? AppStyle.textDarkFaint
                            : AppStyle.textDarkSecondary,
                      ).copyWith(
                        decoration: subtask.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                ),
                // Section 46: a step's duration and instruction, when set.
                if (subtask.detailLine.isNotEmpty)
                  Text(
                    subtask.detailLine,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.interNormal(
                      size: 10,
                      color: AppStyle.textDarkFaint,
                    ),
                  ),
              ],
            ),
          ),
          if (onRemove != null)
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Icon(
                  Icons.close,
                  size: 14.r,
                  color: AppStyle.textDarkFaint,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

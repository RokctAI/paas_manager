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

// CHIPS 827, 828 and 831 of design strip section 44, plus the section-33
// list header (canonical 700) and the status tab row (canonical 362 /
// 363).
//
// EVERY LIST RUNS THE SECTION-33 LIST LANGUAGE — Ray's standard for
// every list screen. What lands here is that language applied to the
// three controls the shipped page already has, and one strip stating a
// fact the shipped page never states at all.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/task_view_model.dart';

/// CANONICAL 700 — the section-33 list header: title plus count pill.
class TaskListHeader extends StatelessWidget {
  const TaskListHeader({
    super.key,
    required this.title,
    required this.count,
    this.actions = const [],
  });

  final String title;
  final int count;

  /// The header utilities: chip 832 (calendar mode) and chip 835
  /// (Backup) live here on 44a, 44b and 44d alike.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interSemi(size: 18, color: AppStyle.textPrimary),
          ),
        ),
        8.horizontalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppStyle.cardDarkAlt,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count',
            style: AppStyle.interSemi(
              size: 12,
              color: AppStyle.textDarkSecondary,
            ),
          ),
        ),
        const Spacer(),
        ...actions,
      ],
    );
  }
}

/// CANONICAL 362 / 363 — All / Pending / Completed as colour-coded tabs
/// carrying their own count pills.
///
/// Re-dresses the shipped `ChoiceChip` row. The counts are passed in,
/// derived by the caller from the same list the tabs filter — there is
/// no count field to read.
class TaskStatusTabs extends StatelessWidget {
  const TaskStatusTabs({
    super.key,
    required this.active,
    required this.counts,
    required this.onChanged,
  });

  final TaskStatusFilter active;
  final Map<TaskStatusFilter, int> counts;
  final ValueChanged<TaskStatusFilter> onChanged;

  static const _labels = {
    TaskStatusFilter.all: 'All',
    TaskStatusFilter.pending: 'Pending',
    TaskStatusFilter.completed: 'Completed',
  };

  /// The colour coding: pending amber, completed green, all neutral.
  static Color tintFor(TaskStatusFilter filter) {
    switch (filter) {
      case TaskStatusFilter.pending:
        return AppStyle.starColor;
      case TaskStatusFilter.completed:
        return AppStyle.green;
      case TaskStatusFilter.all:
        return AppStyle.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final filter in TaskStatusFilter.values) ...[
          _tab(filter),
          if (filter != TaskStatusFilter.values.last) 8.horizontalSpace,
        ],
      ],
    );
  }

  Widget _tab(TaskStatusFilter filter) {
    final isActive = filter == active;
    final tint = tintFor(filter);
    return GestureDetector(
      onTap: () => onChanged(filter),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isActive ? tint.withValues(alpha: 0.16) : AppStyle.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isActive ? tint : AppStyle.strokeDarkSubtle,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _labels[filter]!,
              style: AppStyle.interSemi(
                size: 12,
                color: isActive ? tint : AppStyle.textDarkSecondary,
              ),
            ),
            6.horizontalSpace,
            Text(
              '${counts[filter] ?? 0}',
              style: AppStyle.interNormal(
                size: 11,
                color: isActive ? tint : AppStyle.textDarkFaint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CHIP 827 — Created / Deadline / Priority as a 30px three-way segment.
///
/// PROMOTED FROM A DROPDOWN ON PURPOSE: there are only three values and a
/// dropdown hides two of them behind a tap. All three are visible and the
/// active one is lit.
class TaskSortSegment extends StatelessWidget {
  const TaskSortSegment({
    super.key,
    required this.active,
    required this.onChanged,
  });

  final TaskSort active;
  final ValueChanged<TaskSort> onChanged;

  static const _labels = {
    TaskSort.created: 'Created',
    TaskSort.deadline: 'Deadline',
    TaskSort.priority: 'Priority',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      padding: EdgeInsets.all(2.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [for (final sort in TaskSort.values) _segment(sort)],
      ),
    );
  }

  Widget _segment(TaskSort sort) {
    final isActive = sort == active;
    return GestureDetector(
      onTap: () => onChanged(sort),
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isActive ? AppStyle.primary : AppStyle.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          _labels[sort]!,
          style: AppStyle.interSemi(
            size: 11,
            color: isActive ? AppStyle.blackColor : AppStyle.textDarkSecondary,
          ),
        ),
      ),
    );
  }
}

/// CHIP 828 — the local-only strip, and FLAG (a) of the whole section.
///
/// IT SITS ABOVE THE FIRST CARD AT EVERY WIDTH, phone included: the
/// headline fact is not a wide-read luxury.
///
/// NOT A WARNING TINT, AND NOT DISMISSIBLE. The fact does not change
/// between sessions — these tasks live on this device only. There is no
/// remote store and no sync: `TasksTable` is a local drift table and
/// `TodoRepositoryImpl` reads and writes it, and nothing else. The strip
/// names both in code type so a reader can go and check.
class LocalOnlyStrip extends StatelessWidget {
  const LocalOnlyStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Row(
        children: [
          Icon(Icons.wifi_off, size: 14.r, color: AppStyle.textDarkFaint),
          8.horizontalSpace,
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.textDarkSecondary,
                ),
                children: [
                  const TextSpan(text: 'These tasks live on this device '),
                  const TextSpan(text: 'only — no remote store, no sync. '),
                  TextSpan(
                    text: 'TasksTable',
                    style: AppStyle.interNormal(
                      size: 11,
                      color: AppStyle.textPrimary,
                    ).copyWith(fontFamily: 'monospace'),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'TodoRepositoryImpl',
                    style: AppStyle.interNormal(
                      size: 11,
                      color: AppStyle.textPrimary,
                    ).copyWith(fontFamily: 'monospace'),
                  ),
                  const TextSpan(text: ' are the whole story.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CHIP 831 — the subtask composer row.
///
/// DASHED MEANS NOTHING COMMITTED YET — the rule frame 43a used for the
/// driver row. 44 px, plus glyph, and its own label because the detail
/// pane says "Add a subtask" while the compose lane says "Add a step".
class SubtaskComposerRow extends StatelessWidget {
  const SubtaskComposerRow({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: CustomPaint(
        painter: _DashedBorderPainter(color: AppStyle.strokeDark, radius: 10.r),
        child: SizedBox(
          height: 44.h,
          child: Row(
            children: [
              10.horizontalSpace,
              Icon(Icons.add, size: 16.r, color: AppStyle.textDarkSecondary),
              8.horizontalSpace,
              Text(
                label,
                style: AppStyle.interNormal(
                  size: 12,
                  color: AppStyle.textDarkSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    const dash = 4.0;
    const gap = 3.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dash;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0.0, metric.length)),
          paint,
        );
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

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

// DESIGN STRIP FRAME 41c — personal mastery: chips 794 (the weekly
// check-in strip), 792 (the mastery goal card) and 793 (the todo check
// line), in the sec-33/38 list language — the STANDARD for list-shaped
// screens (Ray 12:23Z).
//
// PROGRESS IS DERIVED FROM THE CHILD TABLE. The goal has no status
// field; the only progress metric on show is the real `todos` table —
// "N of M", a thin bar (green at complete), and the ToDo rows as check
// lines. No status tabs (362/363 considered — nothing to tab on, flag
// (b)); the legacy Achieved/Cancelled states are exactly the missing
// field flag (d) names.
//
// THE STRIP STATES TWO SHIPPED SCHEDULERS AS PAGE FACTS:
// `send_weekly_goal_reminders` (Monday) and `send_friday_wins_reminders`
// (Friday), both in productivity/frappe/src/tenant/productivity/tasks.py.
// Flag (d) rides this frame: the Monday query filters Personal Mastery
// Goal on a `status` field the doctype does not have — a backend bug to
// fix at build time, outside this SDK.

import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:productivity_sdk/src/common/models/data/vision_data.dart';

/// `ToDo.date` as the check line prints it: "5 Sep".
final DateFormat kTodoDateFormat = DateFormat('d MMM');

/// CHIP 794 — the weekly check-in strip: the two shipped schedulers
/// surfaced as page facts.
class WeeklyCheckInStrip extends StatelessWidget {
  const WeeklyCheckInStrip({super.key});

  static const String mondayLabel = 'Monday check-in';
  static const String mondayFact = 'a reminder on every open goal';
  static const String fridayLabel = 'Friday wins';
  static const String fridayFact = "log the week's achievements";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.notifications_none_outlined,
            size: 16.r,
            color: AppStyle.primary,
          ),
          10.horizontalSpace,
          Expanded(
            child: Wrap(
              spacing: 16.w,
              runSpacing: 4.h,
              children: <Widget>[
                _fact(mondayLabel, mondayFact),
                _fact(fridayLabel, fridayFact),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fact(String label, String fact) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: label,
            style: AppStyle.interSemi(size: 12, color: AppStyle.textPrimary),
          ),
          TextSpan(
            text: ' · $fact',
            style: AppStyle.interNormal(
              size: 12,
              color: AppStyle.textDarkSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// CHIP 793 — a child ToDo row as a check line: Closed check / Open
/// circle from `ToDo.status`, the description (closed rows dim), the due
/// date (`ToDo.date`) faint at the end.
class TodoCheckLine extends StatelessWidget {
  const TodoCheckLine({super.key, required this.todo});

  final MasteryTodo todo;

  @override
  Widget build(BuildContext context) {
    final bool closed = todo.isClosed;
    final bool dim = closed || todo.isCancelled;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: <Widget>[
          Container(
            width: 16.r,
            height: 16.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: closed ? AppStyle.green : AppStyle.transparent,
              border: Border.all(
                color: closed ? AppStyle.green : AppStyle.strokeDark,
                width: 1.4,
              ),
            ),
            child: closed
                ? Icon(Icons.check, size: 11.r, color: AppStyle.blackColor)
                : null,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              todo.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.interNormal(
                size: 12,
                color: dim
                    ? AppStyle.textDarkFaint
                    : AppStyle.textDarkSecondary,
              ),
            ),
          ),
          if (todo.date != null) ...<Widget>[
            8.horizontalSpace,
            Text(
              kTodoDateFormat.format(todo.date!),
              style: AppStyle.interNormal(
                size: 11,
                color: AppStyle.textDarkFaint,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// CHIP 792 — the mastery goal card: title, description, and the todos
/// child table as the progress truth — "N of M" mini pill, thin bar
/// (green at complete), the rows as check lines.
///
/// A goal whose rows were not sent ([MasteryGoal.todos] null) draws the
/// title and description and NO progress — not "0 of 0", which would
/// claim a count the read did not carry.
class MasteryGoalCard extends StatelessWidget {
  const MasteryGoalCard({super.key, required this.goal});

  final MasteryGoal goal;

  static Key cardKey(String goalName) => Key('mastery-goal-$goalName');

  static String progressLabel(MasteryGoal goal) =>
      '${goal.todosDone} of ${goal.todosTotal}';

  @override
  Widget build(BuildContext context) {
    final bool complete = goal.isComplete;
    final Color bar = complete ? AppStyle.green : AppStyle.primary;
    return Container(
      key: cardKey(goal.name),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyle.blue.withValues(alpha: 0.18),
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 20.r,
                  color: AppStyle.blue,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      goal.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interSemi(
                        size: 15,
                        color: AppStyle.textPrimary,
                      ),
                    ),
                    if (goal.description != null) ...<Widget>[
                      2.verticalSpace,
                      Text(
                        goal.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.textDarkSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (goal.hasTodos) ...<Widget>[
                8.horizontalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: complete
                        ? AppStyle.green.withValues(alpha: 0.12)
                        : AppStyle.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: complete ? AppStyle.green : AppStyle.strokeDark,
                    ),
                  ),
                  child: Text(
                    progressLabel(goal),
                    style: AppStyle.interNormal(
                      size: 11,
                      color: complete
                          ? AppStyle.green
                          : AppStyle.textDarkSecondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (goal.hasTodos) ...<Widget>[
            10.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(2.r),
              child: SizedBox(
                height: 3.h,
                child: LinearProgressIndicator(
                  value: goal.progress ?? 0,
                  backgroundColor: AppStyle.strokeDarkSubtle,
                  valueColor: AlwaysStoppedAnimation<Color>(bar),
                ),
              ),
            ),
            8.verticalSpace,
            Divider(height: 1, color: AppStyle.strokeDarkSubtle),
            6.verticalSpace,
            for (final MasteryTodo todo in goal.todos!)
              TodoCheckLine(todo: todo),
          ],
        ],
      ),
    );
  }
}

/// The goal cards flowing in plane-aligned columns (41c: "two
/// plane-aligned columns" at the fold, one on the phone) — the section-38
/// [ListPlaneColumns] dealt round-robin — or the one line an empty list
/// says. Scrolls, and stops short of the corner pill (347).
class MasteryGoalList extends StatelessWidget {
  const MasteryGoalList({super.key, required this.goals});

  final List<MasteryGoal> goals;

  static const String emptyLabel = 'No mastery goals yet.';

  /// The words in the count pill (canonical 700): "4 goals".
  static String countLabel(int count) => count == 1 ? '1 goal' : '$count goals';

  @override
  Widget build(BuildContext context) {
    if (goals.isEmpty) {
      return Center(
        child: Text(
          emptyLabel,
          style: AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.only(bottom: 88.h),
      children: <Widget>[
        ListPlaneColumns(
          children: <Widget>[
            for (final MasteryGoal goal in goals)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: MasteryGoalCard(goal: goal),
              ),
          ],
        ),
      ],
    );
  }
}

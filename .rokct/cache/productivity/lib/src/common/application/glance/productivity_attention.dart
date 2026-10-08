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

import 'package:productivity_sdk/src/common/models/data/task_data.dart';
import 'package:productivity_sdk/src/common/models/data/objective_data.dart';
import 'package:productivity_sdk/src/common/models/data/vision_data.dart';
import 'package:base_sdk/src/domain/interface/processing_contract.dart';

/// Which of this SDK's three surfaces an attention line came from - and
/// therefore where tapping it goes.
enum ProductivityAttentionSource {
  /// The tasks surface, `/tasks`.
  tasks,

  /// plan on a page, `/vision`.
  plan,

  /// personal mastery, `/vision/mastery`.
  mastery,
}

/// ONE LINE THAT WANTS THE READER NOW.
///
/// [text] is the line as drawn: the row's own words (a task's title, a
/// to-do's description, an objective's title) with the reason in front of
/// it. [routePath] is this SDK's own route for the surface it lives on, so
/// a host opens it by path and never imports a page (ADR-005).
class ProductivityAttentionLine {
  const ProductivityAttentionLine({
    required this.source,
    required this.text,
    required this.routePath,
  });

  final ProductivityAttentionSource source;
  final String text;
  final String routePath;
}

/// WHAT NEEDS ATTENTION, across the three productivity surfaces, as a pure
/// function of rows already in hand.
///
/// Ray, 2026-09-19: "in home the glance has 3 items, task, plan on a page,
/// personal mastery. all these are  productivity. having a productivity
/// button in floating nav is better and the glance show what need
/// attention". The three permanent doors moved to one Productivity entry on
/// the launcher's floating nav (launch_sdk 1.7.5); what the glance shows now
/// is this.
///
/// ONLY FIELDS THESE MODELS ALREADY CARRY. No signal was invented and no
/// doctype column was assumed:
///
///   * a TASK is due when [TaskModel.dueDate] is today or past and
///     [TaskModel.status] is neither `completed` nor `cancelled`;
///   * PLAN ON A PAGE carries no dates at all - the doctypes are skeletal
///     (see vision_data.dart: "no objective status or dates") - so the only
///     thing the plan can honestly ask for is an objective that nothing
///     measures: [PlanBoard.objectives] with no [Kpi] linked, and only when
///     [PlanBoard.kpisRead] says the KPIs were actually read, because an
///     unreadable count is not zero;
///   * PERSONAL MASTERY has no status on the goal (again stated in the
///     model: "THE GOAL HAS NO STATUS FIELD"), so the rows are what speak:
///     a [MasteryTodo] whose [MasteryTodo.date] is today or past and whose
///     [MasteryTodo.status] is neither Closed nor Cancelled, under a goal
///     whose rows were actually sent ([MasteryGoal.hasTodos]).
///
/// Nothing needing attention returns an EMPTY list, and that is the whole
/// quiet case: base_sdk's `GlanceCard` renders `SizedBox.shrink()` for no
/// items, so the glance disappears rather than printing a line about having
/// nothing to say.
abstract final class ProductivityAttention {
  /// This SDK's own route paths, as its manifest mounts them.
  static const String tasksPath = '/tasks';
  static const String planPath = '/vision';
  static const String masteryPath = '/vision/mastery';

  /// At most this many lines from any one surface, soonest first.
  ///
  /// The glance is a glance: three overdue tasks read, thirty do not, and
  /// the surface behind the Productivity entry is where the whole list
  /// lives. Nothing is summarised or counted in the lines themselves, so no
  /// number is claimed.
  static const int maxLinesPerSource = 3;

  /// The states that mean a task is finished and wants nothing.
  static const Set<ProcessingState> finishedStates = <ProcessingState>{
    ProcessingState.completed,
    ProcessingState.cancelled,
  };

  /// Everything that needs the reader now, tasks first, then the plan, then
  /// mastery - the order the three doors were in.
  ///
  /// [now] is the clock; callers pass their own so the rule is testable.
  /// [plan] is null when the plan was not read (a failure, or a host with no
  /// plan), and [masteryGoals] empty for the same.
  static List<ProductivityAttentionLine> select({
    List<TaskModel> tasks = const <TaskModel>[],
    PlanBoard? plan,
    List<MasteryGoal> masteryGoals = const <MasteryGoal>[],
    required DateTime now,
  }) {
    return <ProductivityAttentionLine>[
      ...tasksNeedingAttention(tasks, now: now),
      ...planNeedingAttention(plan),
      ...masteryNeedingAttention(masteryGoals, now: now),
    ];
  }

  /// Tasks due today or overdue and not finished, soonest first.
  static List<ProductivityAttentionLine> tasksNeedingAttention(
    List<TaskModel> tasks, {
    required DateTime now,
  }) {
    final List<TaskModel> due = tasks
        .where((TaskModel task) =>
            !finishedStates.contains(task.status) &&
            task.dueDate != null &&
            !_isAfterDay(task.dueDate!, now))
        .toList()
      ..sort((TaskModel a, TaskModel b) => a.dueDate!.compareTo(b.dueDate!));
    return <ProductivityAttentionLine>[
      for (final TaskModel task in due.take(maxLinesPerSource))
        ProductivityAttentionLine(
          source: ProductivityAttentionSource.tasks,
          text: '${_sameDay(task.dueDate!, now) ? 'Due today' : 'Overdue'}'
              ' - ${task.title}',
          routePath: tasksPath,
        ),
    ];
  }

  /// Objectives on the plan that no KPI measures.
  ///
  /// Skipped entirely when the KPIs were not readable ([PlanBoard.kpisRead]
  /// false): the board itself refuses to draw "0 KPIs" over an unreadable
  /// count, and this refuses to claim one needs attention for the same
  /// reason.
  static List<ProductivityAttentionLine> planNeedingAttention(PlanBoard? plan) {
    if (plan == null || !plan.kpisRead) return const <ProductivityAttentionLine>[];
    final List<StrategicObjective> unmeasured = plan.objectives
        .where((StrategicObjective objective) =>
            plan.kpisOf(objective.name).isEmpty)
        .toList();
    return <ProductivityAttentionLine>[
      for (final StrategicObjective objective
          in unmeasured.take(maxLinesPerSource))
        ProductivityAttentionLine(
          source: ProductivityAttentionSource.plan,
          text: 'Nothing measures - ${objective.title}',
          routePath: planPath,
        ),
    ];
  }

  /// Open mastery to-dos dated today or earlier, soonest first, named under
  /// their goal.
  static List<ProductivityAttentionLine> masteryNeedingAttention(
    List<MasteryGoal> goals, {
    required DateTime now,
  }) {
    final List<_DatedTodo> due = <_DatedTodo>[];
    for (final MasteryGoal goal in goals) {
      if (!goal.hasTodos) continue;
      for (final MasteryTodo todo in goal.todos!) {
        if (todo.isClosed || todo.isCancelled) continue;
        final DateTime? date = todo.date;
        if (date == null || _isAfterDay(date, now)) continue;
        due.add(_DatedTodo(goal: goal, todo: todo, date: date));
      }
    }
    due.sort((_DatedTodo a, _DatedTodo b) => a.date.compareTo(b.date));
    return <ProductivityAttentionLine>[
      for (final _DatedTodo entry in due.take(maxLinesPerSource))
        ProductivityAttentionLine(
          source: ProductivityAttentionSource.mastery,
          text: '${entry.goal.title} - ${entry.todo.description}',
          routePath: masteryPath,
        ),
    ];
  }

  /// Whether [date] falls on a later DAY than [now]. Compared by day, not
  /// by instant: a task due at 09:00 today still needs the reader at 17:00.
  static bool _isAfterDay(DateTime date, DateTime now) {
    return _dayOf(date).isAfter(_dayOf(now));
  }

  static bool _sameDay(DateTime date, DateTime now) =>
      _dayOf(date) == _dayOf(now);

  static DateTime _dayOf(DateTime value) {
    final DateTime local = value.isUtc ? value.toLocal() : value;
    return DateTime(local.year, local.month, local.day);
  }
}

class _DatedTodo {
  const _DatedTodo({
    required this.goal,
    required this.todo,
    required this.date,
  });

  final MasteryGoal goal;
  final MasteryTodo todo;
  final DateTime date;
}

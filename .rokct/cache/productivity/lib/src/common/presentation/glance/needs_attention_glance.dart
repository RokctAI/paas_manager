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

// THE LAUNCHER GLANCE, AFTER THE THREE DOORS LEFT IT.
//
// Ray, 2026-09-19: "in home the glance has 3 items, task, plan on a page,
// personal mastery. all these are  productivity. having a productivity
// button in floating nav is better and the glance show what need
// attention". The three permanent GlanceCardItems this SDK's manifest used
// to inject are replaced by this one widget: the same marker, the same
// injection, the same route-path navigation - what changed is that the
// lines are now what actually wants the reader, and there are none when
// nothing does.
//
// The rule is ProductivityAttention, and it reads only fields these models
// already carry. This widget is the reader and the dress around it.

import 'package:base_sdk/base_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_sdk/src/common/application/glance/productivity_attention.dart';
import 'package:productivity_sdk/src/common/application/tasks/tasks_provider.dart';
import 'package:productivity_sdk/src/common/application/tasks/tasks_state.dart';
import 'package:productivity_sdk/src/common/domain/interface/vision_repository_facade.dart';
import 'package:productivity_sdk/src/common/infrastructure/repositories/vision_repository_impl.dart';
import 'package:productivity_sdk/src/common/models/data/vision_data.dart';
import 'package:remixicon/remixicon.dart';

/// The glance card for a host that composes this SDK: what needs attention
/// across tasks, plan on a page and personal mastery, or nothing at all.
///
/// [onOpen] is the host's, taking one of this SDK's own route PATHS, so the
/// host never imports a page of this SDK and this SDK never imports the
/// host's launcher (ADR-005) - the same contract [PausedRunLine] uses. A
/// host that leaves it null gets lines that are not tappable rather than
/// lines that throw.
class NeedsAttentionGlance extends ConsumerStatefulWidget {
  const NeedsAttentionGlance({
    super.key,
    this.onOpen,
    this.repository,
    this.now,
  });

  final void Function(String routePath)? onOpen;

  /// The plan and mastery reader. Null takes this SDK's own
  /// [VisionRepositoryImpl]; tests pass a stub, and so may a host that has
  /// already built one.
  final VisionRepositoryFacade? repository;

  /// The clock the "due today" wording is read against. Null is now.
  final DateTime? now;

  /// Key the host's tests can find the card by.
  static const Key glanceKey = Key('productivity-needs-attention-glance');

  @override
  ConsumerState<NeedsAttentionGlance> createState() =>
      _NeedsAttentionGlanceState();
}

class _NeedsAttentionGlanceState extends ConsumerState<NeedsAttentionGlance> {
  /// The plan, once read. Null while reading, and null for good when the
  /// read failed - which draws no plan lines rather than an error on the
  /// launcher's home screen. The plan surface itself is where a failure
  /// belongs, and it already prints the backend's own message.
  PlanBoard? _plan;

  List<MasteryGoal> _masteryGoals = const <MasteryGoal>[];

  @override
  void initState() {
    super.initState();
    _read();
  }

  Future<void> _read() async {
    final VisionRepositoryFacade repository =
        widget.repository ?? const VisionRepositoryImpl();
    final ApiResult<PlanBoard> plan = await repository.loadPlan();
    final ApiResult<List<MasteryGoal>> goals =
        await repository.loadMasteryGoals();
    if (!mounted) return;
    setState(() {
      switch (plan) {
        case Success<PlanBoard>(:final data):
          _plan = data;
        case Failure<PlanBoard>():
          _plan = null;
      }
      switch (goals) {
        case Success<List<MasteryGoal>>(:final data):
          _masteryGoals = data;
        case Failure<List<MasteryGoal>>():
          _masteryGoals = const <MasteryGoal>[];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tasks come from the store this SDK already keeps, through the provider
    // the tasks surface itself watches - no second read path.
    final TasksState tasks = ref.watch(tasksStateProvider);
    final List<ProductivityAttentionLine> lines = ProductivityAttention.select(
      tasks: tasks.tasks,
      plan: _plan,
      masteryGoals: _masteryGoals,
      now: widget.now ?? DateTime.now(),
    );
    final void Function(String)? open = widget.onOpen;
    // Nothing needing attention hands GlanceCard an empty list, and it
    // collapses to nothing. No line is printed about having nothing to say.
    return GlanceCard(
      key: NeedsAttentionGlance.glanceKey,
      items: <GlanceCardItem>[
        for (final ProductivityAttentionLine line in lines)
          GlanceCardItem(
            icon: iconFor(line.source),
            text: line.text,
            onTap: open == null ? null : () => open(line.routePath),
          ),
      ],
    );
  }

  /// One icon per surface, so a line still reads as coming from where it
  /// came from.
  ///
  /// Material icons rather than the Remix set the three retired doors wore:
  /// this widget lives in this SDK's `lib`, and this package declares no
  /// icon-set dependency of its own - leaning on one transitively through
  /// base_sdk is exactly what this pubspec's own comments forbid. The shapes
  /// are the same three ideas (a task, a flag, a star).
  static IconData iconFor(ProductivityAttentionSource source) {
    switch (source) {
      case ProductivityAttentionSource.tasks:
        return Remix.checkbox_circle_line;
      case ProductivityAttentionSource.plan:
        return Remix.flag_line;
      case ProductivityAttentionSource.mastery:
        return Remix.star_line;
    }
  }
}

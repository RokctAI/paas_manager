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

// DESIGN STRIP FRAME 41b — the drill: chips 789 (the objective detail
// pane), 790 (the plan breadcrumb) and 791 (the KPI card).
//
// Board -> detail exactly like the kitchen (the 13:06Z pattern): tapping
// an objective opens its detail in the LAST plane with the default claim
// of one, newest wins, and the ALL-declaring board compresses onto the
// leftover planes beside it. The corner pill (347) pops the detail and
// the board re-spreads.
//
// THE KPI CARD DRAWS TITLE + DESCRIPTION ONLY (flag (b)): the KPI doctype
// has no metric, target, current value or unit, so there is no gauge to
// draw; a target lives only as free text inside the description.
// VIEW-FIRST (flag (a)): read-only — no edit verb on the pane.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:productivity_sdk/src/common/models/data/objective_data.dart';
import 'package:productivity_sdk/src/common/models/data/vision_data.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/objective_picker_pane.dart';

/// CHIP 790 — the plan breadcrumb: the doctype link chain Vision ‹ Pillar
/// ‹ Objective rendered as a path, "Vision 2028 › Operations", the pillar
/// leg in the pillar accent.
class PlanBreadcrumb extends StatelessWidget {
  const PlanBreadcrumb({
    super.key,
    this.visionTitle,
    this.pillarTitle,
    required this.accent,
  });

  final String? visionTitle;
  final String? pillarTitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final List<Widget> legs = <Widget>[];
    if (visionTitle != null) {
      legs.add(
        Flexible(
          child: Text(
            visionTitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interNormal(
              size: 12,
              color: AppStyle.textDarkFaint,
            ),
          ),
        ),
      );
    }
    if (pillarTitle != null) {
      if (legs.isNotEmpty) {
        legs.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Icon(
              Icons.chevron_right,
              size: 14.r,
              color: AppStyle.textDarkFaint,
            ),
          ),
        );
      }
      legs.add(
        Flexible(
          child: Text(
            pillarTitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interNormal(size: 12, color: accent),
          ),
        ),
      );
    }
    if (legs.isEmpty) return const SizedBox.shrink();
    return Row(mainAxisSize: MainAxisSize.min, children: legs);
  }
}

/// CHIP 791 — the KPI card: kpi title + description, chart glyph. The
/// HONEST field set — no gauge, because there is nothing to gauge.
class KpiCard extends StatelessWidget {
  const KpiCard({super.key, required this.kpi, required this.accent});

  final Kpi kpi;
  final Color accent;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.show_chart, size: 16.r, color: accent),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  kpi.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interSemi(
                    size: 14,
                    color: AppStyle.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          if (kpi.description != null) ...<Widget>[
            4.verticalSpace,
            Text(
              kpi.description!,
              style: AppStyle.interNormal(
                size: 12,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// CHIP 789 — the objective detail pane: breadcrumb (790), the
/// objective's title + description, then its KPIs (791).
///
/// STATELESS ABOUT THE PLAN: the board is handed in, already read, and
/// the pane derives the pillar, the accent and the KPI list from it.
class ObjectiveDetailPane extends StatelessWidget {
  const ObjectiveDetailPane({
    super.key,
    required this.board,
    required this.objective,
  });

  final PlanBoard board;
  final StrategicObjective objective;

  static const String kpisLabel = 'KPIs';
  static const String noKpisLabel = 'No KPIs on this objective yet.';
  static const String kpisUnreadLabel = 'The KPIs could not be read.';

  @override
  Widget build(BuildContext context) {
    final Pillar? pillar = board.pillarNamed(objective.pillar);
    final Color accent = pillar == null
        ? AppStyle.textDarkSecondary
        : pillarAccent(board.accentIndexOf(pillar.name));
    final List<Kpi> kpis = board.kpisOf(objective.name);
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
      children: <Widget>[
        PlanBreadcrumb(
          visionTitle: board.vision?.title,
          pillarTitle: pillar?.title,
          accent: accent,
        ),
        8.verticalSpace,
        Text(
          objective.title,
          style: AppStyle.interSemi(size: 18, color: AppStyle.textPrimary),
        ),
        if (objective.description != null) ...<Widget>[
          6.verticalSpace,
          Text(
            objective.description!,
            style: AppStyle.interNormal(
              size: 13,
              color: AppStyle.textDarkSecondary,
            ),
          ),
        ],
        14.verticalSpace,
        Divider(height: 1, color: AppStyle.strokeDarkSubtle),
        14.verticalSpace,
        Row(
          children: <Widget>[
            Text(
              kpisLabel,
              style: AppStyle.interSemi(size: 15, color: AppStyle.textPrimary),
            ),
            if (board.kpisRead) ...<Widget>[
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: accent.withValues(alpha: 0.6)),
                ),
                child: Text(
                  '${kpis.length}',
                  style: AppStyle.interSemi(size: 11, color: accent),
                ),
              ),
            ],
          ],
        ),
        10.verticalSpace,
        if (!board.kpisRead)
          Text(
            kpisUnreadLabel,
            style: AppStyle.interNormal(
              size: 12,
              color: AppStyle.textDarkFaint,
            ),
          )
        else if (kpis.isEmpty)
          Text(
            noKpisLabel,
            style: AppStyle.interNormal(
              size: 12,
              color: AppStyle.textDarkFaint,
            ),
          )
        else
          for (int i = 0; i < kpis.length; i++) ...<Widget>[
            if (i > 0) 8.verticalSpace,
            KpiCard(kpi: kpis[i], accent: accent),
          ],
      ],
    );
  }
}

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

// DESIGN STRIP FRAMES 41a / 41b / 41d — the plan board: chips 785 (the
// vision masthead), 786 (the pillar column), 787 (the objective card),
// 788 (the selected-objective highlight) and canonical 700 (the count
// pill).
//
// THE BOARD DECLARES ALL (the kitchen / 34a claim class): the whole
// strategy on one surface is the point of the page, so more space means
// more details — one pillar per plane-aligned column at three planes
// (41a), the same columns in a tighter dress when the drill takes the
// last plane and the board compresses onto two (41b), and stacked
// sections on the phone's one plane (41d). Nothing is lost but the
// spread.
//
// ONLY THE FIELDS THAT EXIST ARE DRAWN (flag (b)). Vision, Pillar and
// Strategic Objective carry title, description and their parent link and
// nothing else: no dates, no status, no KPI gauges. The "N KPIs" pill is
// the one honest measure — DERIVED by counting `get_kpis` — and a pillar's
// accent and glyph are PRESENTATION-ONLY, positional, because the doctype
// has no icon, colour or display_order column.
//
// VIEW-FIRST (flag (a)): no compose or edit chrome anywhere. The backend
// is read-only `get_*` today; the legacy CRUD dialogs become write
// endpoints at build time and are not drawn until they exist.

import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:productivity_sdk/src/common/models/data/objective_data.dart';
import 'package:productivity_sdk/src/common/models/data/vision_data.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/objective_picker_pane.dart';

/// A pillar's glyph, by its position in the pillar list — the same
/// derivation as [pillarAccent], and for the same reason: the Pillar
/// doctype has no icon column, so the glyph is positional dress.
IconData pillarGlyph(int index) {
  const List<IconData> glyphs = <IconData>[
    Icons.groups_outlined,
    Icons.water_drop_outlined,
    Icons.eco_outlined,
    Icons.flag_outlined,
    Icons.star_outline,
  ];
  return glyphs[index % glyphs.length];
}

/// CANONICAL 700 — the section-38 list header: title plus a count pill
/// worded as the frame draws it ("3 pillars · 6 objectives", "4 goals").
class PlanHeader extends StatelessWidget {
  const PlanHeader({super.key, required this.title, this.count});

  final String title;

  /// The words in the pill; null draws no pill (nothing counted yet).
  final String? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interSemi(size: 18, color: AppStyle.textPrimary),
          ),
        ),
        if (count != null) ...<Widget>[
          8.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppStyle.strokeDark),
            ),
            child: Text(
              count!,
              style: AppStyle.interNormal(
                size: 12,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// CHIP 785 — the vision masthead: the single Plan On A Page doc's linked
/// Vision as the page-wide banner. Eye tile, title + "Vision" tag,
/// statement line — title + description, nothing else exists on the
/// doctype.
class VisionMasthead extends StatelessWidget {
  const VisionMasthead({super.key, required this.vision, this.compact = false});

  final Vision vision;

  /// The compact form (41d, and the compressed board of 41b).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double tile = compact ? 40.r : 48.r;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: tile,
            height: tile,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppStyle.primary.withValues(alpha: 0.16),
            ),
            child: Icon(
              Icons.visibility_outlined,
              size: compact ? 18.r : 22.r,
              color: AppStyle.primary,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        vision.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interSemi(
                          size: compact ? 15 : 17,
                          color: AppStyle.textPrimary,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppStyle.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppStyle.primary.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Text(
                        'Vision',
                        style: AppStyle.interNormal(
                          size: 11,
                          color: AppStyle.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (vision.description != null) ...<Widget>[
                  4.verticalSpace,
                  Text(
                    vision.description!,
                    maxLines: compact ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.interNormal(
                      size: compact ? 12 : 13,
                      color: AppStyle.textDarkSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// CHIP 786's head — the accent-tinted pillar header: glyph + title +
/// objective-count badge, then the description line. Accent and glyph
/// are PRESENTATION-ONLY (flag (b)); the count is DERIVED from the
/// objective list.
class PillarHeader extends StatelessWidget {
  const PillarHeader({
    super.key,
    required this.pillar,
    required this.accent,
    required this.glyph,
    required this.objectiveCount,
    this.compact = false,
  });

  final Pillar pillar;
  final Color accent;
  final IconData glyph;
  final int objectiveCount;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: compact ? 8.h : 10.h,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: accent.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(glyph, size: compact ? 16.r : 18.r, color: accent),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  pillar.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interSemi(
                    size: compact ? 14 : 15,
                    color: AppStyle.textPrimary,
                  ),
                ),
              ),
              8.horizontalSpace,
              Container(
                width: 22.r,
                height: 22.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                ),
                child: Text(
                  '$objectiveCount',
                  style: AppStyle.interSemi(
                    size: 11,
                    color: AppStyle.blackColor,
                  ),
                ),
              ),
            ],
          ),
          if (pillar.description != null) ...<Widget>[
            4.verticalSpace,
            Text(
              pillar.description!,
              maxLines: compact ? 1 : 2,
              overflow: TextOverflow.ellipsis,
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

/// CHIP 787 as the plan board draws it — the objective card: title,
/// description, an accent "N KPIs" mini pill (the only honest measure)
/// and a chevron. CHIP 788 — selected: primary border + "Selected" tag,
/// the 769 treatment at the drill moment.
///
/// Frame 44c's [ObjectiveCard] is the same 787 in the picker's dress
/// (pillar tag, round radio); on the board the pillar is the column, so
/// the card carries the description instead.
class PlanObjectiveCard extends StatelessWidget {
  const PlanObjectiveCard({
    super.key,
    required this.objective,
    required this.accent,
    this.kpiCount,
    this.selected = false,
    this.compact = false,
    this.onTap,
  });

  final StrategicObjective objective;

  /// The pillar's accent — the KPI pill's tint.
  final Color accent;

  /// KPIs under this objective, counted; null draws no pill (the count
  /// was not readable, which is not the same as zero).
  final int? kpiCount;

  final bool selected;
  final bool compact;
  final VoidCallback? onTap;

  static Key cardKey(String objectiveName) =>
      Key('plan-objective-$objectiveName');

  static const String selectedLabel = 'Selected';

  static String kpiLabel(int count) => count == 1 ? '1 KPI' : '$count KPIs';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppStyle.transparent,
      child: InkWell(
        key: cardKey(objective.name),
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppStyle.cardDark,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? AppStyle.primary : AppStyle.strokeDarkSubtle,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      objective.title,
                      maxLines: compact ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interSemi(
                        size: compact ? 14 : 15,
                        color: AppStyle.textPrimary,
                      ),
                    ),
                  ),
                  if (selected) ...<Widget>[
                    8.horizontalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppStyle.primary.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppStyle.primary),
                      ),
                      child: Text(
                        selectedLabel,
                        style: AppStyle.interSemi(
                          size: 11,
                          color: AppStyle.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (objective.description != null) ...<Widget>[
                4.verticalSpace,
                Text(
                  objective.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interNormal(
                    size: 12,
                    color: AppStyle.textDarkSecondary,
                  ),
                ),
              ],
              8.verticalSpace,
              Row(
                children: <Widget>[
                  if (kpiCount != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Text(
                        kpiLabel(kpiCount!),
                        style: AppStyle.interNormal(size: 11, color: accent),
                      ),
                    ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 18.r,
                    color: AppStyle.textDarkFaint,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CHIP 786 — a pillar as a plane-aligned column (or a stacked section
/// on the phone): its header, then its objective cards.
class PillarColumn extends StatelessWidget {
  const PillarColumn({
    super.key,
    required this.board,
    required this.pillar,
    this.selectedObjective,
    this.compact = false,
    this.onSelect,
  });

  final PlanBoard board;
  final Pillar pillar;
  final String? selectedObjective;
  final bool compact;
  final ValueChanged<StrategicObjective>? onSelect;

  @override
  Widget build(BuildContext context) {
    final int index = board.accentIndexOf(pillar.name);
    final Color accent = pillarAccent(index);
    final List<StrategicObjective> objectives = board.objectivesIn(pillar.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PillarHeader(
          pillar: pillar,
          accent: accent,
          glyph: pillarGlyph(index),
          objectiveCount: objectives.length,
          compact: compact,
        ),
        for (final StrategicObjective objective in objectives) ...<Widget>[
          8.verticalSpace,
          PlanObjectiveCard(
            objective: objective,
            accent: accent,
            kpiCount: board.kpiCountFor(objective.name),
            selected: objective.name == selectedObjective,
            compact: compact,
            onTap: onSelect == null ? null : () => onSelect!(objective),
          ),
        ],
        if (objectives.isEmpty) ...<Widget>[
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'No objectives under this pillar yet.',
              style: AppStyle.interNormal(
                size: 12,
                color: AppStyle.textDarkFaint,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// The plan board body: masthead (785) across the claim, then the
/// pillars (786) — one per plane-aligned column at plane widths, stacked
/// sections at one plane (41d). Scrolls, and stops short of the corner
/// pill (347) so the pill owns the corner.
///
/// The column count comes from [Planes.span] — the planes the board was
/// GRANTED, which is every plane while it is the newest step and one
/// fewer once the drill (41b) takes the last plane: the board compresses
/// onto what remains, same columns, tighter dress.
class PlanBoardView extends StatelessWidget {
  const PlanBoardView({
    super.key,
    required this.board,
    this.selectedObjective,
    this.onSelect,
  });

  final PlanBoard board;
  final String? selectedObjective;
  final ValueChanged<StrategicObjective>? onSelect;

  static const String emptyLabel = 'No plan on a page yet.';
  static const String noPillarsLabel = 'No pillars under this vision yet.';

  /// The key on the board's column row: `layoutKey(1)` is the stacked
  /// phone fold, `layoutKey(3)` the three-column board.
  static Key layoutKey(int columns) => Key('plan-board-columns-$columns');

  /// How many columns a board of [pillarCount] pillars lays out on
  /// [span] granted planes: one at one plane (stacked sections, 41d);
  /// otherwise one per pillar — "same three columns, tighter dress" when
  /// the span shrinks (41b) — capped at the span once the pillars
  /// outnumber a readable row, dealt round-robin from there.
  static int columnsFor({required int span, required int pillarCount}) {
    if (span <= 1 || pillarCount <= 1) return 1;
    if (pillarCount <= 3) return pillarCount;
    return span > pillarCount ? pillarCount : span;
  }

  @override
  Widget build(BuildContext context) {
    final Planes? planes = Planes.maybeOf(context);
    final int span = planes?.span ?? 1;
    final double gap = planes?.gap ?? 14;
    final int columns = columnsFor(
      span: span,
      pillarCount: board.pillars.length,
    );
    // Tighter dress whenever the board has fewer planes than pillars:
    // the compressed board of 41b, and the phone fold's compact forms.
    final bool compact = span < board.pillars.length || span <= 1;

    if (board.isEmpty) {
      return Center(
        child: Text(
          emptyLabel,
          style: AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
        ),
      );
    }

    final List<Widget> pillarColumns = <Widget>[
      for (final Pillar pillar in board.pillars)
        PillarColumn(
          board: board,
          pillar: pillar,
          selectedObjective: selectedObjective,
          compact: compact,
          onSelect: onSelect,
        ),
    ];

    Widget grid;
    if (columns <= 1) {
      grid = Column(
        key: layoutKey(1),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < pillarColumns.length; i++) ...<Widget>[
            if (i > 0) 12.verticalSpace,
            pillarColumns[i],
          ],
        ],
      );
    } else {
      final List<List<Widget>> buckets = List<List<Widget>>.generate(
        columns,
        (_) => <Widget>[],
      );
      for (int i = 0; i < pillarColumns.length; i++) {
        if (buckets[i % columns].isNotEmpty) {
          buckets[i % columns].add(12.verticalSpace);
        }
        buckets[i % columns].add(pillarColumns[i]);
      }
      grid = Row(
        key: layoutKey(columns),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int c = 0; c < columns; c++) ...<Widget>[
            if (c > 0) SizedBox(width: gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buckets[c],
              ),
            ),
          ],
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.only(bottom: 88.h),
      children: <Widget>[
        if (board.vision != null) ...<Widget>[
          VisionMasthead(vision: board.vision!, compact: compact),
          12.verticalSpace,
        ],
        if (board.pillars.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(
              child: Text(
                noPillarsLabel,
                style: AppStyle.interNormal(
                  size: 13,
                  color: AppStyle.textDarkFaint,
                ),
              ),
            ),
          )
        else
          grid,
      ],
    );
  }
}

/// The three states every section-41 surface shares before it has rows:
/// a spinner, the backend's own words with Try again beside them, or
/// nothing (the caller draws its content). Same shapes as the objective
/// picker's.
class PlanStateView extends StatelessWidget {
  const PlanStateView({
    super.key,
    required this.loading,
    this.error,
    this.onRetry,
    required this.child,
  });

  final bool loading;
  final String? error;
  final VoidCallback? onRetry;
  final Widget child;

  static const Key retryKey = Key('plan-state-retry');
  static const String retryLabel = 'Try again';

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: SizedBox(
          width: 22.r,
          height: 22.r,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppStyle.primary),
          ),
        ),
      );
    }
    final String? message = error;
    if (message != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyle.interNormal(size: 12, color: AppStyle.red),
            ),
            if (onRetry != null) ...<Widget>[
              8.verticalSpace,
              TextButton(
                key: retryKey,
                onPressed: onRetry,
                child: Text(
                  retryLabel,
                  style: AppStyle.interSemi(size: 12, color: AppStyle.primary),
                ),
              ),
            ],
          ],
        ),
      );
    }
    return child;
  }
}

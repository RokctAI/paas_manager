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

// DESIGN STRIP FRAME 44c — the M2 bridge: linking a task to a strategic
// objective. Chips 834 (the objective picker pane), 833 (the link row in
// the task detail) and canonical 787 (the approved 41a objective card).
//
// The picker is a 1-plane push that WINS THE LAST PLANE: list and detail
// slide left and the picker takes plane 3. It is fed by the productivity
// module's own read endpoints — `get_strategic_objectives` for the cards,
// `get_pillars` for the pillar tag and its accent, `get_kpis` for the
// count on the card — and it is the ONLY surface of section 44 that
// reaches the backend at all.
//
// THE AMBER FLAG THE FRAME CARRIED IS GONE, and honestly so: it said the
// link needs a write endpoint and a remote task store, and both now exist
// (`sync_personal_task` carries `strategic_objective`; tasks push through
// the outbox). Linking is real. What the frame also said still holds and
// is enforced by construction: `commit_plan` is a destructive whole-plan
// replace and nothing in this SDK can reach it.
//
// THE CARD ADDS NOTHING. Title, pillar tag with its accent, KPI count —
// the 41a card, verbatim. The KPI count is DERIVED by counting the KPIs
// that link to the objective; there is no count field to read.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:productivity_sdk/src/common/models/data/objective_data.dart';
import 'package:productivity_sdk/src/common/presentation/tasks/task_view_model.dart';

/// A pillar's accent, by its position in the pillar list.
///
/// A pillar has no colour column, so the accent is derived — and derived
/// from the same base tokens the rest of the tasks surface already draws
/// in (the status tabs' amber and green, the long-term band's blue), so
/// no colour is invented here.
Color pillarAccent(int index) {
  final List<Color> accents = <Color>[
    AppStyle.blue,
    AppStyle.blueBonus,
    AppStyle.green,
    AppStyle.starColor,
    AppStyle.primary,
  ];
  return accents[index % accents.length];
}

/// The tint of the provenance note and of the link row's flag: the plan
/// is the long-term band's colour on this surface, so the two read alike.
Color get objectiveTint => AppStyle.blueBonus;

/// CHIP 834 — the objective picker pane.
///
/// STATELESS ABOUT THE PLAN: the catalog is handed in, already read, and
/// the only state the pane owns is which pillar tab is lit and which radio
/// is on. Cancel hands nothing back; Link hands back the chosen objective
/// and the host writes it onto the task.
class ObjectivePickerPane extends StatefulWidget {
  const ObjectivePickerPane({
    super.key,
    required this.catalog,
    required this.onCancel,
    required this.onLink,
    this.loading = false,
    this.error,
    this.initialSelection,
    this.onRetry,
  });

  /// The plan as read. Null while [loading] or when [error] is set.
  final ObjectiveCatalog? catalog;

  final bool loading;

  /// The backend's own words when the read failed; drawn in place of the
  /// list, with [onRetry] beside it when offered.
  final String? error;

  /// The objective the task is linked to right now, if any: its radio
  /// starts on.
  final String? initialSelection;

  final VoidCallback onCancel;
  final ValueChanged<StrategicObjective> onLink;
  final VoidCallback? onRetry;

  static const Key cancelKey = Key('objective-picker-cancel');
  static const Key linkKey = Key('objective-picker-link');
  static const Key retryKey = Key('objective-picker-retry');

  /// The key on a pillar tab; null is the "All pillars" tab.
  static Key pillarTabKey(String? pillarName) =>
      Key('objective-picker-pillar-${pillarName ?? 'all'}');

  /// The words on the provenance note, kept in one place so the test that
  /// pins them and the pane that draws them cannot drift apart.
  static const String provenance =
      'Read from get_strategic_objectives — the live doctype chain behind '
      'section 41. Title, description and pillar are the only fields that '
      'exist; the pillar tag and its accent come from get_pillars.';

  @override
  State<ObjectivePickerPane> createState() => _ObjectivePickerPaneState();
}

class _ObjectivePickerPaneState extends State<ObjectivePickerPane> {
  /// The lit pillar tab; null is "All pillars".
  String? _pillar;

  /// The objective whose radio is on.
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    final ObjectiveCatalog? catalog = widget.catalog;
    final List<StrategicObjective> shown =
        catalog?.objectivesIn(_pillar) ?? const <StrategicObjective>[];
    final StrategicObjective? chosen = catalog?.objectiveNamed(_selected);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          12.verticalSpace,
          _header(catalog?.objectives.length),
          12.verticalSpace,
          _provenanceNote(),
          12.verticalSpace,
          if (catalog != null && catalog.pillars.isNotEmpty) ...<Widget>[
            _pillarTabs(catalog),
            12.verticalSpace,
          ],
          Expanded(child: _body(catalog, shown)),
          12.verticalSpace,
          _actions(chosen),
          16.verticalSpace,
        ],
      ),
    );
  }

  /// Header + count pill, in the list header's own shape (canonical 700)
  /// with the count worded as the frame draws it.
  Widget _header(int? count) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            'Link an objective',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interSemi(size: 18, color: AppStyle.textPrimary),
          ),
        ),
        8.horizontalSpace,
        if (count != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppStyle.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              count == 1 ? '1 objective' : '$count objectives',
              style: AppStyle.interSemi(size: 12, color: AppStyle.primary),
            ),
          ),
      ],
    );
  }

  /// The provenance note: which endpoints fed this pane, in the plan's
  /// tint, so the reader knows where the cards come from before reading
  /// them.
  Widget _provenanceNote() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: objectiveTint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: objectiveTint.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.outlined_flag, size: 14.r, color: objectiveTint),
          8.horizontalSpace,
          Expanded(
            child: Text(
              ObjectivePickerPane.provenance,
              style: AppStyle.interNormal(
                size: 11,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The pillar filter tabs: All pillars, then one per pillar, each with
  /// its count — the status tabs' shape (canonical 362), lit in the
  /// pillar's own accent.
  Widget _pillarTabs(ObjectiveCatalog catalog) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          _pillarTab(
            name: null,
            label: 'All pillars',
            count: catalog.objectives.length,
            tint: AppStyle.primary,
          ),
          for (final Pillar pillar in catalog.pillars) ...<Widget>[
            8.horizontalSpace,
            _pillarTab(
              name: pillar.name,
              label: pillar.title,
              count: catalog.objectivesIn(pillar.name).length,
              tint: pillarAccent(catalog.accentIndexOf(pillar.name)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _pillarTab({
    required String? name,
    required String label,
    required int count,
    required Color tint,
  }) {
    final bool active = _pillar == name;
    return GestureDetector(
      key: ObjectivePickerPane.pillarTabKey(name),
      onTap: () => setState(() => _pillar = name),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: active ? tint.withValues(alpha: 0.16) : AppStyle.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: active ? tint : AppStyle.strokeDarkSubtle,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label,
              style: AppStyle.interSemi(
                size: 12,
                color: active ? tint : AppStyle.textDarkSecondary,
              ),
            ),
            6.horizontalSpace,
            Text(
              '$count',
              style: AppStyle.interNormal(
                size: 11,
                color: active ? tint : AppStyle.textDarkFaint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(ObjectiveCatalog? catalog, List<StrategicObjective> shown) {
    if (widget.loading || (catalog == null && widget.error == null)) {
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
    final String? error = widget.error;
    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              error,
              textAlign: TextAlign.center,
              style: AppStyle.interNormal(size: 12, color: AppStyle.red),
            ),
            if (widget.onRetry != null) ...<Widget>[
              8.verticalSpace,
              TextButton(
                key: ObjectivePickerPane.retryKey,
                onPressed: widget.onRetry,
                child: Text(
                  'Try again',
                  style: AppStyle.interSemi(size: 12, color: AppStyle.primary),
                ),
              ),
            ],
          ],
        ),
      );
    }
    if (shown.isEmpty) {
      return Center(
        child: Text(
          catalog!.objectives.isEmpty
              ? 'No objectives in the plan yet.'
              : 'No objectives under this pillar.',
          style: AppStyle.interNormal(size: 13, color: AppStyle.textDarkFaint),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: shown.length,
      separatorBuilder: (_, _) => 8.verticalSpace,
      itemBuilder: (BuildContext context, int index) {
        final StrategicObjective objective = shown[index];
        final Pillar? pillar = catalog!.pillarNamed(objective.pillar);
        return ObjectiveCard(
          objective: objective,
          pillarTitle: pillar?.title,
          accent: pillar == null
              ? AppStyle.textDarkSecondary
              : pillarAccent(catalog.accentIndexOf(pillar.name)),
          kpiCount: catalog.kpiCountByObjective.containsKey(objective.name)
              ? catalog.kpiCountFor(objective)
              : null,
          selected: _selected == objective.name,
          onTap: () => setState(() => _selected = objective.name),
        );
      },
    );
  }

  /// Cancel / Link objective at 2 : 3, the pane-action shape of 44a.
  /// Link is live only once a radio is on.
  Widget _actions(StrategicObjective? chosen) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: OutlinedButton(
            key: ObjectivePickerPane.cancelKey,
            onPressed: widget.onCancel,
            style: OutlinedButton.styleFrom(
              minimumSize: Size(0, 44.h),
              side: BorderSide(color: AppStyle.strokeDark),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: AppStyle.interSemi(size: 13, color: AppStyle.textPrimary),
            ),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          flex: 3,
          child: ElevatedButton(
            key: ObjectivePickerPane.linkKey,
            onPressed: chosen == null ? null : () => widget.onLink(chosen),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyle.primary,
              foregroundColor: AppStyle.blackColor,
              disabledBackgroundColor: AppStyle.primary.withValues(alpha: 0.3),
              minimumSize: Size(0, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Link objective',
              style: AppStyle.interSemi(size: 13, color: AppStyle.blackColor),
            ),
          ),
        ),
      ],
    );
  }
}

/// CANONICAL 787 — the approved 41a objective card, reused verbatim:
/// title, pillar tag with its accent, KPI count. Nothing added; the round
/// radio at its end is the picker's, not the card's.
class ObjectiveCard extends StatelessWidget {
  const ObjectiveCard({
    super.key,
    required this.objective,
    required this.accent,
    this.pillarTitle,
    this.kpiCount,
    this.selected = false,
    this.onTap,
  });

  final StrategicObjective objective;

  /// The pillar's accent — the tag's tint.
  final Color accent;

  /// The pillar's title; null draws no tag (an objective with no pillar
  /// has none, and a blank tag would claim one).
  final String? pillarTitle;

  /// KPIs under this objective, counted; null draws no chip (the count was
  /// not readable, which is not the same as zero).
  final int? kpiCount;

  final bool selected;
  final VoidCallback? onTap;

  static Key radioKey(String objectiveName) =>
      Key('objective-card-radio-$objectiveName');

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children: <Widget>[
                        if (pillarTitle != null)
                          _tag(pillarTitle!, tint: accent, outlined: true),
                        if (kpiCount != null)
                          _tag(kpiCount == 1 ? '1 KPI' : '$kpiCount KPIs'),
                      ],
                    ),
                    6.verticalSpace,
                    Text(
                      objective.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interSemi(
                        size: 14,
                        color: AppStyle.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              10.horizontalSpace,
              _radio(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String label, {Color? tint, bool outlined = false}) {
    final Color color = tint ?? AppStyle.textDarkSecondary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: outlined ? color.withValues(alpha: 0.12) : AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(6.r),
        border: outlined ? Border.all(color: color.withValues(alpha: 0.6)) : null,
      ),
      child: Text(label, style: AppStyle.interNormal(size: 11, color: color)),
    );
  }

  /// The round radio: the task card's 19px checkbox shape, so a picked
  /// objective and a done task read alike.
  Widget _radio() {
    return Container(
      key: radioKey(objective.name),
      width: 19.r,
      height: 19.r,
      margin: EdgeInsets.only(top: 2.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppStyle.primary : AppStyle.transparent,
        border: Border.all(
          color: selected ? AppStyle.primary : AppStyle.strokeDark,
          width: 1.5,
        ),
      ),
      child: selected
          ? Icon(Icons.check, size: 13.r, color: AppStyle.blackColor)
          : null,
    );
  }
}

/// CHIP 833 — the M2 link row in the task detail: the row that opens the
/// picker, and that says what the task is linked to once it is.
///
/// The words come off the task map: the objective's title and pillar as
/// they read when the link was made, falling back to the bare name on a
/// device that pulled the link and has not read the plan since.
class ObjectiveLinkRow extends StatelessWidget {
  const ObjectiveLinkRow({
    super.key,
    required this.task,
    required this.onTap,
    this.onClear,
  });

  final TaskViewModel task;

  /// Opens the picker (chip 834).
  final VoidCallback onTap;

  /// Removes the link. Null hides the control; it is drawn only while a
  /// link exists.
  final VoidCallback? onClear;

  static const Key key833 = Key('objective-link-row');
  static const Key clearKey = Key('objective-link-row-clear');

  static const String label = 'Link to a strategic objective';
  static const String unlinked = 'none linked — pick one from the plan';

  /// The sub-line for a linked task: `Pillar › “Title”`, or the name when
  /// that is all the device holds.
  static String linkedLine(TaskViewModel task) {
    final String title = task.strategicObjectiveTitle ?? task.strategicObjective ?? '';
    final String? pillar = task.strategicObjectivePillar;
    return pillar == null ? '“$title”' : '$pillar › “$title”';
  }

  @override
  Widget build(BuildContext context) {
    final bool linked = task.hasStrategicObjective;
    final Color tint = linked ? objectiveTint : AppStyle.textDarkFaint;
    return Material(
      color: AppStyle.transparent,
      child: InkWell(
        key: key833,
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppStyle.cardDarkAlt,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: linked
                  ? objectiveTint.withValues(alpha: 0.45)
                  : AppStyle.strokeDarkSubtle,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.outlined_flag, size: 16.r, color: tint),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      label,
                      style: AppStyle.interSemi(
                        size: 13,
                        color: AppStyle.textPrimary,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      linked ? linkedLine(task) : unlinked,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interNormal(
                        size: 11,
                        color: linked ? objectiveTint : AppStyle.textDarkFaint,
                      ),
                    ),
                  ],
                ),
              ),
              if (linked && onClear != null)
                GestureDetector(
                  key: clearKey,
                  onTap: onClear,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    child: Icon(
                      Icons.close,
                      size: 15.r,
                      color: AppStyle.textDarkFaint,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.chevron_right,
                  size: 18.r,
                  color: AppStyle.textDarkFaint,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

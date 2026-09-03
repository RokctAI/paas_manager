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

// DESIGN STRIP FRAME 46i — chip 859, the run badge PROMOTED TO THE HUB
// ROW: the same element as on the task card, at the top level, where it
// is the first thing that proves the run survived.
//
// IT IS A LINE ON THE EXISTING TASKS ROW, not a new row and not a new
// group. The host composes it under its Tasks row through this SDK's
// manifest integration (`// @productivity-tasks-row`), the same way the
// launcher composes the tasks glance. It reads the local store and
// nothing else, and it DISAPPEARS when no run is paused — a widget that
// is exactly nothing, so the row reads as it always did.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:productivity_sdk/src/common/application/run/paused_run.dart';

/// The line, over [pausedRunProvider].
///
/// [onOpen] is the host's: the run is opened by ROUTE PATH
/// (`/tasks/run?task=<id>`) so the host never imports this SDK's pages,
/// and a host with no way to push a route leaves it null and the line is
/// read-only.
class PausedRunLine extends ConsumerWidget {
  const PausedRunLine({super.key, this.onOpen});

  final void Function(String taskId)? onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PausedRunSummary?> paused = ref.watch(pausedRunProvider);
    // Loading and failure alike draw nothing: the row must never grow a
    // spinner, and a store that could not be read has no run to announce.
    final PausedRunSummary? summary = paused.asData?.value;
    if (summary == null || summary.isEmpty) return const SizedBox.shrink();
    return PausedRunLineView(summary: summary, onOpen: onOpen);
  }
}

/// The drawn line, given the derivation. Split from the reader so it can
/// be composed and tested with no store.
class PausedRunLineView extends StatelessWidget {
  const PausedRunLineView({super.key, required this.summary, this.onOpen, this.now});

  final PausedRunSummary summary;
  final void Function(String taskId)? onOpen;

  /// The clock the "kept from" words are read against; null is now.
  final DateTime? now;

  static const Key key859 = Key('paused-run-line');

  /// "1 run paused · Month-end stock count, step 3 of 6".
  static String headline(PausedRunSummary summary) {
    final PausedRun run = summary.first;
    final String runs = summary.count == 1 ? '1 run paused' : '${summary.count} runs paused';
    final String position = _lowerFirst(run.positionLabel);
    final String where = position.isEmpty ? run.taskTitle : '${run.taskTitle}, $position';
    return '$runs · $where';
  }

  /// "kept from Thursday — resumes where it stopped", and the count of
  /// the others when there are more.
  static String? subline(PausedRunSummary summary, {DateTime? now}) {
    final String? kept = keptFromLabel(summary.first.lastTouched, now: now);
    final int others = summary.count - 1;
    final List<String> parts = <String>[
      if (kept != null) kept,
      if (others > 0) 'and $others more' else 'resumes where it stopped',
    ];
    return parts.isEmpty ? null : parts.join(' — ');
  }

  static String _lowerFirst(String text) =>
      text.isEmpty ? text : '${text[0].toLowerCase()}${text.substring(1)}';

  @override
  Widget build(BuildContext context) {
    final PausedRun run = summary.first;
    final String? sub = subline(summary, now: now);
    final void Function(String)? open = onOpen;
    return Material(
      color: AppStyle.transparent,
      child: InkWell(
        key: key859,
        onTap: open == null ? null : () => open(run.taskId),
        child: Padding(
          // Indented to the row's text column: the Tasks row leads with
          // its icon and a 16-unit gap, and the line sits under the words.
          padding: EdgeInsets.only(left: 40.w, bottom: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(height: 1, color: AppStyle.strokeDarkSubtle),
              8.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Icon(
                      Icons.radio_button_checked,
                      size: 14.r,
                      color: AppStyle.primary,
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          headline(summary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.interSemi(size: 12, color: AppStyle.primary),
                        ),
                        if (sub != null)
                          Text(
                            sub,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.interNormal(
                              size: 11,
                              color: AppStyle.textDarkFaint,
                            ),
                          ),
                      ],
                    ),
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

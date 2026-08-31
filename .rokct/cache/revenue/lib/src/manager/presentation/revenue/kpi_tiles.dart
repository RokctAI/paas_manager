// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/profit_grammar.dart';

/// The vs-previous-period delta pill (chip 657 — Ray's paas_pos grammar,
/// ONE chip for every tile): green arrow-up when the number moved up, red
/// arrow-down when it moved down. Renders NOTHING when [delta] is null (no
/// previous window to compare against — never a fake 0%).
class DeltaPill extends StatelessWidget {
  final double? delta;

  /// Margin moves in points ("+1.1 pt"), everything else in percent.
  final bool points;

  /// For Avg order a downward move is only informational; for cancelled-ish
  /// numbers a caller could invert. Kept simple: up = green, down = red.
  const DeltaPill({super.key, required this.delta, this.points = false});

  @override
  Widget build(BuildContext context) {
    final value = delta;
    if (value == null) return const SizedBox.shrink();
    final bool up = value >= 0;
    final Color color = up ? AppStyle.green : AppStyle.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            up ? Remix.arrow_up_line : Remix.arrow_down_line,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 2),
          Text(
            formatDelta(value, points: points),
            style: AppStyle.interSemi(size: 11, color: color),
          ),
        ],
      ),
    );
  }
}

/// One KPI tile of the approved plane-1 column (chips 656/658/659/660/661):
/// label + delta pill row, the big value, a quiet sub-line.
class RevenueKpiTile extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;
  final double? delta;
  final bool deltaInPoints;
  final Color? valueColor;

  const RevenueKpiTile({
    super.key,
    required this.label,
    required this.value,
    this.sub,
    this.delta,
    this.deltaInPoints = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interNormal(
                    size: 13,
                    color: AppStyle.textDarkSecondary,
                  ),
                ),
              ),
              DeltaPill(delta: delta, points: deltaInPoints),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interBold(
              size: 22,
              color: valueColor ?? AppStyle.textPrimary,
            ),
          ),
          if (sub != null) ...[
            const SizedBox(height: 4),
            Text(
              sub!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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

/// The 36c compressed origin's "quiet mini-list" — the same numbers as the
/// KPI tiles, one label/value row each, no pills: the drill-down moment
/// keeps the context without competing with it.
class KpiMiniList extends StatelessWidget {
  final List<(String, String, Color?)> rows;

  const KpiMiniList({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Column(
        children: [
          for (final (label, value, color) in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interNormal(
                        size: 13,
                        color: AppStyle.textDarkSecondary,
                      ),
                    ),
                  ),
                  Text(
                    value,
                    style: AppStyle.interSemi(
                      size: 14,
                      color: color ?? AppStyle.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

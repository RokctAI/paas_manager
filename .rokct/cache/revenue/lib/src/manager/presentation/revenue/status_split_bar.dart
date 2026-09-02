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

import 'package:flutter/material.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/profit_grammar.dart';

/// Orders-by-status split bar + legend (chip 664): Ray's paas_pos pie and
/// per-status progress bars merged into ONE dark element — a single
/// proportional bar with a dot legend. [compact] (36b/36c) folds the
/// legend to the top rows plus "+N more".
class StatusSplitBar extends StatelessWidget {
  final Map<String, int> counts;
  final int total;
  final bool compact;

  const StatusSplitBar({
    super.key,
    required this.counts,
    required this.total,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final segments = statusSegments()
        .map((s) => (s, counts[s.wireKey] ?? 0))
        .where((entry) => entry.$2 > 0)
        .toList();
    final barTotal = statusTotal(counts);
    final visible = compact && segments.length > 3
        ? segments.sublist(0, 3)
        : segments;
    final hidden = segments.length - visible.length;

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
                  AppHelpers.getTranslation('orders_by_status').toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interSemi(
                    size: 11,
                    color: AppStyle.textDarkSecondary,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Text(
                '$total ${AppHelpers.getTranslation('total')}',
                style: AppStyle.interNormal(
                  size: 12,
                  color: AppStyle.textDarkSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: 8,
              child: barTotal == 0
                  ? ColoredBox(color: AppStyle.strokeDarkSubtle)
                  : Row(
                      children: [
                        for (final (segment, count) in segments)
                          Expanded(
                            flex: count,
                            child: ColoredBox(color: segment.color),
                          ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              for (final (segment, count) in visible)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: segment.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${AppHelpers.getTranslation(segment.trKey)} $count',
                      style: AppStyle.interNormal(
                        size: 12,
                        color: AppStyle.textDarkSecondary,
                      ),
                    ),
                  ],
                ),
              if (hidden > 0)
                Text(
                  '+$hidden ${AppHelpers.getTranslation('more')}',
                  style: AppStyle.interNormal(
                    size: 12,
                    color: AppStyle.textDarkFaint,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

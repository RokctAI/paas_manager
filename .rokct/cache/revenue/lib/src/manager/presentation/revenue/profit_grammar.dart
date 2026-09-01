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

/// Shared vocabulary of the approved revenue dashboard's marks: the split
/// bar's status order + colors, and small pure formatters. No widgets in
/// the arithmetic — unit-tested.
library;

import 'dart:ui';

import 'package:base_sdk/src/presentation/theme/app_style.dart';

/// One split-bar segment (chip 664): wire key, translation key, color.
/// Order IS the approved legend order — delivered / on the way / cooking /
/// new / cancelled, with accepted folded beside cooking's neighbourhood.
class StatusSegment {
  final String wireKey;
  final String trKey;
  final Color color;
  const StatusSegment(this.wireKey, this.trKey, this.color);
}

/// The approved legend, in render order.
List<StatusSegment> statusSegments() => [
      StatusSegment('delivered', 'delivered', AppStyle.green),
      StatusSegment('on_a_way', 'on_a_way', const Color(0xFF3B82F6)),
      StatusSegment('cooking', 'cooking', AppStyle.rate),
      StatusSegment('accepted', 'accepted', const Color(0xFF9A6BFF)),
      StatusSegment('new', 'new', const Color(0xFF8C8C8C)),
      StatusSegment('cancelled', 'cancelled', AppStyle.red),
    ];

/// Sum of the split bar's buckets (segments with zero count render nothing).
int statusTotal(Map<String, int> counts) {
  var total = 0;
  for (final segment in statusSegments()) {
    total += counts[segment.wireKey] ?? 0;
  }
  return total;
}

/// "+8.2%" / "-2.1%" — the delta pill's text; [points] renders "+1.1 pt"
/// (margin moves in points, the approved grammar).
String formatDelta(double delta, {bool points = false}) {
  final sign = delta >= 0 ? '+' : '−';
  final value = delta.abs().toStringAsFixed(1);
  return points ? '$sign$value pt' : '$sign$value%';
}

/// "41.4%" — one decimal, the approved margin tile format.
String formatPercent(double pct) => '${pct.toStringAsFixed(1)}%';

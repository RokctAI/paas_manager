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

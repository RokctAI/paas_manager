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

/// Period selection for the revenue dashboard (chip 654 Today/Week/Month +
/// chip 655 custom range — Ray's paas_pos day/week/month grammar plus his
/// custom date picker, preserved). Pure date arithmetic, unit-tested.
library;

enum RevenuePeriod { today, week, month, custom }

/// An inclusive [from]..[to] day window plus the previous window of the same
/// length ending the day before [from] — the vs-previous-period delta pills
/// (chip 657) call the endpoint once per window.
class RevenueWindow {
  final DateTime from;
  final DateTime to;
  final DateTime previousFrom;
  final DateTime previousTo;

  const RevenueWindow({
    required this.from,
    required this.to,
    required this.previousFrom,
    required this.previousTo,
  });

  static DateTime _day(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  /// Today = the single current day (the backend answers per-hour when
  /// from == to). Week = Monday..Sunday of the current week. Month = the
  /// current calendar month. Custom = the picked inclusive range. Previous
  /// windows shift by the same span (yesterday / last week / last month /
  /// the same number of days before a custom range).
  factory RevenueWindow.of(
    RevenuePeriod period,
    DateTime now, {
    DateTime? customFrom,
    DateTime? customTo,
  }) {
    final today = _day(now);
    switch (period) {
      case RevenuePeriod.today:
        return RevenueWindow(
          from: today,
          to: today,
          previousFrom: today.subtract(const Duration(days: 1)),
          previousTo: today.subtract(const Duration(days: 1)),
        );
      case RevenuePeriod.week:
        final monday = today.subtract(Duration(days: today.weekday - 1));
        return RevenueWindow(
          from: monday,
          to: monday.add(const Duration(days: 6)),
          previousFrom: monday.subtract(const Duration(days: 7)),
          previousTo: monday.subtract(const Duration(days: 1)),
        );
      case RevenuePeriod.month:
        final first = DateTime(today.year, today.month, 1);
        final last = DateTime(today.year, today.month + 1, 0);
        return RevenueWindow(
          from: first,
          to: last,
          previousFrom: DateTime(today.year, today.month - 1, 1),
          previousTo: first.subtract(const Duration(days: 1)),
        );
      case RevenuePeriod.custom:
        final from = _day(customFrom ?? today);
        final to = _day(customTo ?? from);
        final span = to.difference(from).inDays + 1;
        return RevenueWindow(
          from: from,
          to: to,
          previousFrom: from.subtract(Duration(days: span)),
          previousTo: from.subtract(const Duration(days: 1)),
        );
    }
  }
}

/// Delta arithmetic for the pills (chip 657): percent change against the
/// previous window, null when it cannot honestly be computed (no previous
/// value) — the pill then simply does not render.
double? percentDelta(num current, num previous) {
  if (previous == 0) return null;
  return (current - previous) / previous * 100.0;
}

/// Margin moves in POINTS, not percent-of-percent — "+1.1 pt" in the
/// approved frame.
double? pointDelta(num currentPct, num previousPct, {required bool hasBoth}) =>
    hasBoth ? (currentPct - previousPct).toDouble() : null;

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

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';

/// The revenue-vs-profit trend chart (chip 663): the shipped earnings line
/// plus the NEW profit series — orange revenue with a soft fill, green
/// profit, dot markers, day (or hour) axis, legend. Drawn with a
/// CustomPainter so revenue_sdk's package code needs no chart dependency
/// (`fl_chart` was a host-only import of the old template) and the marks
/// match the approved dark frames exactly.
class RevenueTrendChart extends StatelessWidget {
  final List<ProfitPoint> series;
  final double height;

  const RevenueTrendChart({super.key, required this.series, this.height = 220});

  /// "2026-08-24" -> "Mon"; "09:00" stays "09:00".
  static String axisLabel(String date) {
    final parsed = DateTime.tryParse(date);
    if (parsed == null) return date;
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return AppHelpers.getTranslation(
      days[parsed.weekday - 1].toLowerCase(),
    );
  }

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
                  AppHelpers.getTranslation('revenue_vs_profit').toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interSemi(
                    size: 11,
                    color: AppStyle.textDarkSecondary,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              _legendDot(AppStyle.primary, AppHelpers.getTranslation('revenue')),
              const SizedBox(width: 10),
              _legendDot(AppStyle.green, AppHelpers.getTranslation('profit')),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: height,
            width: double.infinity,
            child: series.isEmpty
                ? Center(
                    child: Text(
                      AppHelpers.getTranslation('no_data'),
                      style: AppStyle.interNormal(
                        size: 12,
                        color: AppStyle.textDarkFaint,
                      ),
                    ),
                  )
                : CustomPaint(
                    painter: _TrendPainter(
                      series: series,
                      revenueColor: AppStyle.primary,
                      profitColor: AppStyle.green,
                      gridColor: AppStyle.strokeDarkSubtle,
                    ),
                  ),
          ),
          const SizedBox(height: 6),
          if (series.isNotEmpty)
            Row(
              children: [
                for (final point in _axisPoints())
                  Expanded(
                    child: Text(
                      axisLabel(point.date),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interNormal(
                        size: 10,
                        color: AppStyle.textDarkFaint,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  /// At most 8 axis labels — hourly series would otherwise crowd.
  List<ProfitPoint> _axisPoints() {
    if (series.length <= 8) return series;
    final step = (series.length / 8).ceil();
    return [for (var i = 0; i < series.length; i += step) series[i]];
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppStyle.interNormal(
            size: 11,
            color: AppStyle.textDarkSecondary,
          ),
        ),
      ],
    );
  }
}

class _TrendPainter extends CustomPainter {
  final List<ProfitPoint> series;
  final Color revenueColor;
  final Color profitColor;
  final Color gridColor;

  _TrendPainter({
    required this.series,
    required this.revenueColor,
    required this.profitColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) return;
    var maxValue = 0.0;
    for (final point in series) {
      maxValue = math.max(maxValue, math.max(point.revenue, point.profit));
    }
    if (maxValue <= 0) maxValue = 1;

    // Quiet horizontal grid at 1/3 and 2/3.
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (final fraction in [1 / 3, 2 / 3]) {
      final y = size.height * fraction;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    Offset at(int index, double value) {
      final x = series.length == 1
          ? size.width / 2
          : index * size.width / (series.length - 1);
      // 8% headroom so the top dot never clips.
      final y = size.height - (value / maxValue) * size.height * 0.92;
      return Offset(x, y);
    }

    Path lineOf(double Function(ProfitPoint) pick) {
      final path = Path();
      for (var i = 0; i < series.length; i++) {
        final offset = at(i, pick(series[i]));
        if (i == 0) {
          path.moveTo(offset.dx, offset.dy);
        } else {
          path.lineTo(offset.dx, offset.dy);
        }
      }
      return path;
    }

    // Soft fill under the revenue line (the approved frame's glow).
    final revenuePath = lineOf((p) => p.revenue);
    final fillPath = Path.from(revenuePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [revenueColor.withValues(alpha: 0.22),
            revenueColor.withValues(alpha: 0),],
        ).createShader(Offset.zero & size),
    );

    void stroke(Path path, Color color) {
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    stroke(revenuePath, revenueColor);
    stroke(lineOf((p) => p.profit), profitColor);

    // Dot markers, hollow like the frames (skipped when hourly-dense).
    if (series.length <= 12) {
      void dots(double Function(ProfitPoint) pick, Color color) {
        for (var i = 0; i < series.length; i++) {
          final offset = at(i, pick(series[i]));
          canvas.drawCircle(
            offset,
            3.4,
            Paint()..color = AppStyle.cardDark,
          );
          canvas.drawCircle(
            offset,
            3.4,
            Paint()
              ..color = color
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2,
          );
        }
      }

      dots((p) => p.revenue, revenueColor);
      dots((p) => p.profit, profitColor);
    }
  }

  @override
  bool shouldRepaint(_TrendPainter oldDelegate) =>
      oldDelegate.series != series;
}

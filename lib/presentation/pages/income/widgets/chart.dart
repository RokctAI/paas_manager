// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/extension.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class SalesChart extends StatelessWidget {
  final List<num> price;
  final List<DateTime> times;
  final List<Chart> chart;
  final bool isDay;
  final bool isLoading;

  const SalesChart({
    super.key,
    required this.price,
    required this.chart,
    required this.times,
    required this.isDay,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 268.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: times.length > 7
                ? times.length * 40
                :  MediaQuery.sizeOf(context).width - 80,
            child: Padding(
              padding: REdgeInsets.only(top: 24),
              child: isLoading
                  ? const Loading()
                  : chart.isNotEmpty
                      ? LineChart(mainData())
                      : Center(
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.needOrder),
                            style: Style.interSemi(size: 22),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = Style.interRegular(size: 10);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Padding(
        padding: REdgeInsets.only(top: 4),
        child: Text(
            DateFormat(isDay ? "HH:00" : "MMM d").format(times[value.ceil()]),
            style: style),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = Style.interRegular(size: 12);
    return AutoSizeText(
      AppHelpers.numberFormat(
          value.toInt() == 0 ? 0 : price[value.toInt() - 1]),
      style: style,
      textAlign: TextAlign.left,
      maxLines: 1,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Style.iconButtonBack,
            strokeWidth: 1,
            dashArray: [10],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24.r,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 60.r,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: times.length.toDouble() - 1,
      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: [
            ...times.mapIndexed((e, i) => FlSpot(
                  i.toDouble(),
                  price.findPriceIndex(
                    isDay ? chart.findPriceWithHour(e) : chart.findPrice(e),
                  ),
                )),
          ],
          isCurved: true,
          color: Style.primary,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Style.primaryGradient,
            ),
          ),
        ),
      ],
    );
  }
}

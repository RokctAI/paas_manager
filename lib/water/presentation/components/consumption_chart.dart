import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/meter_reading.dart';

class ConsumptionChart extends StatelessWidget {
  final List<MeterReading> readings;

  const ConsumptionChart({Key? key, required this.readings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (readings.length < 2) {
      return Center(child: Text('Not enough data to display chart'));
    }

    // Sort readings by date
    readings.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Calculate consumption data
    List<FlSpot> spots = [];
    for (int i = 1; i < readings.length; i++) {
      final consumption = readings[i].reading - readings[i - 1].reading;
      spots.add(FlSpot(i.toDouble(), consumption.toDouble()));
    }

    return Container(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
          minX: 1,
          maxX: spots.length.toDouble(),
          minY: 0,
          maxY: spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
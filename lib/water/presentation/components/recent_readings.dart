import 'package:flutter/material.dart';
import '../../models/meter_reading.dart';
import 'package:intl/intl.dart';

class RecentReadings extends StatelessWidget {
  final List<MeterReading> readings;

  const RecentReadings({Key? key, required this.readings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentReadings = readings.reversed.take(5).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recentReadings.length,
      itemBuilder: (context, index) {
        final reading = recentReadings[index];
        return ListTile(
          title: Text('${reading.reading} litres'),
          subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(reading.timestamp)),
          trailing: Text(reading.meterId),
        );
      },
    );
  }
}
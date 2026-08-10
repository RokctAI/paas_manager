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
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

// lib/water/models/meter_reading.dart

class MeterReading {
  final String meterId;
  final int reading;
  final DateTime timestamp;
  final String userId;
  final int shopId;
  final String? imagePath;

  MeterReading({
    required this.meterId,
    required this.reading,
    required this.timestamp,
    required this.userId,
    required this.shopId,
    this.imagePath,
  });

  factory MeterReading.fromJson(Map<String, dynamic> json) {
    return MeterReading(
      meterId: json['meterId'],
      reading: json['reading'],
      timestamp: DateTime.parse(json['timestamp']),
      userId: json['userId'],
      shopId: json['shopId'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meterId': meterId,
      'reading': reading,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'shopId': shopId,
      'imagePath': imagePath,
    };
  }
}
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
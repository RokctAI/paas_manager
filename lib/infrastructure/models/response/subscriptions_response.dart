import 'package:venderfoodyman/infrastructure/models/data/subscriptions_data.dart';

class SubscriptionResponse {
  DateTime? timestamp;
  bool? status;
  String? message;
  List<SubscriptionData>? data;

  SubscriptionResponse({this.timestamp, this.status, this.message, this.data});

  SubscriptionResponse copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    List<SubscriptionData>? data,
  }) => SubscriptionResponse(
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionResponse(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SubscriptionData>.from(
                json["data"]!.map((x) => SubscriptionData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

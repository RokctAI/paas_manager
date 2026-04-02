import 'package:venderfoodyman/infrastructure/models/data/non_exist_payment.dart';

class NonExistPaymentResponse {
  DateTime? timestamp;
  bool? status;
  String? message;
  List<NonExistPayment>? data;

  NonExistPaymentResponse({
    this.timestamp,
    this.status,
    this.message,
    this.data,
  });

  NonExistPaymentResponse copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    List<NonExistPayment>? data,
  }) => NonExistPaymentResponse(
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory NonExistPaymentResponse.fromJson(Map<String, dynamic> json) =>
      NonExistPaymentResponse(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NonExistPayment>.from(
                json["data"]!.map((x) => NonExistPayment.fromJson(x)),
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

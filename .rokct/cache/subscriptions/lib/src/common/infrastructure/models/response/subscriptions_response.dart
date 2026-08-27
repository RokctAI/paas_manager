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


import '../data/subscriptions_data.dart';

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

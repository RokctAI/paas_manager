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

import 'dart:convert';

CheckPhoneResponse checkPhoneResponseFromJson(String str) =>
    CheckPhoneResponse.fromJson(json.decode(str));

String checkPhoneResponseToJson(CheckPhoneResponse data) =>
    json.encode(data.toJson());

class CheckPhoneResponse {
  DateTime? timestamp;
  bool? status;
  String? message;
  CheckPhoneData? data;

  CheckPhoneResponse({
    this.timestamp,
    this.status,
    this.message,
    this.data,
  });

  CheckPhoneResponse copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    CheckPhoneData? data,
  }) =>
      CheckPhoneResponse(
        timestamp: timestamp ?? this.timestamp,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CheckPhoneResponse.fromJson(Map<String, dynamic> json) =>
      CheckPhoneResponse(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : CheckPhoneData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class CheckPhoneData {
  bool? exist;

  CheckPhoneData({
    this.exist,
  });

  CheckPhoneData copyWith({
    bool? exist,
  }) =>
      CheckPhoneData(exist: exist ?? this.exist);

  factory CheckPhoneData.fromJson(Map<String, dynamic> json) => CheckPhoneData(
        exist: json["exist"],
      );

  Map<String, dynamic> toJson() => {
        "exist": exist,
      };
}

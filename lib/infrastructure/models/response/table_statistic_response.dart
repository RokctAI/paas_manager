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

import '../data/table_statistics_data.dart';

TableStatisticResponse tableStatisticResponseFromJson(String str) =>
    TableStatisticResponse.fromJson(json.decode(str));

String tableStatisticResponseToJson(TableStatisticResponse data) =>
    json.encode(data.toJson());

class TableStatisticResponse {
  DateTime timestamp;
  bool status;
  String message;
  TableStatisticData data;

  TableStatisticResponse({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.data,
  });

  factory TableStatisticResponse.fromJson(Map<String, dynamic> json) =>
      TableStatisticResponse(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        data: TableStatisticData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

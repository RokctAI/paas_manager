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

// To parse this JSON data, do
//
//     final tableBookingResponse = tableBookingResponseFromJson(jsonString);

import 'dart:convert';

import '../data/table_bookings_data.dart';

TableBookingResponse tableBookingResponseFromJson(String str) =>
    TableBookingResponse.fromJson(json.decode(str));

String tableBookingResponseToJson(TableBookingResponse data) =>
    json.encode(data.toJson());

class TableBookingResponse {
  List<TableBookingData> data;

  TableBookingResponse({required this.data});

  factory TableBookingResponse.fromJson(Map<String, dynamic> json) =>
      TableBookingResponse(
        data: List<TableBookingData>.from(json["data"].map((x) => TableBookingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}





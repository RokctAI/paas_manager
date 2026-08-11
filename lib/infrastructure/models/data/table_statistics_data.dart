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

class TableStatisticData {
  int available;
  int booked;
  int occupied;
  List availableIds;
  List bookedIds;
  List occupiedIds;
  List<AllStatisticStatusData> allBooked;
  List<AllStatisticStatusData> allOccupied;

  TableStatisticData({
    required this.available,
    required this.booked,
    required this.occupied,
    required this.availableIds,
    required this.bookedIds,
    required this.occupiedIds,
    required this.allBooked,
    required this.allOccupied,
  });

  factory TableStatisticData.fromJson(Map<String, dynamic> json) => TableStatisticData(
    available: json["available"],
    booked: json["booked"],
    occupied: json["occupied"],
    availableIds: List.from(json["available_ids"].map((x) => x)),
    bookedIds: List.from(json["booked_ids"].map((x) => x)),
    occupiedIds: List.from(json["occupied_ids"].map((x) => x)),
    allBooked: List.from(json["all_booked"].map((x) => AllStatisticStatusData.fromJson(x))),
    allOccupied: List.from(json["all_occupied"].map((x) =>  AllStatisticStatusData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "booked": booked,
    "occupied": occupied,
    "available_ids": List.from(availableIds.map((x) => x)),
    "booked_ids": List.from(bookedIds.map((x) => x)),
    "occupied_ids": List.from(occupiedIds.map((x) => x)),
    "all_booked": List.from(allBooked.map((x) => x)),
    "all_occupied": List.from(allOccupied.map((x) => x)),
  };
}


class AllStatisticStatusData {
  int? tableId;
  String? tableName;
  DateTime? tableStartDate;
  String? username;

  AllStatisticStatusData({
    required this.tableId,
    required this.tableName,
    required this.tableStartDate,
    required this.username,
  });

  AllStatisticStatusData copyWith({
    int? tableId,
    String? tableName,
    DateTime? tableStartDate,
    String? username,
  }) =>
      AllStatisticStatusData(
        tableId: tableId ?? this.tableId,
        tableName: tableName ?? this.tableName,
        tableStartDate: tableStartDate ?? this.tableStartDate,
        username: username ?? this.username,
      );

  factory AllStatisticStatusData.fromJson(Map<String, dynamic> json) => AllStatisticStatusData(
    tableId: json["table_id"],
    tableName: json["table_name"],
    tableStartDate: DateTime.parse(json["table_start_date"]),
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "table_id": tableId,
    "table_name": tableName,
    "table_start_date": tableStartDate?.toIso8601String(),
    "username": username,
  };
}

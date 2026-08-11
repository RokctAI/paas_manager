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

class WorkingDayData {
  List<Date> dates;
  Shop shop;

  WorkingDayData({
    required this.dates,
    required this.shop,
  });

  factory WorkingDayData.fromJson(Map<String, dynamic> json) => WorkingDayData(
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
        shop: Shop.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
        "shop": shop.toJson(),
      };
}

class Date {
  int id;
  String day;
  String from;
  String to;
  bool disabled;

  Date({
    required this.id,
    required this.day,
    required this.from,
    required this.to,
    required this.disabled,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        id: json["id"],
        day: json["day"],
        from: json["from"],
        to: json["to"],
        disabled: json["disabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "from": from,
        "to": to,
        "disabled": disabled,
      };
}

class Shop {
  int id;
  DateTime createdAt;
  DateTime updatedAt;

  Shop({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

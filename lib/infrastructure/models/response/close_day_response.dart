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

class CloseDayResponse {
  CloseDayData? data;

  CloseDayResponse({
    this.data,
  });

  CloseDayResponse copyWith({
    CloseDayData? data,
  }) =>
      CloseDayResponse(
        data: data ?? this.data,
      );

  factory CloseDayResponse.fromJson(Map<String, dynamic> json) =>
      CloseDayResponse(
        data: json["data"] == null ? null : CloseDayData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CloseDayData {
  List<BookingShopClosedDate>? bookingShopClosedDate;

  CloseDayData({
    this.bookingShopClosedDate,
  });

  CloseDayData copyWith({
    List<BookingShopClosedDate>? bookingShopClosedDate,
  }) =>
      CloseDayData(
        bookingShopClosedDate:
            bookingShopClosedDate ?? this.bookingShopClosedDate,
      );

  factory CloseDayData.fromJson(Map<String, dynamic> json) => CloseDayData(
        bookingShopClosedDate: json["booking_shop_closed_date"] == null
            ? []
            : List<BookingShopClosedDate>.from(json["booking_shop_closed_date"]!
                .map((x) => BookingShopClosedDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking_shop_closed_date": bookingShopClosedDate == null
            ? []
            : List<dynamic>.from(bookingShopClosedDate!.map((x) => x.toJson())),
      };
}

class BookingShopClosedDate {
  int? id;
  DateTime? day;

  BookingShopClosedDate({
    this.id,
    this.day,
  });

  BookingShopClosedDate copyWith({
    int? id,
    DateTime? day,
  }) =>
      BookingShopClosedDate(
        id: id ?? this.id,
        day: day ?? this.day,
      );

  factory BookingShopClosedDate.fromJson(Map<String, dynamic> json) =>
      BookingShopClosedDate(
        id: json["id"],
        day: json["day"] == null
            ? null
            : DateTime.tryParse(json["day"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
      };
}

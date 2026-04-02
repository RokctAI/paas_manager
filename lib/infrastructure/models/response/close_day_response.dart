class CloseDayResponse {
  CloseDayData? data;

  CloseDayResponse({this.data});

  CloseDayResponse copyWith({CloseDayData? data}) =>
      CloseDayResponse(data: data ?? this.data);

  factory CloseDayResponse.fromJson(Map<String, dynamic> json) =>
      CloseDayResponse(
        data: json["data"] == null ? null : CloseDayData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class CloseDayData {
  List<BookingShopClosedDate>? bookingShopClosedDate;

  CloseDayData({this.bookingShopClosedDate});

  CloseDayData copyWith({List<BookingShopClosedDate>? bookingShopClosedDate}) =>
      CloseDayData(
        bookingShopClosedDate:
            bookingShopClosedDate ?? this.bookingShopClosedDate,
      );

  factory CloseDayData.fromJson(Map<String, dynamic> json) => CloseDayData(
    bookingShopClosedDate: json["booking_shop_closed_date"] == null
        ? []
        : List<BookingShopClosedDate>.from(
            json["booking_shop_closed_date"]!.map(
              (x) => BookingShopClosedDate.fromJson(x),
            ),
          ),
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

  BookingShopClosedDate({this.id, this.day});

  BookingShopClosedDate copyWith({int? id, DateTime? day}) =>
      BookingShopClosedDate(id: id ?? this.id, day: day ?? this.day);

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

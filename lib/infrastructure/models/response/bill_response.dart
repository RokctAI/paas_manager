import 'item_model.dart';

class BillResponse {
  final List<Bill>? data;

  BillResponse({this.data});

  factory BillResponse.fromJson(Map<String, dynamic> json) => BillResponse(
        data: json["data"] == null
            ? []
            : List<Bill>.from(json["data"]!.map((x) => Bill.fromJson(x))),
      );
}

class Bill {
  final int? id;
  final int? billId;
  final int? venderId;
  final String? billDate;
  final String? dueDate;
  final int? categoryId;
  final String? orderNumber;
  final int? status;
  final List<Item>? items;

  Bill({
    this.id,
    this.billId,
    this.venderId,
    this.billDate,
    this.dueDate,
    this.categoryId,
    this.orderNumber,
    this.status,
    this.items,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        billId: json["bill_id"],
        venderId: json["vender_id"],
        billDate: json["bill_date"],
        dueDate: json["due_date"],
        categoryId: json["category_id"],
        orderNumber: json["order_number"],
        status: json["status"],
        items: json["items"] == null
            ? []
            : List<Item>.from(
                json["items"]!.map((x) => Item.fromJson(x))),
      );
}

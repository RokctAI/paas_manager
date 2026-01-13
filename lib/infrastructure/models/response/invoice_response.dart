import 'item_model.dart';

class InvoiceResponse {
  final List<Invoice>? data;

  InvoiceResponse({this.data});

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceResponse(
        data: json["data"] == null
            ? []
            : List<Invoice>.from(
                json["data"]!.map((x) => Invoice.fromJson(x))),
      );
}

class Invoice {
  final int? id;
  final int? invoiceId;
  final int? customerId;
  final String? issueDate;
  final String? dueDate;
  final int? categoryId;
  final String? refNumber;
  final int? status;
  final List<Item>? items;

  Invoice({
    this.id,
    this.invoiceId,
    this.customerId,
    this.issueDate,
    this.dueDate,
    this.categoryId,
    this.refNumber,
    this.status,
    this.items,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        invoiceId: json["invoice_id"],
        customerId: json["customer_id"],
        issueDate: json["issue_date"],
        dueDate: json["due_date"],
        categoryId: json["category_id"],
        refNumber: json["ref_number"],
        status: json["status"],
        items: json["items"] == null
            ? []
            : List<Item>.from(
                json["items"]!.map((x) => Item.fromJson(x))),
      );
}

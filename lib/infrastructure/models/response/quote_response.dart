import 'item_model.dart';

class QuoteResponse {
  final List<Quote>? data;

  QuoteResponse({
    this.data,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
        data: json["data"] == null
            ? []
            : List<Quote>.from(json["data"]!.map((x) => Quote.fromJson(x))),
      );
}

class Quote {
  final int? id;
  final int? quoteId;
  final int? customerId;
  final String? issueDate;
  final String? dueDate;
  final int? categoryId;
  final String? refNumber;
  final int? status;
  final List<Item>? items;

  Quote({
    this.id,
    this.quoteId,
    this.customerId,
    this.issueDate,
    this.dueDate,
    this.categoryId,
    this.refNumber,
    this.status,
    this.items,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        quoteId: json["quote_id"],
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

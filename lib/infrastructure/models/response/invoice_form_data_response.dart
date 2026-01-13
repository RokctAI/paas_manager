import '../models.dart';

class InvoiceFormDataResponse {
  final List<Customer>? customers;
  final List<Category>? categories;

  InvoiceFormDataResponse({
    this.customers,
    this.categories,
  });

  factory InvoiceFormDataResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceFormDataResponse(
        customers: json["customers"] == null
            ? []
            : List<Customer>.from(
                json["customers"]!.map((x) => Customer.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customers": customers == null
            ? []
            : List<dynamic>.from(customers!.map((x) => x.toJson())),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Customer {
  final int? id;
  final String? name;

  Customer({
    this.id,
    this.name,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

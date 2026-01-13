class Product {
  final int? id;
  final String? name;
  final double? salePrice;

  Product({
    this.id,
    this.name,
    this.salePrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        salePrice: (json["sale_price"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sale_price": salePrice,
      };
}

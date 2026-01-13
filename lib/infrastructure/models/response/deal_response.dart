class DealResponse {
  final List<Deal>? data;

  DealResponse({this.data});

  factory DealResponse.fromJson(Map<String, dynamic> json) {
    return DealResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Deal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Deal {
  final int? id;
  final String? name;
  final double? price;
  final int? stageId;
  final List<User>? users;
  final List<Product>? products;
  final List<Source>? sources;

  Deal({
    this.id,
    this.name,
    this.price,
    this.stageId,
    this.users,
    this.products,
    this.sources,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stageId: json['stage_id'] as int?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class User {
  final int? id;
  final String? name;
  final String? avatar;

  User({this.id, this.name, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
    );
  }
}

class Product {
  final int? id;
  final String? name;
  final String? sku;
  final double? salePrice;
  final double? purchasePrice;
  final String? type;
  final String? unit;
  final int? quantity;

  Product({
    this.id,
    this.name,
    this.sku,
    this.salePrice,
    this.purchasePrice,
    this.type,
    this.unit,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      purchasePrice: (json['purchase_price'] as num?)?.toDouble(),
      type: json['type'] as String?,
      unit: json['unit'] as String?,
      quantity: json['quantity'] as int?,
    );
  }
}

class Source {
  final int? id;
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

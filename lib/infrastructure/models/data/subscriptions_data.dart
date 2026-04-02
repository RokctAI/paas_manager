import 'package:venderfoodyman/infrastructure/services/extension.dart';

class SubscriptionData {
  int? id;
  String? type;
  num? price;
  int? month;
  bool? active;
  String? title;
  int? productLimit;
  int? orderLimit;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? withReport;
  int? shopId;
  int? subscriptionId;
  DateTime? expiredAt;
  SubscriptionData? subscription;

  SubscriptionData({
    this.id,
    this.type,
    this.price,
    this.month,
    this.active,
    this.title,
    this.productLimit,
    this.orderLimit,
    this.createdAt,
    this.updatedAt,
    this.withReport,
    this.shopId,
    this.subscriptionId,
    this.expiredAt,
    this.subscription,
  });

  SubscriptionData copyWith({
    int? id,
    String? type,
    num? price,
    int? month,
    bool? active,
    String? title,
    int? productLimit,
    int? orderLimit,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? withReport,
    int? shopId,
    int? subscriptionId,
    DateTime? expiredAt,
    SubscriptionData? subscription,
  }) => SubscriptionData(
    id: id ?? this.id,
    type: type ?? this.type,
    price: price ?? this.price,
    month: month ?? this.month,
    active: active ?? this.active,
    title: title ?? this.title,
    productLimit: productLimit ?? this.productLimit,
    orderLimit: orderLimit ?? this.orderLimit,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    withReport: withReport ?? this.withReport,
    shopId: shopId ?? this.shopId,
    expiredAt: expiredAt ?? this.expiredAt,
    subscription: subscription ?? this.subscription,
    subscriptionId: subscriptionId ?? this.subscriptionId,
  );

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      SubscriptionData(
        id: json["id"],
        type: json["type"],
        price: json["price"],
        month: json["month"],
        active: json["active"].toString().toBool(),
        title: json["title"],
        productLimit: json["product_limit"],
        orderLimit: json["order_limit"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"])?.toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"])?.toLocal(),
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.tryParse(json["expired_at"]),
        withReport: json["with_report"].toString().toBool(),
        shopId: json["shop_id"],
        subscription: json["subscription"] == null
            ? null
            : SubscriptionData.fromJson(json["subscription"]),
        subscriptionId: json["subscription_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "price": price,
    "month": month,
    "active": active,
    "title": title,
    "product_limit": productLimit,
    "order_limit": orderLimit,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "with_report": withReport,
    "subscription_id": subscriptionId,
    "expired_at": expiredAt?.toIso8601String(),
    "shop_id": shopId,
    "subscription": subscription?.toJson(),
  };
}

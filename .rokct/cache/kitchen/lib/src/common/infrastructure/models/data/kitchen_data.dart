import 'package:base_sdk/src/models/data/translation.dart';

/// A kitchen (prep station) belonging to a shop.
///
/// Ported from `paas_manager`'s `KitchenModel`. The app carried its own
/// `Translation`; base_sdk's is a superset of it (83% identical, plus
/// `buttonText`/`address`), so this uses base_sdk's per the
/// prefer-the-SDK's-version convention.
class KitchenModel {
  KitchenModel({this.id, this.active, this.shopId, this.translation});

  int? id;
  int? active;
  int? shopId;
  Translation? translation;

  String get title => translation?.title ?? '';

  KitchenModel copyWith({
    int? id,
    int? active,
    int? shopId,
    Translation? translation,
  }) =>
      KitchenModel(
        id: id ?? this.id,
        active: active ?? this.active,
        shopId: shopId ?? this.shopId,
        translation: translation ?? this.translation,
      );

  factory KitchenModel.fromJson(Map<String, dynamic> json) => KitchenModel(
        id: json['id'],
        active: json['active'],
        shopId: json['shop_id'],
        translation: json['translation'] == null
            ? null
            : Translation.fromJson(json['translation']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'active': active,
        'shop_id': shopId,
        'translation': translation?.toJson(),
      };
}

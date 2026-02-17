import 'translation.dart';

class ShopDelivery {
  ShopDelivery({
    int? id,
    int? shopId,
    String? type,
    int? price,
    List<String>? times,
    String? note,
    bool? active,
    Translation? translation,
  }) {
    _id = id;
    _shopId = shopId;
    _type = type;
    _price = price;
    _times = times;
    _note = note;
    _active = active;
    _translation = translation;
  }

  ShopDelivery.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _type = json['type'];
    _price = json['price'];
    _times = json['times'] != null ? json['times'].cast<String>() : [];
    _note = json['note'];
    _active = json['active'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  int? _shopId;
  String? _type;
  int? _price;
  List<String>? _times;
  String? _note;
  bool? _active;
  Translation? _translation;

  ShopDelivery copyWith({
    int? id,
    int? shopId,
    String? type,
    int? price,
    List<String>? times,
    String? note,
    bool? active,
    Translation? translation,
  }) =>
      ShopDelivery(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        type: type ?? _type,
        price: price ?? _price,
        times: times ?? _times,
        note: note ?? _note,
        active: active ?? _active,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  String? get type => _type;

  int? get price => _price;

  List<String>? get times => _times;

  String? get note => _note;

  bool? get active => _active;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['type'] = _type;
    map['price'] = _price;
    map['times'] = _times;
    map['note'] = _note;
    map['active'] = _active;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

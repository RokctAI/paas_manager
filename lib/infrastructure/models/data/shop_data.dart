import 'payment_data.dart';
import 'user_data.dart';
import 'translation.dart';
import 'product_data.dart';
import 'location_data.dart';
import 'category_data.dart';

class ShopData {
  ShopData({
    int? id,
    String? uuid,
    int? discountsCount,
    int? userId,
    num? price,
    num? pricePerKm,
    num? tax,
    num? percentage,
    String? phone,
    bool? visibility,
    String? backgroundImg,
    String? logoImg,
    num? minAmount,
    bool? isRecommended,
    bool? open,
    String? status,
    String? statusNote,
    String? type,
    num? avgRate,
    DeliveryTime? deliveryTime,
    String? inviteLink,
    String? orderPayment,
    num? ratingAvg,
    LocationData? location,
    int? productsCount,
    Translation? translation,
    List<Translation>? translations,
    List<String>? locales,
    UserData? seller,
    dynamic subscription,
    List<CategoryData>? categories,
    Bonus? bonus,
    List<Discount>? discount,
    List<ShopPayments>? shopPayments,
    List<ShopWorkingDays>? shopWorkingDays,
    List<ShopTag>? tags,
  }) {
    _id = id;
    _uuid = uuid;
    _orderPayment = orderPayment;
    _discountsCount = discountsCount;
    _userId = userId;
    _price = price;
    _pricePerKm = pricePerKm;
    _tax = tax;
    _percentage = percentage;
    _phone = phone;
    _visibility = visibility;
    _open = open;
    _backgroundImg = backgroundImg;
    _logoImg = logoImg;
    _minAmount = minAmount;
    _isRecommended = isRecommended;
    _status = status;
    _statusNote = statusNote;
    _type = type;
    _avgRate = avgRate;
    _deliveryTime = deliveryTime;
    _inviteLink = inviteLink;
    _ratingAvg = ratingAvg;
    _location = location;
    _productsCount = productsCount;
    _translation = translation;
    _translations = translations;
    _locales = locales;
    _seller = seller;
    _subscription = subscription;
    _categories = categories;
    _bonus = bonus;
    _discount = discount;
    _shopPayments = shopPayments;
    _shopWorkingDays = shopWorkingDays;
    _tags = tags;
  }

  ShopData.fromJson(dynamic json) {
    _id = json['id'];
    _orderPayment = json['order_payment'];
    _uuid = json['uuid'];
    _discountsCount = json['discounts_count'];
    _userId = json['user_id'];
    _price = json['price'];
    _pricePerKm = json['price_per_km'];
    _tax = json['tax'];
    _percentage = json['percentage'];
    _phone = json['phone'];
    _visibility = json['visibility'];
    _open = json["open"];
    _backgroundImg = json['background_img'];
    _logoImg = json['logo_img'];
    _minAmount = json['min_amount'];
    _isRecommended = json['is_recommended'];
    _status = json['status'];
    _statusNote = json['status_note'];
    _type = json['type']?.toString();
    _avgRate = json['avg_rate'];
    _deliveryTime = json['delivery_time'] != null
        ? DeliveryTime.fromJson(json['delivery_time'])
        : null;
    _inviteLink = json['invite_link'];
    _ratingAvg = json['rating_avg'];
    _location = json['location'] != null
        ? LocationData.fromJson(json['location'])
        : null;
    _productsCount = json['products_count'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    if (json['translations'] != null) {
      _translations = [];
      json['translations'].forEach((v) {
        _translations?.add(Translation.fromJson(v));
      });
    }
    _locales = json['locales'] != null ? json['locales'].cast<String>() : [];
    _seller = json['seller'] != null ? UserData.fromJson(json['seller']) : null;
    _subscription = json['subscription'];
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(CategoryData.fromJson(v));
      });
    }
    _bonus = json['bonus'] != null ? Bonus.fromJson(json['bonus']) : null;
    if (json['discount'] != null) {
      _discount = [];
      json['discount'].forEach((v) {
        _discount?.add(Discount.fromJson(v));
      });
    }
    if (json['shop_payments'] != null) {
      _shopPayments = [];
      json['shop_payments'].forEach((v) {
        _shopPayments?.add(ShopPayments.fromJson(v));
      });
    }
    if (json['shop_working_days'] != null) {
      _shopWorkingDays = [];
      json['shop_working_days'].forEach((v) {
        _shopWorkingDays?.add(ShopWorkingDays.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      _tags = [];
      json['tags'].forEach((v) {
        _tags?.add(ShopTag.fromJson(v));
      });
    }
  }

  int? _id;
  String? _uuid;
  String? _orderPayment;
  int? _discountsCount;
  int? _userId;
  num? _price;
  num? _pricePerKm;
  num? _tax;
  num? _percentage;
  String? _phone;
  bool? _visibility;
  String? _backgroundImg;
  String? _logoImg;
  num? _minAmount;
  bool? _isRecommended;
  bool? _open;
  String? _status;
  String? _statusNote;
  String? _type;
  num? _avgRate;
  DeliveryTime? _deliveryTime;
  String? _inviteLink;
  num? _ratingAvg;
  LocationData? _location;
  int? _productsCount;
  Translation? _translation;
  List<Translation>? _translations;
  List<String>? _locales;
  UserData? _seller;
  dynamic _subscription;
  List<CategoryData>? _categories;
  Bonus? _bonus;
  List<Discount>? _discount;
  List<ShopPayments>? _shopPayments;
  List<ShopWorkingDays>? _shopWorkingDays;
  List<ShopTag>? _tags;

  ShopData copyWith({
    int? id,
    String? uuid,
    String? orderPayment,
    int? discountsCount,
    int? userId,
    num? price,
    num? pricePerKm,
    num? tax,
    num? percentage,
    String? phone,
    bool? visibility,
    String? backgroundImg,
    String? logoImg,
    num? minAmount,
    bool? isRecommended,
    bool? open,
    String? status,
    String? statusNote,
    String? type,
    num? avgRate,
    DeliveryTime? deliveryTime,
    String? inviteLink,
    num? ratingAvg,
    LocationData? location,
    int? productsCount,
    Translation? translation,
    List<Translation>? translations,
    List<String>? locales,
    UserData? seller,
    dynamic subscription,
    List<CategoryData>? categories,
    Bonus? bonus,
    List<Discount>? discount,
    List<ShopPayments>? shopPayments,
    List<ShopWorkingDays>? shopWorkingDays,
    List<ShopTag>? tags,
  }) =>
      ShopData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        orderPayment: orderPayment ?? _orderPayment,
        discountsCount: discountsCount ?? _discountsCount,
        userId: userId ?? _userId,
        price: price ?? _price,
        pricePerKm: pricePerKm ?? _pricePerKm,
        tax: tax ?? _tax,
        percentage: percentage ?? _percentage,
        phone: phone ?? _phone,
        visibility: visibility ?? _visibility,
        open: open ?? _open,
        backgroundImg: backgroundImg ?? _backgroundImg,
        logoImg: logoImg ?? _logoImg,
        minAmount: minAmount ?? _minAmount,
        isRecommended: isRecommended ?? _isRecommended,
        status: status ?? _status,
        statusNote: statusNote ?? _statusNote,
        type: type ?? _type,
        avgRate: avgRate ?? _avgRate,
        deliveryTime: deliveryTime ?? _deliveryTime,
        inviteLink: inviteLink ?? _inviteLink,
        ratingAvg: ratingAvg ?? _ratingAvg,
        location: location ?? _location,
        productsCount: productsCount ?? _productsCount,
        translation: translation ?? _translation,
        translations: translations ?? _translations,
        locales: locales ?? _locales,
        seller: seller ?? _seller,
        subscription: subscription ?? _subscription,
        categories: categories ?? _categories,
        bonus: bonus ?? _bonus,
        discount: discount ?? _discount,
        shopPayments: shopPayments ?? _shopPayments,
        shopWorkingDays: shopWorkingDays ?? _shopWorkingDays,
        tags: tags ?? _tags,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get orderPayment => _orderPayment;

  int? get discountsCount => _discountsCount;

  int? get userId => _userId;

  num? get price => _price;

  num? get pricePerKm => _pricePerKm;

  num? get tax => _tax;

  num? get percentage => _percentage;

  String? get phone => _phone;

  bool? get visibility => _visibility;

  String? get backgroundImg => _backgroundImg;

  String? get logoImg => _logoImg;

  num? get minAmount => _minAmount;

  bool? get isRecommended => _isRecommended;

  bool? get open => _open;

  String? get status => _status;

  String? get statusNote => _statusNote;

  String? get type => _type;

  num? get avgRate => _avgRate;

  DeliveryTime? get deliveryTime => _deliveryTime;

  String? get inviteLink => _inviteLink;

  num? get ratingAvg => _ratingAvg;

  LocationData? get location => _location;

  int? get productsCount => _productsCount;

  Translation? get translation => _translation;

  List<Translation>? get translations => _translations;

  List<String>? get locales => _locales;

  UserData? get seller => _seller;

  dynamic get subscription => _subscription;

  List<CategoryData>? get categories => _categories;

  Bonus? get bonus => _bonus;

  List<Discount>? get discount => _discount;

  List<ShopPayments>? get shopPayments => _shopPayments;

  List<ShopWorkingDays>? get shopWorkingDays => _shopWorkingDays;

  List<ShopTag>? get tags => _tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['discounts_count'] = _discountsCount;
    map['user_id'] = _userId;
    map['price'] = _price;
    map['price_per_km'] = _pricePerKm;
    map['tax'] = _tax;
    map['percentage'] = _percentage;
    map['phone'] = _phone;
    map['visibility'] = _visibility;
    map['background_img'] = _backgroundImg;
    map['logo_img'] = _logoImg;
    map['min_amount'] = _minAmount;
    map['order_payment'] = _orderPayment;
    map['is_recommended'] = _isRecommended;
    map['status'] = _status;
    map['status_note'] = _statusNote;
    map['type'] = _type;
    map['avg_rate'] = _avgRate;
    if (_deliveryTime != null) {
      map['delivery_time'] = _deliveryTime?.toJson();
    }
    map['invite_link'] = _inviteLink;
    map['rating_avg'] = _ratingAvg;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['products_count'] = _productsCount;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_translations != null) {
      map['translations'] = _translations?.map((v) => v.toJson()).toList();
    }
    map['locales'] = _locales;
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    map['subscription'] = _subscription;
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_bonus != null) {
      map['bonus'] = _bonus?.toJson();
    }
    if (_discount != null) {
      map['discount'] = _discount?.map((v) => v.toJson()).toList();
    }
    if (_shopPayments != null) {
      map['shop_payments'] = _shopPayments?.map((v) => v.toJson()).toList();
    }
    if (_shopWorkingDays != null) {
      map['shop_working_days'] =
          _shopWorkingDays?.map((v) => v.toJson()).toList();
    }
    if (_tags != null) {
      map['tags'] = _tags?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DeliveryTime {
  DeliveryTime({
    String? to,
    String? from,
    String? type,
  }) {
    _to = to;
    _from = from;
    _type = type;
  }

  DeliveryTime.fromJson(dynamic json) {
    _to = json['to'].toString();
    _from = json['from'].toString();
    _type = json['type'];
  }

  String? _to;
  String? _from;
  String? _type;

  DeliveryTime copyWith({
    String? to,
    String? from,
    String? type,
  }) =>
      DeliveryTime(
        to: to ?? _to,
        from: from ?? _from,
        type: type ?? _type,
      );

  String? get to => _to;

  String? get from => _from;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['to'] = _to;
    map['from'] = _from;
    map['type'] = _type;
    return map;
  }
}

class Discount {
  Discount({
    int? id,
    int? shopId,
    String? type,
    num? price,
    String? start,
    String? end,
    int? active,
    String? img,
  }) {
    _id = id;
    _shopId = shopId;
    _type = type;
    _price = price;
    _start = start;
    _end = end;
    _active = active;
    _img = img;
  }

  Discount.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _type = json['type'];
    _price = json['price'];
    _start = json['start'];
    _end = json['end'];
    _active = json['active'];
    _img = json['img'];
  }

  int? _id;
  int? _shopId;
  String? _type;
  num? _price;
  String? _start;
  String? _end;
  int? _active;
  String? _img;

  Discount copyWith({
    int? id,
    int? shopId,
    String? type,
    num? price,
    String? start,
    String? end,
    int? active,
    String? img,
  }) =>
      Discount(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        type: type ?? _type,
        price: price ?? _price,
        start: start ?? _start,
        end: end ?? _end,
        active: active ?? _active,
        img: img ?? _img,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  String? get type => _type;

  num? get price => _price;

  String? get start => _start;

  String? get end => _end;

  int? get active => _active;

  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['type'] = _type;
    map['price'] = _price;
    map['start'] = _start;
    map['end'] = _end;
    map['active'] = _active;
    map['img'] = _img;
    return map;
  }
}

class Bonus {
  Bonus({
    String? bonusableType,
    int? bonusableId,
    int? bonusQuantity,
    int? bonusStockId,
    int? value,
    String? type,
    bool? status,
    String? expiredAt,
    BonusStock? bonusStock,
  }) {
    _bonusableType = bonusableType;
    _bonusableId = bonusableId;
    _bonusQuantity = bonusQuantity;
    _bonusStockId = bonusStockId;
    _value = value;
    _type = type;
    _status = status;
    _expiredAt = expiredAt;
    _bonusStock = bonusStock;
  }

  Bonus.fromJson(dynamic json) {
    _bonusableType = json['bonusable_type'];
    _bonusableId = json['bonusable_id'];
    _bonusQuantity = json['bonus_quantity'];
    _bonusStockId = json['bonus_stock_id'];
    _value = json['value'];
    _type = json['type'];
    _status = json['status'];
    _expiredAt = json['expired_at'];
    _bonusStock = json['bonusStock'] != null
        ? BonusStock.fromJson(json['bonusStock'])
        : null;
  }

  String? _bonusableType;
  int? _bonusableId;
  int? _bonusQuantity;
  int? _bonusStockId;
  int? _value;
  String? _type;
  bool? _status;
  String? _expiredAt;
  BonusStock? _bonusStock;

  Bonus copyWith({
    String? bonusableType,
    int? bonusableId,
    int? bonusQuantity,
    int? bonusStockId,
    int? value,
    String? type,
    bool? status,
    String? expiredAt,
    BonusStock? bonusStock,
  }) =>
      Bonus(
        bonusableType: bonusableType ?? _bonusableType,
        bonusableId: bonusableId ?? _bonusableId,
        bonusQuantity: bonusQuantity ?? _bonusQuantity,
        bonusStockId: bonusStockId ?? _bonusStockId,
        value: value ?? _value,
        type: type ?? _type,
        status: status ?? _status,
        expiredAt: expiredAt ?? _expiredAt,
        bonusStock: bonusStock ?? _bonusStock,
      );

  String? get bonusableType => _bonusableType;

  int? get bonusableId => _bonusableId;

  int? get bonusQuantity => _bonusQuantity;

  int? get bonusStockId => _bonusStockId;

  int? get value => _value;

  String? get type => _type;

  bool? get status => _status;

  String? get expiredAt => _expiredAt;

  BonusStock? get bonusStock => _bonusStock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bonusable_type'] = _bonusableType;
    map['bonusable_id'] = _bonusableId;
    map['bonus_quantity'] = _bonusQuantity;
    map['bonus_stock_id'] = _bonusStockId;
    map['value'] = _value;
    map['type'] = _type;
    map['status'] = _status;
    map['expired_at'] = _expiredAt;
    if (_bonusStock != null) {
      map['bonusStock'] = _bonusStock?.toJson();
    }
    return map;
  }
}

class BonusStock {
  BonusStock({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    num? tax,
    num? totalPrice,
    ProductData? product,
  }) {
    _id = id;
    _countableId = countableId;
    _price = price;
    _quantity = quantity;
    _tax = tax;
    _totalPrice = totalPrice;
    _product = product;
  }

  BonusStock.fromJson(dynamic json) {
    _id = json['id'];
    _countableId = json['countable_id'];
    _price = json['price'];
    _quantity = json['quantity'];
    _tax = json['tax'];
    _totalPrice = json['total_price'];
    _product =
        json['product'] != null ? ProductData.fromJson(json['product']) : null;
  }

  int? _id;
  int? _countableId;
  num? _price;
  int? _quantity;
  num? _tax;
  num? _totalPrice;
  ProductData? _product;

  BonusStock copyWith({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    num? tax,
    num? totalPrice,
    ProductData? product,
  }) =>
      BonusStock(
        id: id ?? _id,
        countableId: countableId ?? _countableId,
        price: price ?? _price,
        quantity: quantity ?? _quantity,
        tax: tax ?? _tax,
        totalPrice: totalPrice ?? _totalPrice,
        product: product ?? _product,
      );

  int? get id => _id;

  int? get countableId => _countableId;

  num? get price => _price;

  int? get quantity => _quantity;

  num? get tax => _tax;

  num? get totalPrice => _totalPrice;

  ProductData? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countable_id'] = _countableId;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['tax'] = _tax;
    map['total_price'] = _totalPrice;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}

class ShopPayments {
  ShopPayments({
    int? id,
    int? shopId,
    int? status,
    dynamic clientId,
    dynamic secretId,
    PaymentData? payment,
  }) {
    _id = id;
    _shopId = shopId;
    _status = status;
    _clientId = clientId;
    _secretId = secretId;
    _payment = payment;
  }

  ShopPayments.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _status = json['status'];
    _clientId = json['client_id'];
    _secretId = json['secret_id'];
    _payment =
        json['payment'] != null ? PaymentData.fromJson(json['payment']) : null;
  }

  int? _id;
  int? _shopId;
  int? _status;
  dynamic _clientId;
  dynamic _secretId;
  PaymentData? _payment;

  ShopPayments copyWith({
    int? id,
    int? shopId,
    int? status,
    dynamic clientId,
    dynamic secretId,
    PaymentData? payment,
  }) =>
      ShopPayments(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        status: status ?? _status,
        clientId: clientId ?? _clientId,
        secretId: secretId ?? _secretId,
        payment: payment ?? _payment,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  int? get status => _status;

  dynamic get clientId => _clientId;

  dynamic get secretId => _secretId;

  PaymentData? get payment => _payment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['status'] = _status;
    map['client_id'] = _clientId;
    map['secret_id'] = _secretId;
    if (_payment != null) {
      map['payment'] = _payment?.toJson();
    }
    return map;
  }
}

class ShopWorkingDays {
  ShopWorkingDays({
    int? id,
    String? day,
    String? from,
    String? to,
    bool? disabled,
  }) {
    _id = id;
    _day = day;
    _from = from;
    _to = to;
    _disabled = disabled;
  }

  ShopWorkingDays.fromJson(dynamic json) {
    _id = json['id'];
    _day = json['day'];
    _from = json['from'];
    _to = json['to'];
    _disabled = json['disabled'];
  }

  int? _id;
  String? _day;
  String? _from;
  String? _to;
  bool? _disabled;

  ShopWorkingDays copyWith({
    int? id,
    String? day,
    String? from,
    String? to,
    bool? disabled,
  }) =>
      ShopWorkingDays(
        id: id ?? _id,
        day: day ?? _day,
        from: from ?? _from,
        to: to ?? _to,
        disabled: disabled ?? _disabled,
      );

  int? get id => _id;

  String? get day => _day;

  String? get from => _from;

  String? get to => _to;

  bool? get disabled => _disabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['day'] = _day;
    map['from'] = _from;
    map['to'] = _to;
    map['disabled'] = _disabled;
    return map;
  }
}

class ShopTag {
  ShopTag({
    int? id,
    String? img,
    Translation? translation,
    List<String>? locales,
  }) {
    _id = id;
    _img = img;
    _translation = translation;
    _locales = locales;
  }

  ShopTag.fromJson(dynamic json) {
    _id = json['id'];
    _img = json['img'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    _locales = json['locales'] != null ? json['locales'].cast<String>() : [];
  }

  int? _id;
  String? _img;
  Translation? _translation;
  List<String>? _locales;

  ShopTag copyWith({
    int? id,
    String? img,
    Translation? translation,
    List<String>? locales,
  }) =>
      ShopTag(
        id: id ?? _id,
        img: img ?? _img,
        translation: translation ?? _translation,
        locales: locales ?? _locales,
      );

  int? get id => _id;

  String? get img => _img;

  Translation? get translation => _translation;

  List<String>? get locales => _locales;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['img'] = _img;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    map['locales'] = _locales;
    return map;
  }
}
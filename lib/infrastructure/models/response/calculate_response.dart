import '../data/stock.dart';

class CalculateResponse {
  CalculateResponse({NeedntData? data}) {
    _data = data;
  }

  CalculateResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? NeedntData.fromJson(json['data']) : null;
  }

  NeedntData? _data;

  CalculateResponse copyWith({NeedntData? data}) =>
      CalculateResponse(data: data ?? _data);

  NeedntData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class NeedntData {
  NeedntData({CalculatedData? data}) {
    _data = data;
  }

  NeedntData.fromJson(dynamic json) {
    _data = json['data'] != null ? CalculatedData.fromJson(json['data']) : null;
  }

  CalculatedData? _data;

  NeedntData copyWith({CalculatedData? data}) =>
      NeedntData(data: data ?? _data);

  CalculatedData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class CalculatedData {
  CalculatedData({
    List<Stock>? stocks,
    num? totalTax,
    num? price,
    num? totalShopTax,
    num? totalPrice,
    num? totalDiscount,
    num? deliveryFee,
    num? rate,
    num? couponPrice,
  }) {
    _stocks = stocks;
    _totalTax = totalTax;
    _price = price;
    _totalShopTax = totalShopTax;
    _totalPrice = totalPrice;
    _totalDiscount = totalDiscount;
    _deliveryFee = deliveryFee;
    _rate = rate;
    _couponPrice = couponPrice;
  }

  CalculatedData.fromJson(dynamic json) {
    if (json['stocks'] != null) {
      _stocks = [];
      json['stocks'].forEach((v) {
        _stocks?.add(Stock.fromJson(v));
      });
    }
    _totalTax = json['total_tax'];
    _price = json['price'];
    _totalShopTax = json['total_shop_tax'];
    _totalPrice = json['total_price'];
    _totalDiscount = json['total_discount'];
    _deliveryFee = json['delivery_fee'];
    _rate = json['rate'];
    _couponPrice = json['coupon_price'];
  }

  List<Stock>? _stocks;
  num? _totalTax;
  num? _price;
  num? _totalShopTax;
  num? _totalPrice;
  num? _totalDiscount;
  num? _deliveryFee;
  num? _rate;
  num? _couponPrice;

  CalculatedData copyWith({
    List<Stock>? stocks,
    num? totalTax,
    num? price,
    num? totalShopTax,
    num? totalPrice,
    num? totalDiscount,
    num? deliveryFee,
    num? rate,
    num? couponPrice,
  }) =>
      CalculatedData(
        stocks: stocks ?? _stocks,
        totalTax: totalTax ?? _totalTax,
        price: price ?? _price,
        totalShopTax: totalShopTax ?? _totalShopTax,
        totalPrice: totalPrice ?? _totalPrice,
        totalDiscount: totalDiscount ?? _totalDiscount,
        deliveryFee: deliveryFee ?? _deliveryFee,
        rate: rate ?? _rate,
        couponPrice: couponPrice ?? _couponPrice,
      );

  List<Stock>? get stocks => _stocks;

  num? get totalTax => _totalTax;

  num? get price => _price;

  num? get totalShopTax => _totalShopTax;

  num? get totalPrice => _totalPrice;

  num? get totalDiscount => _totalDiscount;

  num? get deliveryFee => _deliveryFee;

  num? get rate => _rate;

  num? get couponPrice => _couponPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_stocks != null) {
      map['stocks'] = _stocks?.map((v) => v.toJson()).toList();
    }
    map['total_tax'] = _totalTax;
    map['price'] = _price;
    map['total_shop_tax'] = _totalShopTax;
    map['total_price'] = _totalPrice;
    map['total_discount'] = _totalDiscount;
    map['delivery_fee'] = _deliveryFee;
    map['rate'] = _rate;
    map['coupon_price'] = _couponPrice;
    return map;
  }
}

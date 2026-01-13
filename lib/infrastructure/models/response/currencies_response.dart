import '../data/currency_data.dart';

class CurrenciesResponse {
  CurrenciesResponse({List<CurrencyData>? data}) {
    _data = data;
  }

  CurrenciesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CurrencyData.fromJson(v));
      });
    }
  }

  List<CurrencyData>? _data;

  CurrenciesResponse copyWith({List<CurrencyData>? data}) =>
      CurrenciesResponse(data: data ?? _data);

  List<CurrencyData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

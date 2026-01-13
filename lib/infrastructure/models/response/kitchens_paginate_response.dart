import '../data/kitchen_data.dart';

class KitchensPaginateResponse {
  KitchensPaginateResponse({List<KitchenModel>? data}) {
    _data = data;
  }

  KitchensPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(KitchenModel.fromJson(v));
      });
    }
  }

  List<KitchenModel>? _data;

  KitchensPaginateResponse copyWith({List<KitchenModel>? data}) =>
      KitchensPaginateResponse(data: data ?? _data);

  List<KitchenModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

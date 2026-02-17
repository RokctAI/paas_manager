import '../data/unit_data.dart';

class UnitsPaginateResponse {
  UnitsPaginateResponse({List<UnitData>? data}) {
    _data = data;
  }

  UnitsPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UnitData.fromJson(v));
      });
    }
  }

  List<UnitData>? _data;

  UnitsPaginateResponse copyWith({List<UnitData>? data}) =>
      UnitsPaginateResponse(data: data ?? _data);

  List<UnitData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

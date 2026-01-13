import '../data/extras.dart';

class ExtrasResponse {
  ExtrasResponse({List<Extras>? data}) {
    _data = data;
  }

  ExtrasResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Extras.fromJson(v));
      });
    }
  }

  List<Extras>? _data;

  ExtrasResponse copyWith({List<Extras>? data}) =>
      ExtrasResponse(data: data ?? _data);

  List<Extras>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

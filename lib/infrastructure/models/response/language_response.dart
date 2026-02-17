import '../data/language.dart';

class LanguagesResponse {
  LanguagesResponse({List<LanguageData>? data}) {
    _data = data;
  }

  LanguagesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LanguageData.fromJson(v));
      });
    }
  }

  List<LanguageData>? _data;

  LanguagesResponse copyWith({List<LanguageData>? data}) =>
      LanguagesResponse(data: data ?? _data);

  List<LanguageData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TranslationsResponse {
  TranslationsResponse({Map<String, dynamic>? data}) {
    _data = data;
  }

  TranslationsResponse.fromJson(dynamic json) {
    _data = json['data'];
  }

  Map<String, dynamic>? _data;

  TranslationsResponse copyWith({Map<String, dynamic>? data}) =>
      TranslationsResponse(data: data ?? _data);

  Map<String, dynamic>? get data => _data;
}

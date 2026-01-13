class SettingsData {
  SettingsData({int? id, String? key, String? value}) {
    _id = id;
    _key = key;
    _value = value;
  }

  SettingsData.fromJson(dynamic json) {
    _id = json['id'];
    _key = json['key'];
    _value = json['value'];
  }

  int? _id;
  String? _key;
  String? _value;

  SettingsData copyWith({int? id, String? key, String? value}) =>
      SettingsData(id: id ?? _id, key: key ?? _key, value: value ?? _value);

  int? get id => _id;

  String? get key => _key;

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }
}

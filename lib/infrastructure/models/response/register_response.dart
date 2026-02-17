class RegisterResponse {
  RegisterResponse({RegisterData? data}) {
    _data = data;
  }

  RegisterResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
  }

  RegisterData? _data;

  RegisterResponse copyWith({RegisterData? data}) =>
      RegisterResponse(data: data ?? _data);

  RegisterData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class RegisterData {
  RegisterData({String? verifyId, String? phone}) {
    _verifyId = verifyId;
    _phone = phone;
  }

  RegisterData.fromJson(dynamic json) {
    _verifyId = json['verifyId'];
    _phone = json['phone'];
  }

  String? _verifyId;
  String? _phone;

  RegisterData copyWith({String? verifyId, String? phone}) =>
      RegisterData(verifyId: verifyId ?? _verifyId, phone: phone ?? _phone);

  String? get verifyId => _verifyId;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verifyId'] = _verifyId;
    map['phone'] = _phone;
    return map;
  }
}

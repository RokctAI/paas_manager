import '../data/user_data.dart';

class VerifyPhoneResponse {
  VerifyPhoneResponse({VerifyData? data}) {
    _data = data;
  }

  VerifyPhoneResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? VerifyData.fromJson(json['data']) : null;
  }

  VerifyData? _data;

  VerifyPhoneResponse copyWith({VerifyData? data}) =>
      VerifyPhoneResponse(data: data ?? _data);

  VerifyData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class VerifyData {
  VerifyData({String? token, UserData? user}) {
    _token = token;
    _user = user;
  }

  VerifyData.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  String? _token;
  UserData? _user;

  VerifyData copyWith({String? token, UserData? user}) =>
      VerifyData(token: token ?? _token, user: user ?? _user);

  String? get token => _token;

  UserData? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

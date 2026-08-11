// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import '../data/user_data.dart';

class LoginResponse {
  LoginResponse({LoginData? data}) {
    _data = data;
  }

  LoginResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  LoginData? _data;

  LoginResponse copyWith({LoginData? data}) =>
      LoginResponse(data: data ?? _data);

  LoginData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class LoginData {
  LoginData({
    String? accessToken,
    String? tokenType,
    UserData? user,
  }) {
    _accessToken = accessToken;
    _tokenType = tokenType;
    _user = user;
  }

  LoginData.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  String? _accessToken;
  String? _tokenType;
  UserData? _user;

  LoginData copyWith({
    String? accessToken,
    String? tokenType,
    UserData? user,
  }) =>
      LoginData(
        accessToken: accessToken ?? _accessToken,
        tokenType: tokenType ?? _tokenType,
        user: user ?? _user,
      );

  String? get accessToken => _accessToken;

  String? get tokenType => _tokenType;

  UserData? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

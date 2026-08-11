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

class LanguageData {
  LanguageData({
    int? id,
    String? title,
    String? locale,
    bool? backward,
    bool? isDefault,
    bool? active,
    String? img,
  }) {
    _id = id;
    _title = title;
    _locale = locale;
    _backward = backward;
    _default = isDefault;
    _active = active;
    _img = img;
  }

  LanguageData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _locale = json['locale'];
    _backward = json['backward'];
    _default = json['default'];
    _active = json['active'];
    _img = json['img'];
  }

  int? _id;
  String? _title;
  String? _locale;
  bool? _backward;
  bool? _default;
  bool? _active;
  String? _img;

  LanguageData copyWith({
    int? id,
    String? title,
    String? locale,
    bool? backward,
    bool? isDefault,
    bool? active,
    String? img,
  }) =>
      LanguageData(
        id: id ?? _id,
        title: title ?? _title,
        locale: locale ?? _locale,
        backward: backward ?? _backward,
        isDefault: isDefault ?? _default,
        active: active ?? _active,
        img: img ?? _img,
      );

  int? get id => _id;

  String? get title => _title;

  String? get locale => _locale;

  bool? get backward => _backward;

  bool? get isDefault => _default;

  bool? get active => _active;

  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['locale'] = _locale;
    map['backward'] = _backward;
    map['default'] = _default;
    map['active'] = _active;
    map['img'] = _img;
    return map;
  }
}

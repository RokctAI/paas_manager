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

import 'extras.dart';
import 'translation.dart';

class Group {
  Group({
    int? id,
    int? shopId,
    String? type,
    bool? isChecked,
    Translation? translation,
    List<Extras>? fetchedExtras,
    List<Extras>? extraValues,
  }) {
    _id = id;
    _shopId = shopId;
    _type = type;
    _isChecked = isChecked;
    _translation = translation;
    _fetchedExtras = fetchedExtras;
    _extraValues = extraValues;
  }

  Group.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _shopId = json['shop_id'];
    _isChecked = false;
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    _fetchedExtras = [];
    if (json['extra_values'] != null) {
      _extraValues = [];
      json['extra_values'].forEach((v) {
        _extraValues?.add(Extras.fromJson(v));
      });
    }
  }

  int? _id;
  int? _shopId;
  String? _type;
  bool? _isChecked;
  Translation? _translation;
  List<Extras>? _fetchedExtras;
  List<Extras>? _extraValues;

  Group copyWith({
    int? id,
    int? shopId,
    String? type,
    bool? isChecked,
    Translation? translation,
    List<Extras>? fetchedExtras,
    List<Extras>? extraValues,
  }) =>
      Group(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        type: type ?? _type,
        isChecked: isChecked ?? _isChecked,
        translation: translation ?? _translation,
        fetchedExtras: fetchedExtras ?? _fetchedExtras,
        extraValues: extraValues ?? _extraValues,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  String? get type => _type;

  bool? get isChecked => _isChecked;

  Translation? get translation => _translation;

  List<Extras>? get fetchedExtras => _fetchedExtras;

  List<Extras>? get extraValues => _extraValues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['type'] = _type;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_extraValues != null) {
      map['extra_values'] = _extraValues?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

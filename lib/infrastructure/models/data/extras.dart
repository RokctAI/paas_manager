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

import 'package:manager/infrastructure/services/extension.dart';

import 'group.dart';

class Extras {
  Extras({
    int? id,
    int? extraGroupId,
    String? value,
    Group? group,
    StockPivot? pivot,
    bool? active,
  }) {
    _id = id;
    _extraGroupId = extraGroupId;
    _value = value;
    _group = group;
    _pivot = pivot;
    _active = active;
  }

  Extras.fromJson(dynamic json) {
    _id = json['id'];
    _extraGroupId = json['extra_group_id'];
    _value = json['value'];
    _group = json['group'] != null ? Group.fromJson(json['group']) : null;
    _pivot = json['pivot'] != null ? StockPivot.fromJson(json['pivot']) : null;
    _active = json['active']?.toString().toBool();
  }

  int? _id;
  int? _extraGroupId;
  String? _value;
  Group? _group;
  StockPivot? _pivot;
  bool? _active;

  Extras copyWith({
    int? id,
    int? extraGroupId,
    String? value,
    Group? group,
    StockPivot? pivot,
    bool? active,
  }) =>
      Extras(
        id: id ?? _id,
        extraGroupId: extraGroupId ?? _extraGroupId,
        value: value ?? _value,
        group: group ?? _group,
        pivot: pivot ?? _pivot,
        active: active ?? _active,
      );

  int? get id => _id;

  int? get extraGroupId => _extraGroupId;

  String? get value => _value;

  Group? get group => _group;

  StockPivot? get pivot => _pivot;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['extra_group_id'] = _extraGroupId;
    map['value'] = _value;
    if (_group != null) {
      map['group'] = _group?.toJson();
    }
    if (_pivot != null) {
      map['pivot'] = _pivot?.toJson();
    }
    map['active'] = _active;
    return map;
  }
}

class StockPivot {
  StockPivot({int? stockId, int? extraValueId}) {
    _stockId = stockId;
    _extraValueId = extraValueId;
  }

  StockPivot.fromJson(dynamic json) {
    _stockId = json['stock_id'];
    _extraValueId = json['extra_value_id'];
  }

  int? _stockId;
  int? _extraValueId;

  StockPivot copyWith({int? stockId, int? extraValueId}) => StockPivot(
        stockId: stockId ?? _stockId,
        extraValueId: extraValueId ?? _extraValueId,
      );

  int? get stockId => _stockId;

  int? get extraValueId => _extraValueId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stock_id'] = _stockId;
    map['extra_value_id'] = _extraValueId;
    return map;
  }
}

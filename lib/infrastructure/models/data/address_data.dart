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

import 'location_data.dart';

class AddressData {
  AddressData({
    int? id,
    String? title,
    String? address,
    LocationData? location,
    bool? isDefault,
    bool? active,
  }) {
    _id = id;
    _title = title;
    _address = address;
    _location = location;
    _default = isDefault;
    _active = active;
  }

  AddressData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    // _address = json['address'];
    // _location = json['location'] != null
    //     ? LocationData.fromJson(json['location'])
    //     : null;
    _default = json['default'];
    _active = json['active'];
  }

  int? _id;
  String? _title;
  String? _address;
  LocationData? _location;
  bool? _default;
  bool? _active;

  AddressData copyWith({
    int? id,
    String? title,
    String? address,
    LocationData? location,
    bool? isDefault,
    bool? active,
  }) =>
      AddressData(
        id: id ?? _id,
        title: title ?? _title,
        address: address ?? _address,
        location: location ?? _location,
        isDefault: isDefault ?? _default,
        active: active ?? _active,
      );

  int? get id => _id;

  String? get title => _title;

  String? get address => _address;

  LocationData? get location => _location;

  bool? get isDefault => _default;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['address'] = _address;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['default'] = _default;
    map['active'] = _active;
    return map;
  }
}

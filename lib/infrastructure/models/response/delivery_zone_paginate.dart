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

import 'package:base_sdk/src/models/data/shop_data.dart';

class DeliveryZonePaginate {
  DeliveryZonePaginate({List<DeliveryZoneData>? data}) {
    _data = data;
  }

  DeliveryZonePaginate.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DeliveryZoneData.fromJson(v));
      });
    }
  }

  List<DeliveryZoneData>? _data;

  DeliveryZonePaginate copyWith({List<DeliveryZoneData>? data}) =>
      DeliveryZonePaginate(data: data ?? _data);

  List<DeliveryZoneData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DeliveryZoneData {
  DeliveryZoneData({
    int? id,
    List<List<double>>? address,
    ShopData? shop,
  }) {
    _id = id;
    _address = address;
    _shop = shop;
  }

  DeliveryZoneData.fromJson(dynamic json) {
    final List<dynamic>? addresses = json['address'];
    final List<List<double>> parsedAddresses = [];
    if (addresses != null) {
      for (int i = 0; i < addresses.length; i++) {
        final List<dynamic> item = addresses[i];
        List<double> items = [];
        for (int j = 0; j < item.length; j++) {
          items.add(double.parse(item[j].toString()));
        }
        parsedAddresses.add(items);
      }
    }
    _id = json['id'];
    _address = parsedAddresses;
    _shop = json['shop'] != null ? ShopData.fromJson(json['shop']) : null;
  }

  int? _id;
  List<List<double>>? _address;
  ShopData? _shop;

  DeliveryZoneData copyWith({
    int? id,
    List<List<double>>? address,
    ShopData? shop,
  }) =>
      DeliveryZoneData(
        id: id ?? _id,
        address: address ?? _address,
        shop: shop ?? _shop,
      );

  int? get id => _id;

  List<List<double>>? get address => _address;

  ShopData? get shop => _shop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address'] = _address;
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }
    return map;
  }
}

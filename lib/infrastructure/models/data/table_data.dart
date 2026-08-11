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

import 'translation.dart';

class TableData {
  int? id;
  String? name;
  int? shopSectionId;
  int? tax;
  int? chairCount;
  bool? active;
  String? createdAt;
  String? updatedAt;
  ShopSection? shopSection;

  TableData(
      {this.id,
      this.name,
      this.shopSectionId,
      this.tax,
      this.chairCount,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.shopSection});

  TableData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopSectionId = json['shop_section_id'];
    tax = json['tax'];
    chairCount = json['chair_count'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shopSection = json['shop_section'] != null
        ? ShopSection.fromJson(json['shop_section'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shop_section_id'] = shopSectionId;
    data['tax'] = tax;
    data['chair_count'] = chairCount;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (shopSection != null) {
      data['shop_section'] = shopSection!.toJson();
    }
    return data;
  }
}

class ShopSection {
  int? id;
  int? shopId;
  String? area;
  String? img;
  String? createdAt;
  String? updatedAt;
  Translation? translation;

  ShopSection(
      {this.id,
      this.shopId,
      this.area,
      this.img,
      this.createdAt,
      this.updatedAt,
      this.translation});

  ShopSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    area = json['area'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_id'] = shopId;
    data['area'] = area;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (translation != null) {
      data['translation'] = translation!.toJson();
    }
    return data;
  }
}

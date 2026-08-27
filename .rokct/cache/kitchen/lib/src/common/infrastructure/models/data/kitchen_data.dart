// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:base_sdk/src/models/data/translation.dart';

/// A kitchen (prep station) belonging to a shop.
///
/// Ported from `paas_manager`'s `KitchenModel`. The app carried its own
/// `Translation`; base_sdk's is a superset of it (83% identical, plus
/// `buttonText`/`address`), so this uses base_sdk's per the
/// prefer-the-SDK's-version convention.
class KitchenModel {
  KitchenModel({this.id, this.active, this.shopId, this.translation});

  String? id;
  int? active;
  String? shopId;
  Translation? translation;

  String get title => translation?.title ?? '';

  KitchenModel copyWith({
    String? id,
    int? active,
    String? shopId,
    Translation? translation,
  }) =>
      KitchenModel(
        id: id ?? this.id,
        active: active ?? this.active,
        shopId: shopId ?? this.shopId,
        translation: translation ?? this.translation,
      );

  factory KitchenModel.fromJson(Map<String, dynamic> json) => KitchenModel(
        // Kitchen docnames are Frappe hash strings; list endpoints emit only
        // `name`, so fall back to it (reference pattern, sections_tables).
        id: (json['id'] ?? json['name'])?.toString(),
        active: json['active'],
        shopId: json['shop_id']?.toString(),
        translation: json['translation'] == null
            ? null
            : Translation.fromJson(json['translation']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'active': active,
        'shop_id': shopId,
        'translation': translation?.toJson(),
      };
}

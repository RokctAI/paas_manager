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

// lib/water/models/shop.dart
class Shop {
  final int id;
  final String name;
  final String logoImg;
  final String title;

  Shop({
    required this.id,
    required this.name,
    required this.logoImg,
    required this.title,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      logoImg: json['logo_img'] ?? '', // Providing default empty string if null
      title: json['title'] ?? json['name'], // Using name as fallback for title
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_img': logoImg,
      'title': title,
    };
  }
}
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

import 'dart:convert';

class StoreInfo {
  final String storeName;
  final String branch;

  StoreInfo({
    required this.storeName,
    required this.branch,
  });

  StoreInfo copyWith({
    String? storeName,
    String? branch,
  }) {
    return StoreInfo(
      storeName: storeName ?? this.storeName,
      branch: branch ?? this.branch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'branch': branch,
    };
  }

  factory StoreInfo.fromMap(Map<String, dynamic> map) {
    return StoreInfo(
      storeName: map['storeName'] ?? '',
      branch: map['branch'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreInfo.fromJson(String source) => StoreInfo.fromMap(json.decode(source));

  @override
  String toString() => 'StoreInfo(storeName: $storeName, branch: $branch)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoreInfo &&
        other.storeName == storeName &&
        other.branch == branch;
  }

  @override
  int get hashCode => storeName.hashCode ^ branch.hashCode;
}
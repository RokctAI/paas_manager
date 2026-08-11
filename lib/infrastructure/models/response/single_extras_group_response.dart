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

import '../data/group.dart';

class SingleExtrasGroupResponse {
  SingleExtrasGroupResponse({Group? data}) {
    _data = data;
  }

  SingleExtrasGroupResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Group.fromJson(json['data']) : null;
  }

  Group? _data;

  SingleExtrasGroupResponse copyWith({Group? data}) =>
      SingleExtrasGroupResponse(data: data ?? _data);

  Group? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

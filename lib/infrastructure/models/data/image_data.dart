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

class ImageData {
  ImageData({
    int? id,
    String? title,
    String? type,
    int? loadableId,
    String? path,
    String? basePath,
  }) {
    _id = id;
    _title = title;
    _type = type;
    _loadableId = loadableId;
    _path = path;
    _basePath = basePath;
  }

  ImageData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _type = json['type'];
    _loadableId = json['loadable_id'];
    _path = json['path'];
    _basePath = json['base_path'];
  }

  int? _id;
  String? _title;
  String? _type;
  int? _loadableId;
  String? _path;
  String? _basePath;

  ImageData copyWith({
    int? id,
    String? title,
    String? type,
    int? loadableId,
    String? path,
    String? basePath,
  }) =>
      ImageData(
        id: id ?? _id,
        title: title ?? _title,
        type: type ?? _type,
        loadableId: loadableId ?? _loadableId,
        path: path ?? _path,
        basePath: basePath ?? _basePath,
      );

  int? get id => _id;

  String? get title => _title;

  String? get type => _type;

  int? get loadableId => _loadableId;

  String? get path => _path;

  String? get basePath => _basePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['type'] = _type;
    map['loadable_id'] = _loadableId;
    map['path'] = _path;
    map['base_path'] = _basePath;
    return map;
  }
}

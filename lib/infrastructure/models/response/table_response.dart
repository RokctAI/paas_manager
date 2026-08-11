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

import '../data/table_data.dart';

class TableResponse {
  String? timestamp;
  bool? status;
  String? message;
  List<TableData>? data;

  TableResponse({this.timestamp, this.status, this.message, this.data});

  TableResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    data = List<TableData>.from(json["data"].map((x) => TableData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = List<dynamic>.from(this.data!.map((x) => x.toJson()));
    }
    return data;
  }
}

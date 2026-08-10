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


import '../data/bookings_data.dart';

class BookingsResponse {
  BookingsData? data;

  BookingsResponse({required this.data});

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      BookingsResponse(data: json["data"]== null?null: BookingsData.fromJson(json["data"]));

}

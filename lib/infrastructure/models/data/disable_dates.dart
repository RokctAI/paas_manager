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


List<DisableDates> disableDatesFromJson(dynamic str) => List<DisableDates>.from(str.map((x) => DisableDates.fromJson(x)));


class DisableDates {
  DateTime startDate;
  DateTime endDate;

  DisableDates({
    required this.startDate,
    required this.endDate,
  });

  factory DisableDates.fromJson(Map<String, dynamic> json) => DisableDates(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
  };
}

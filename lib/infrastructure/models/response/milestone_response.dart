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

class MilestoneResponse {
  final List<Milestone>? data;

  MilestoneResponse({this.data});

  factory MilestoneResponse.fromJson(Map<String, dynamic> json) =>
      MilestoneResponse(
        data: json["data"] == null
            ? []
            : List<Milestone>.from(
                json["data"]!.map((x) => Milestone.fromJson(x))),
      );
}

class Milestone {
  final int? id;
  final String? name;
  final int? projectId;
  final String? status;
  final String? startDate;
  final String? endDate;

  Milestone({
    this.id,
    this.name,
    this.projectId,
    this.status,
    this.startDate,
    this.endDate,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) => Milestone(
        id: json["id"],
        name: json["title"],
        projectId: json["project_id"],
        status: json["status"],
        startDate: json["start_date"],
        endDate: json["end_date"],
      );
}

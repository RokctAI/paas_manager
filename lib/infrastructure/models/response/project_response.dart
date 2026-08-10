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

class ProjectResponse {
  final List<Project>? data;

  ProjectResponse({this.data});

  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      ProjectResponse(
        data: json["data"] == null
            ? []
            : List<Project>.from(
                json["data"]!.map((x) => Project.fromJson(x))),
      );
}

class Project {
  final int? id;
  final String? name;
  final String? startDate;
  final String? endDate;
  final String? description;
  final String? status;

  Project({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.description,
    this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["project_name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        description: json["description"],
        status: json["status"],
      );
}

class ProjectTask {
    // Basic model for now
    final int? id;
    final String? name;
    final String? priority;
    final int? stageId;

    ProjectTask({this.id, this.name, this.priority, this.stageId});

    factory ProjectTask.fromJson(Map<String, dynamic> json) => ProjectTask(
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        stageId: json["stage_id"],
    );
}

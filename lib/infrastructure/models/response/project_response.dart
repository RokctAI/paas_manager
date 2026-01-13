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

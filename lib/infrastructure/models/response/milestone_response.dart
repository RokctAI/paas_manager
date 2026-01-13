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

class LeadResponse {
  final List<Lead>? data;

  LeadResponse({this.data});

  factory LeadResponse.fromJson(Map<String, dynamic> json) =>
      LeadResponse(
        data: json["data"] == null
            ? []
            : List<Lead>.from(
                json["data"]!.map((x) => Lead.fromJson(x))),
      );
}

class Lead {
  final int? id;
  final String? name;
  final String? email;
  final String? subject;
  final int? stageId;
  final String? stageName;

  Lead({
    this.id,
    this.name,
    this.email,
    this.subject,
    this.stageId,
    this.stageName,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        subject: json["subject"],
        stageId: json["stage_id"],
        stageName: json["stage"]?["name"],
      );
}

class LeadStage {
    final int? id;
    final String? name;

    LeadStage({this.id, this.name});

    factory LeadStage.fromJson(Map<String, dynamic> json) => LeadStage(
        id: json["id"],
        name: json["name"],
    );
}

class LeadFormDataResponse {
    final List<LeadStage>? stages;
    // Add other form data fields as needed, e.g., users, pipelines, sources

    LeadFormDataResponse({this.stages});

    factory LeadFormDataResponse.fromJson(Map<String, dynamic> json) =>
        LeadFormDataResponse(
            stages: json["stages"] == null
                ? []
                : List<LeadStage>.from(
                    json["stages"]!.map((x) => LeadStage.fromJson(x))),
        );
}

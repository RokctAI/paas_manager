import 'package:venderfoodyman/infrastructure/models/models.dart';

class ProjectFormDataResponse {
  final List<User>? users;
  final List<String>? statuses;

  ProjectFormDataResponse({
    this.users,
    this.statuses,
  });

  factory ProjectFormDataResponse.fromJson(Map<String, dynamic> json) =>
      ProjectFormDataResponse(
        users: json["users"] == null
            ? []
            : List<User>.from(
                json["users"]!.map((x) => User.fromJson(x))),
        statuses: json["status"] == null
            ? []
            : List<String>.from(json["status"]!.map((x) => x)),
      );
}

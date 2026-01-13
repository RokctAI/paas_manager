class EmployeeFormDataResponse {
  final List<Branch>? branches;
  final List<Department>? departments;
  final List<Designation>? designations;

  EmployeeFormDataResponse({
    this.branches,
    this.departments,
    this.designations,
  });

  factory EmployeeFormDataResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeFormDataResponse(
        branches: json["branches"] == null
            ? []
            : List<Branch>.from(
                json["branches"]!.map((x) => Branch.fromJson(x))),
        departments: json["departments"] == null
            ? []
            : List<Department>.from(
                json["departments"]!.map((x) => Department.fromJson(x))),
        designations: json["designations"] == null
            ? []
            : List<Designation>.from(
                json["designations"]!.map((x) => Designation.fromJson(x))),
      );
}

class Branch {
  final int? id;
  final String? name;

  Branch({this.id, this.name});

  factory Branch.fromJson(Map<String, dynamic> json) =>
      Branch(id: json["id"], name: json["name"]);
}

class Department {
  final int? id;
  final String? name;

  Department({this.id, this.name});

  factory Department.fromJson(Map<String, dynamic> json) =>
      Department(id: json["id"], name: json["name"]);
}

class Designation {
  final int? id;
  final String? name;

  Designation({this.id, this.name});

  factory Designation.fromJson(Map<String, dynamic> json) =>
      Designation(id: json["id"], name: json["name"]);
}

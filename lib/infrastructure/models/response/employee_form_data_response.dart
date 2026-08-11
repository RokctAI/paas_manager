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

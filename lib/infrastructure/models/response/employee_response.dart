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

class EmployeeResponse {
  final List<Employee>? data;

  EmployeeResponse({this.data});

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeResponse(
        data: json["data"] == null
            ? []
            : List<Employee>.from(
                json["data"]!.map((x) => Employee.fromJson(x))),
      );
}

class Employee {
  final int? id;
  final String? name;
  final String? dob;
  final String? gender;
  final String? phone;
  final String? address;
  final String? email;
  final int? employeeId;
  final int? branchId;
  final int? departmentId;
  final int? designationId;
  final String? companyDoj;
  final Branch? branch;
  final Branch? department;
  final Branch? designation;

  Employee({
    this.id,
    this.name,
    this.dob,
    this.gender,
    this.phone,
    this.address,
    this.email,
    this.employeeId,
    this.branchId,
    this.departmentId,
    this.designationId,
    this.companyDoj,
    this.branch,
    this.department,
    this.designation,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
        employeeId: json["employee_id"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        companyDoj: json["company_doj"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        department: json["department"] == null ? null : Branch.fromJson(json["department"]),
        designation: json["designation"] == null ? null : Branch.fromJson(json["designation"]),
      );
}

// Using a single 'Branch' class for Branch, Department, and Designation as they share the same structure (id, name)
class Branch {
  final int? id;
  final String? name;

  Branch({this.id, this.name});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
      );
}

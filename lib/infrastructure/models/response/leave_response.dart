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

class LeaveResponse {
  final List<Leave>? data;

  LeaveResponse({this.data});

  factory LeaveResponse.fromJson(Map<String, dynamic> json) =>
      LeaveResponse(
        data: json["data"] == null
            ? []
            : List<Leave>.from(
                json["data"]!.map((x) => Leave.fromJson(x))),
      );
}

class Leave {
  final int? id;
  final int? employeeId;
  final int? leaveTypeId;
  final String? appliedOn;
  final String? startDate;
  final String? endDate;
  final int? totalLeaveDays;
  final String? leaveReason;
  final String? remark;
  final String? status;
  final String? employeeName;
  final String? leaveTypeName;

  Leave({
    this.id,
    this.employeeId,
    this.leaveTypeId,
    this.appliedOn,
    this.startDate,
    this.endDate,
    this.totalLeaveDays,
    this.leaveReason,
    this.remark,
    this.status,
    this.employeeName,
    this.leaveTypeName,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        id: json["id"],
        employeeId: json["employee_id"],
        leaveTypeId: json["leave_type_id"],
        appliedOn: json["applied_on"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        totalLeaveDays: json["total_leave_days"],
        leaveReason: json["leave_reason"],
        remark: json["remark"],
        status: json["status"],
        employeeName: json["employees"]?["name"],
        leaveTypeName: json["leave_type"]?["title"],
      );
}

class LeaveType {
    final int? id;
    final String? title;

    LeaveType({this.id, this.title});

    factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        title: json["title"],
    );
}

class LeaveFormDataResponse {
    final List<LeaveType>? leaveTypes;

    LeaveFormDataResponse({this.leaveTypes});

    factory LeaveFormDataResponse.fromJson(Map<String, dynamic> json) =>
        LeaveFormDataResponse(
            leaveTypes: json["leaveTypes"] == null
                ? []
                : List<LeaveType>.from(
                    json["leaveTypes"]!.map((x) => LeaveType.fromJson(x))),
        );
}

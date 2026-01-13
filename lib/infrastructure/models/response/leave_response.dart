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

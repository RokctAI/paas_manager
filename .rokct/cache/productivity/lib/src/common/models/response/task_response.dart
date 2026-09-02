// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:productivity_sdk/productivity_sdk.dart';

class TaskResponse {
  final String id;
  final String title;
  final String? description;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? createdBy;

  TaskResponse({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
  });

  factory TaskResponse.fromMap(Map<String, dynamic> map) {
    return TaskResponse(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      status: map['status'] ?? 'draft',
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
      createdBy: map['createdBy'],
    );
  }
}

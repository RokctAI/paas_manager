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

class TaskRequest {
  final String title;
  final String? description;
  final DateTime? dueDate;
  final String? category;
  final String priority;
  final String recurrence;

  TaskRequest({
    required this.title,
    this.description,
    this.dueDate,
    this.category,
    required this.priority,
    required this.recurrence,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'category': category,
      'priority': priority,
      'recurrence': recurrence,
    };
  }
}

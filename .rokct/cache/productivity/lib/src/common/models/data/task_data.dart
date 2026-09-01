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

import 'dart:convert';
import 'package:base_sdk/base_sdk.dart';

class TaskModel implements ProcessingContract {
  final String id;
  final String title;
  final String? description;
  final ProcessingState status;
  final DateTime? dueDate;
  final List<String> tags;
  final String? assignedTo; // User ID
  final String? checklistId; // Related checklist if any
  final List<TaskChecklistItem> checklist;
  final DateTime lastUpdated;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.status = ProcessingState.draft,
    this.dueDate,
    this.tags = const [],
    this.assignedTo,
    this.checklistId,
    this.checklist = const [],
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  // ProcessingContract interface overrides
  @override
  String get contractId => id;

  @override
  String get contractType => 'task';

  @override
  ProcessingState get currentState => status;

  @override
  bool get isPaid => true; // Tasks are operational and don't require financial coupling

  @override
  Map<String, dynamic> get metadata => {
    'title': title,
    'description': description,
    'tags': tags,
    'assignedTo': assignedTo,
    'checklistId': checklistId,
  };

  @override
  DateTime get updatedAt => lastUpdated;

  bool get isCompleted => status == ProcessingState.completed;

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    ProcessingState? status,
    DateTime? dueDate,
    List<String>? tags,
    String? assignedTo,
    String? checklistId,
    List<TaskChecklistItem>? checklist,
    DateTime? lastUpdated,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      tags: tags ?? this.tags,
      assignedTo: assignedTo ?? this.assignedTo,
      checklistId: checklistId ?? this.checklistId,
      checklist: checklist ?? this.checklist,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'dueDate': dueDate?.toIso8601String(),
      'tags': tags,
      'assignedTo': assignedTo,
      'checklistId': checklistId,
      'checklist': checklist.map((x) => x.toMap()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      status: ProcessingState.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ProcessingState.draft,
      ),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      tags: List<String>.from(map['tags'] ?? []),
      assignedTo: map['assignedTo'],
      checklistId: map['checklistId'],
      checklist: List<TaskChecklistItem>.from(
        (map['checklist'] ?? []).map((x) => TaskChecklistItem.fromMap(x)),
      ),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'])
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  static List<TaskModel> decodeList(String jsonString) {
    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.map((x) => TaskModel.fromMap(x)).toList();
  }

  static String encodeList(List<TaskModel> list) {
    return json.encode(list.map((x) => x.toMap()).toList());
  }
}

class TaskChecklistItem {
  final String id;
  final String title;
  final bool isCompleted;

  TaskChecklistItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  TaskChecklistItem copyWith({String? id, String? title, bool? isCompleted}) {
    return TaskChecklistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  factory TaskChecklistItem.fromMap(Map<String, dynamic> map) {
    return TaskChecklistItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}

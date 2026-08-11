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

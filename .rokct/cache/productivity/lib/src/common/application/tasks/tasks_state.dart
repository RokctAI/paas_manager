import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksState {
  final List<TaskModel> tasks;
  final bool isLoading;
  final String? errorMessage;

  TasksState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TasksState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

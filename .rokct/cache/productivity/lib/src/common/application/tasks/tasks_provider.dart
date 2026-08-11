import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:productivity_sdk/productivity_sdk.dart';
import '../../infrastructure/services/task_service.dart';
import '../app_database_provider.dart';
import 'tasks_notifier.dart';
import 'tasks_state.dart';

final taskServiceProvider = Provider<TaskService>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return TaskService(database);
});

final tasksStateProvider = StateNotifierProvider<TasksNotifier, TasksState>((ref) {
  final service = ref.watch(taskServiceProvider);
  return TasksNotifier(service);
});

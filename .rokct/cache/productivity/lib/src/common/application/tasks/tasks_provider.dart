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

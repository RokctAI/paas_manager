import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:productivity_sdk/productivity_sdk.dart';
import '../app_database_provider.dart';
import 'recovery_notifier.dart';
import 'recovery_state.dart';

final recoveryRepositoryProvider = Provider<RecoveryRepositoryFacade>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return RecoveryRepositoryImpl(database);
});

final recoveryStateProvider = StateNotifierProvider<RecoveryNotifier, RecoveryState>((ref) {
  final repository = ref.watch(recoveryRepositoryProvider);
  final database = ref.watch(appDatabaseProvider);
  return RecoveryNotifier(repository, database);
});

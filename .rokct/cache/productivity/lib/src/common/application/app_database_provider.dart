import 'package:base_sdk/base_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared handle on the composed app's single drift database (base_sdk owns
/// the AppDatabase singleton). Referenced by the tasks and recovery
/// providers; overridable in tests via ProviderScope.
final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

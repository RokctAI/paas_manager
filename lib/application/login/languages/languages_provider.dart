import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'languages_state.dart';
import 'languages_notifier.dart';
import '../../../domain/di/dependency_manager.dart';

final languagesProvider =
    StateNotifierProvider<LanguagesNotifier, LanguagesState>(
  (ref) => LanguagesNotifier(settingsRepository),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'extras_state.dart';
import 'extras_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final extrasProvider = StateNotifierProvider<ExtrasNotifier, ExtrasState>(
  (ref) => ExtrasNotifier(productRepository),
);

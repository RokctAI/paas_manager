import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'addons_notifier.dart';
import 'addons_state.dart';

final addonsProvider = StateNotifierProvider<AddonsNotifier, AddonsState>(
  (ref) => AddonsNotifier(productRepository),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'update_extras_group_state.dart';
import 'update_extras_group_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final updateExtrasGroupProvider =
    StateNotifierProvider<UpdateExtrasGroupNotifier, UpdateExtrasGroupState>(
  (ref) => UpdateExtrasGroupNotifier(productRepository),
);

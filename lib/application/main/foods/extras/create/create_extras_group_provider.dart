import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'create_extras_group_notifier.dart';
import 'create_extras_group_state.dart';

final createExtrasGroupProvider =
    StateNotifierProvider<CreateExtrasGroupNotifier, CreateExtrasGroupState>(
  (ref) => CreateExtrasGroupNotifier(productRepository),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'delete_extras_group_notifier.dart';
import 'delete_extras_group_state.dart';

final deleteExtrasGroupProvider =
    StateNotifierProvider<DeleteExtrasGroupNotifier, DeleteExtrasGroupState>(
      (ref) => DeleteExtrasGroupNotifier(productRepository),
    );

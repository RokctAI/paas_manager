import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_addon_state.dart';
import 'create_addon_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final createAddonProvider =
    StateNotifierProvider.autoDispose<CreateAddonNotifier, CreateAddonState>(
      (ref) => CreateAddonNotifier(productRepository),
    );

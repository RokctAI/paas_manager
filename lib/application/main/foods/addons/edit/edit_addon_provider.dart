import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_addon_state.dart';
import 'edit_addon_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final editAddonProvider =
    StateNotifierProvider<EditAddonNotifier, EditAddonState>(
      (ref) => EditAddonNotifier(productRepository),
    );

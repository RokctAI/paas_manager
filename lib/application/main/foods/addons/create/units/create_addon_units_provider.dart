import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'create_addon_units_notifier.dart';
import 'create_addon_units_state.dart';

final createAddonUnitsProvider =
    StateNotifierProvider<CreateAddonUnitsNotifier, CreateAddonUnitsState>(
      (ref) => CreateAddonUnitsNotifier(catalogRepository),
    );

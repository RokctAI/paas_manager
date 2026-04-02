import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'edit_addon_units_notifier.dart';
import 'edit_addon_units_state.dart';

final editAddonUnitsProvider =
    StateNotifierProvider<EditAddonUnitsNotifier, EditAddonUnitsState>(
      (ref) => EditAddonUnitsNotifier(catalogRepository),
    );

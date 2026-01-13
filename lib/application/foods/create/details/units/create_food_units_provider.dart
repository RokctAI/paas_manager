import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_food_units_state.dart';
import 'create_food_units_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final createFoodUnitsProvider =
    StateNotifierProvider<CreateFoodUnitsNotifier, CreateFoodUnitsState>(
  (ref) => CreateFoodUnitsNotifier(catalogRepository),
);

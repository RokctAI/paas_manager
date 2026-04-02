import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_food_kitchens_state.dart';
import 'create_food_kitchens_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final createFoodKitchensProvider =
    StateNotifierProvider<CreateFoodKitchensNotifier, CreateFoodKitchensState>(
      (ref) => CreateFoodKitchensNotifier(catalogRepository),
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_food_details_state.dart';
import 'create_food_details_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final createFoodDetailsProvider =
    StateNotifierProvider<CreateFoodDetailsNotifier, CreateFoodDetailsState>(
  (ref) => CreateFoodDetailsNotifier(productRepository, settingsRepository),
);

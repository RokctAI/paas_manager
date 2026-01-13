import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_details_state.dart';
import 'edit_food_details_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final editFoodDetailsProvider =
    StateNotifierProvider<EditFoodDetailsNotifier, EditFoodDetailsState>(
  (ref) => EditFoodDetailsNotifier(productRepository, settingsRepository),
);

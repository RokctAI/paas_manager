import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_food_categories_state.dart';
import 'add_food_categories_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final addFoodCategoriesProvider =
    StateNotifierProvider<AddFoodCategoriesNotifier, AddFoodCategoriesState>(
  (ref) => AddFoodCategoriesNotifier(catalogRepository),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'food_categories_state.dart';
import 'food_categories_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final foodCategoriesProvider =
    StateNotifierProvider<FoodCategoriesNotifier, FoodCategoriesState>(
  (ref) => FoodCategoriesNotifier(catalogRepository),
);

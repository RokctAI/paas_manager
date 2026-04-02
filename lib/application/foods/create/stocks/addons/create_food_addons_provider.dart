import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'create_food_addons_notifier.dart';
import 'create_food_addons_state.dart';

final createFoodAddonsProvider =
    StateNotifierProvider<CreateFoodAddonsNotifier, CreateFoodAddonsState>(
      (ref) => CreateFoodAddonsNotifier(productRepository),
    );

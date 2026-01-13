import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'restaurant_state.dart';
import 'restaurant_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, RestaurantState>(
  (ref) => RestaurantNotifier(usersRepository, settingsRepository),
);

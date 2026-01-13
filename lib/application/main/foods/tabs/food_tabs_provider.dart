import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'food_tabs_state.dart';
import 'food_tabs_notifier.dart';

final foodTabsProvider = StateNotifierProvider<FoodTabsNotifier, FoodTabsState>(
  (ref) => FoodTabsNotifier(),
);

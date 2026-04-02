import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

import 'cooking_orders_notifier.dart';
import 'cooking_orders_state.dart';

final cookingOrdersProvider =
    StateNotifierProvider<CookingOrdersNotifier, CookingOrdersState>(
      (ref) => CookingOrdersNotifier(ordersRepository),
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_food_stocks_state.dart';
import 'create_food_stocks_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final createFoodStocksProvider =
    StateNotifierProvider<CreateFoodStocksNotifier, CreateFoodStocksState>(
      (ref) => CreateFoodStocksNotifier(productRepository),
    );

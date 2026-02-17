import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_stocks_state.dart';
import 'edit_food_stocks_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final editFoodStocksProvider = StateNotifierProvider.autoDispose<
    EditFoodStocksNotifier, EditFoodStocksState>(
  (ref) => EditFoodStocksNotifier(productRepository),
);

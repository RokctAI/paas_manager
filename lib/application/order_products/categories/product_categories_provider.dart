import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_categories_state.dart';
import 'product_categories_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final productCategoriesProvider =
    StateNotifierProvider<ProductCategoriesNotifier, ProductCategoriesState>(
  (ref) => ProductCategoriesNotifier(catalogRepository),
);

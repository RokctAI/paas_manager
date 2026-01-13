import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

import 'products_state.dart';
import 'products_notifier.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) => ProductsNotifier(productRepository),
);

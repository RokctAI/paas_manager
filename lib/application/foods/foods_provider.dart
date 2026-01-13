import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'foods_state.dart';
import 'foods_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final foodsProvider = StateNotifierProvider<FoodsNotifier, FoodsState>(
  (ref) => FoodsNotifier(productRepository),
);

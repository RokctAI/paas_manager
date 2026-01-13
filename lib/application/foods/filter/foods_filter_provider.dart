import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'foods_filter_state.dart';
import 'foods_filter_notifier.dart';

final foodsFilterProvider =
    StateNotifierProvider<FoodsFilterNotifier, FoodsFilterState>(
  (ref) => FoodsFilterNotifier(),
);

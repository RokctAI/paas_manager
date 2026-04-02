import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'on_a_way_orders_state.dart';
import 'on_a_way_orders_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final onAWayOrdersProvider =
    StateNotifierProvider<OnAWayOrdersNotifier, OnAWayOrdersState>(
      (ref) => OnAWayOrdersNotifier(ordersRepository),
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ready_orders_state.dart';
import 'ready_orders_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final readyOrdersProvider =
    StateNotifierProvider<ReadyOrdersNotifier, ReadyOrdersState>(
      (ref) => ReadyOrdersNotifier(ordersRepository),
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_details_state.dart';
import 'order_details_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final orderDetailsProvider =
    StateNotifierProvider<OrderDetailsNotifier, OrderDetailsState>(
      (ref) => OrderDetailsNotifier(ordersRepository),
    );

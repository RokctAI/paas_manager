import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_user_state.dart';
import 'order_user_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final orderUserProvider =
    StateNotifierProvider<OrderUserNotifier, OrderUserState>(
  (ref) => OrderUserNotifier(usersRepository),
);

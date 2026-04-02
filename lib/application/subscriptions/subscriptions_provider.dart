import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

import 'subscriptions_state.dart';
import 'subscriptions_notifier.dart';

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>(
      (ref) =>
          SubscriptionNotifier(subscriptionRepository, paymentRepositoryNew),
    );

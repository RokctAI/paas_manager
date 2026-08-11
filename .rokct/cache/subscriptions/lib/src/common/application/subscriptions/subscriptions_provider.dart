import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/interface/subscription_facade.dart';
import '../../domain/interface/subscription_payments_provider.dart';
import 'subscriptions_state.dart';
import 'subscriptions_notifier.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionsFacade>(
  (ref) => throw UnimplementedError(),
);

/// The host app overrides this with an adapter implementing
/// [SubscriptionPaymentsProvider] around its real payments facade (see the
/// commented example in `src/di/subscriptions_di.dart`).
final paymentsRepositoryProvider = Provider<SubscriptionPaymentsProvider>(
  (ref) => throw UnimplementedError(
    'paymentsRepositoryProvider is not overridden',
  ),
);

final walletPriceProvider = Provider<num Function()>(
  (ref) => throw UnimplementedError('walletPriceProvider is not overridden'),
);

final navigateToWebViewProvider =
    Provider<Future<void> Function(BuildContext, String)>(
      (ref) => throw UnimplementedError(
        'navigateToWebViewProvider is not overridden',
      ),
    );

final errorNotificationProvider = Provider<void Function(BuildContext, String)>(
  (ref) =>
      throw UnimplementedError('errorNotificationProvider is not overridden'),
);

final translationProvider = Provider<String Function(String)>(
  (ref) => throw UnimplementedError('translationProvider is not overridden'),
);

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>(
      (ref) => SubscriptionNotifier(
        ref.watch(subscriptionRepositoryProvider),
        ref.watch(paymentsRepositoryProvider),
        getWalletPrice: ref.watch(walletPriceProvider),
        onNavigateToWebView: ref.watch(navigateToWebViewProvider),
        onError: ref.watch(errorNotificationProvider),
        getTranslation: ref.watch(translationProvider),
      ),
    );

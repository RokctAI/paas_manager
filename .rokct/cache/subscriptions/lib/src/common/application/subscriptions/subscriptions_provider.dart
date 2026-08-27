// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


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

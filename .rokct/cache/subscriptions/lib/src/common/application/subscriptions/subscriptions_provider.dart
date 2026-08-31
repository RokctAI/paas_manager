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


import 'package:base_sdk/src/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/interface/subscription_facade.dart';
import '../../domain/interface/subscription_payments_provider.dart';
import '../../infrastructure/repository/demo_subscriptions_repository.dart';
import 'subscriptions_state.dart';
import 'subscriptions_notifier.dart';

// Demo note (--dart-define=IS_DEMO=true): each provider below keeps its
// host-must-override contract in production, but falls back to a local
// demo implementation in demo builds — the same AppConstants.isDemo split
// delivery_sdk's DriverDeliveryDependencies uses. Without this, a demo
// build that composes subscriptions_sdk without the host adapters would
// throw on the /subscriptions screen's first build instead of rendering
// the demo plans. Zero behavior change when IS_DEMO is off.

final subscriptionRepositoryProvider = Provider<SubscriptionsFacade>(
  (ref) => AppConstants.isDemo
      ? DemoSubscriptionsRepository()
      : throw UnimplementedError(
          'subscriptionRepositoryProvider is not overridden',
        ),
);

/// The host app overrides this with an adapter implementing
/// [SubscriptionPaymentsProvider] around its real payments facade (see the
/// commented example in `src/di/subscriptions_di.dart`).
final paymentsRepositoryProvider = Provider<SubscriptionPaymentsProvider>(
  (ref) => AppConstants.isDemo
      ? DemoSubscriptionPaymentsProvider()
      : throw UnimplementedError(
          'paymentsRepositoryProvider is not overridden',
        ),
);

final walletPriceProvider = Provider<num Function()>(
  (ref) => AppConstants.isDemo
      ? () => 0
      : throw UnimplementedError('walletPriceProvider is not overridden'),
);

final navigateToWebViewProvider =
    Provider<Future<void> Function(BuildContext, String)>(
      (ref) => AppConstants.isDemo
          ? (BuildContext context, String url) async {}
          : throw UnimplementedError(
              'navigateToWebViewProvider is not overridden',
            ),
    );

final errorNotificationProvider = Provider<void Function(BuildContext, String)>(
  (ref) => AppConstants.isDemo
      ? (BuildContext context, String message) {}
      : throw UnimplementedError(
          'errorNotificationProvider is not overridden',
        ),
);

final translationProvider = Provider<String Function(String)>(
  (ref) => AppConstants.isDemo
      ? (String key) => key
      : throw UnimplementedError('translationProvider is not overridden'),
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

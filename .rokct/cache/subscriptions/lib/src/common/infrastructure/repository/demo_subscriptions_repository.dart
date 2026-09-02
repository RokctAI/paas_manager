// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:base_sdk/base_sdk.dart';

import '../../domain/interface/subscription_facade.dart';
import '../../domain/interface/subscription_payments_provider.dart';
import '../models/data/subscriptions_data.dart';
import '../models/response/subscriptions_response.dart';
import '../models/response/transactions_response.dart';

/// Demo-only [SubscriptionsFacade] (`--dart-define=IS_DEMO=true`): serves
/// two fictional plans offline so the /subscriptions screen is never an
/// empty grid in demo builds — the same `AppConstants.isDemo` split
/// delivery_sdk's `DriverDeliveryDependencies` and lms_sdk's
/// DemoLmsRepository use. Wired by the demo fallbacks in
/// `subscriptions_provider.dart` (the real backend needs host-app
/// overrides that a demo build deliberately runs without); zero behavior
/// change when IS_DEMO is off. Never used in production; purchases are
/// acknowledged locally and nothing leaves the device.
class DemoSubscriptionsRepository implements SubscriptionsFacade {
  static final List<SubscriptionData> _plans = [
    SubscriptionData(
      id: 1,
      ref: 'PLAN-STARTER',
      type: 'monthly',
      price: 299,
      month: 1,
      active: true,
      title: 'Starter',
      content: 'Everything a new store needs to sell online.',
      productLimit: 100,
      orderLimit: 500,
      withReport: false,
    ),
    SubscriptionData(
      id: 2,
      ref: 'PLAN-GROWTH',
      type: 'yearly',
      price: 2999,
      month: 12,
      active: true,
      title: 'Growth',
      content: 'Unlimited catalogue, priority support and sales reports.',
      productLimit: 10000,
      orderLimit: 100000,
      withReport: true,
    ),
  ];

  @override
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({
    required int page,
    String? locale,
  }) async =>
      ApiResult.success(
        data: SubscriptionResponse(
          status: true,
          data: page > 1 ? <SubscriptionData>[] : List.of(_plans),
        ),
      );

  @override
  Future<ApiResult> purchaseSubscription({
    required int id,
    required int paymentId,
    String? ref,
    String? beneficiaryUserId,
  }) async =>
      const ApiResult.success(data: null);

  @override
  Future<ApiResult<SubscriptionTransactionsResponse>> createTransaction({
    required Object id,
    required int paymentId,
    String? beneficiaryUserId,
  }) async =>
      ApiResult.success(data: SubscriptionTransactionsResponse());
}

/// Demo-only [SubscriptionPaymentsProvider] twin: one wallet method, so the
/// payment sheet renders without the host's payments adapter.
class DemoSubscriptionPaymentsProvider implements SubscriptionPaymentsProvider {
  @override
  Future<ApiResult<List<SubscriptionPaymentMethod>>> getPaymentMethods() async =>
      const ApiResult.success(
        data: [SubscriptionPaymentMethod(id: 1, tag: 'wallet')],
      );

  @override
  Future<ApiResult<String>> paymentSubscriptionWebView({
    required String name,
    required String subscriptionId,
  }) async =>
      const ApiResult.success(data: '');
}

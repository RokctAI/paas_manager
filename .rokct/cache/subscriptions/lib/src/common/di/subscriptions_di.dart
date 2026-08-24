// Copyright (c) 2026 RokctAI
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


import 'package:get_it/get_it.dart';

class SubscriptionsSdkDependencies {
  static void register(GetIt getIt) {
    // SubscriptionsRepository needs the host app's Dio client and AppDatabase,
    // which the host wires in its own composition code (see the dependency
    // manager template in core_sdk). Nothing to register SDK-side.
  }
}

// ---------------------------------------------------------------------------
// HOST-APP ADAPTER EXAMPLE (documentation only — not compiled wiring)
//
// subscriptions_sdk owns SubscriptionPaymentsProvider and never imports
// payments_sdk or wallet_sdk. The HOST APP — the only place where these SDKs
// are installed together — implements the adapter and overrides the riverpod
// provider. There is no composed host app in this workspace yet
// (supacharge/ is an empty shell), so this adapter is documented here rather
// than wired anywhere real.
//
//   import 'package:subscriptions_sdk/subscriptions_sdk.dart';
//   import 'package:payments_sdk/payments_sdk.dart';
//
//   class PaymentsAdapter implements SubscriptionPaymentsProvider {
//     final PaymentsFacade _payments;
//     PaymentsAdapter(this._payments);
//
//     @override
//     Future<ApiResult<List<SubscriptionPaymentMethod>>>
//         getPaymentMethods() async {
//       final res = await _payments.getPayments();
//       return res.when(
//         success: (data) => ApiResult.success(
//           data: (data.data ?? [])
//               .map((p) => SubscriptionPaymentMethod(id: p.id, tag: p.tag))
//               .toList(),
//         ),
//         failure: (error, statusCode) =>
//             ApiResult.failure(error: error, statusCode: statusCode),
//       );
//     }
//
//     @override
//     Future<ApiResult<String>> paymentSubscriptionWebView({
//       required String name,
//       required String subscriptionId,
//     }) =>
//         _payments.paymentSubscriptionWebView(
//           name: name,
//           subscriptionId: subscriptionId,
//         );
//   }
//
//   // in the host's ProviderScope overrides:
//   // paymentsRepositoryProvider.overrideWithValue(
//   //   PaymentsAdapter(getIt.get<PaymentsFacade>())),
//   //
//   // wallet_sdk is already decoupled the same way: the wallet balance is
//   // injected as a plain callback, e.g.
//   // walletPriceProvider.overrideWithValue(
//   //   () => LocalStorage.getUser()?.wallet?.price ?? 0),
// ---------------------------------------------------------------------------

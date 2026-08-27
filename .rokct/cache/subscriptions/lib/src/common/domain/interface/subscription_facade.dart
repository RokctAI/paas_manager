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


import 'package:base_sdk/base_sdk.dart';
import '../../infrastructure/models/response/subscriptions_response.dart';
import '../../infrastructure/models/response/transactions_response.dart';

abstract class SubscriptionsFacade {
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({
    required int page,
    String? locale,
  });

  /// [ref] is the plan's Frappe document name on the composed backend
  /// (plan rows are hash-named, so the legacy numeric [id] is null for
  /// them); when present it identifies the plan on the wire, with [id] as
  /// the fallback for stored rows that still carry one.
  ///
  /// [beneficiaryUserId] enables delegated billing: purchase this
  /// subscription FOR another account (e.g. an accountability partner
  /// paying for a linked student — the subscription stays the student's,
  /// only who gets charged changes). Null (the default, and every
  /// pre-existing call) means the caller purchases for themselves. The
  /// backend authorizes the delegation — the client only carries the fact.
  Future<ApiResult> purchaseSubscription({
    required int id,
    required int paymentId,
    String? ref,
    String? beneficiaryUserId,
  });

  /// [id] is whatever identifier [purchaseSubscription] returned — the
  /// legacy backend used an int, the composed backend a Frappe document
  /// name (String) — so it is deliberately untyped.
  Future<ApiResult<SubscriptionTransactionsResponse>> createTransaction({
    required Object id,
    required int paymentId,
    String? beneficiaryUserId,
  });
}

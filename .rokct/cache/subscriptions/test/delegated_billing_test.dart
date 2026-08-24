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


// compliance-ignore-file: flutter-http-timeout (test double: Dio uses a scripted in-memory adapter, no real network)

import 'dart:convert';
import 'dart:typed_data';

import 'package:base_sdk/base_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subscriptions_sdk/subscriptions_sdk.dart';

/// P3.1 partner-as-payer, subscriptions_sdk side. The chosen model is
/// DELEGATED BILLING: a subscription stays the student's own object; only
/// who gets charged for it can be delegated (SubscriptionData.payer +
/// the beneficiary_user_id purchase param). Deliberately NOT a family-plan
/// redesign — nothing here makes one subscription cover several students.
void main() {
  group('SubscriptionData.payer (delegated billing)', () {
    test('parses from json; absent means the subscriber pays', () {
      final delegated = SubscriptionData.fromJson(
          {'id': 1, 'price': 100, 'payer': 'parent@example.com'});
      expect(delegated.payer, 'parent@example.com');

      final selfPaid = SubscriptionData.fromJson({'id': 2, 'price': 100});
      expect(selfPaid.payer, isNull);
    });

    test('round-trips through toJson and survives copyWith', () {
      final sub = SubscriptionData(
          id: 1, price: 100, payer: 'parent@example.com');
      expect(sub.toJson()['payer'], 'parent@example.com');
      expect(sub.copyWith(price: 80).payer, 'parent@example.com');
    });
  });

  group('purchase wire shape', () {
    test('beneficiary_user_id sent only when purchasing for someone else',
        () async {
      final adapter = _RecordingAdapter();
      final dio = Dio()..httpClientAdapter = adapter;
      final repo = SubscriptionsRepository(dio, AppDatabase());

      // A partner purchasing FOR a linked student. Purchases ride the
      // universal platform gateway: the method's own kwargs sit in
      // `payload` under the prefix-free `cmd`.
      await repo.purchaseSubscription(
          id: 7, paymentId: 3, beneficiaryUserId: 'student@example.com');
      expect(adapter.lastPath, '/api/v1/method/rokct.platform.api');
      expect(adapter.lastBody, {
        'cmd': 'api.subscription.subscribe_my_shop',
        'payload': {
          'subscription_id': 7,
          'payment_sys_id': 3,
          'beneficiary_user_id': 'student@example.com',
        },
      });

      // A plain self-purchase: the pre-P3.1 wire shape plus the composed
      // endpoint's own subscription_id argument.
      await repo.purchaseSubscription(id: 7, paymentId: 3);
      expect(adapter.lastBody?['payload'],
          {'subscription_id': 7, 'payment_sys_id': 3});

      // Frappe plan rows are hash-named: ref wins over the legacy id.
      await repo.purchaseSubscription(id: 0, ref: 'a1b2c3d4e5', paymentId: 3);
      expect(adapter.lastBody?['payload'], {
        'subscription_id': 'a1b2c3d4e5',
        'payment_sys_id': 3,
      });

      await repo.createTransaction(
          id: 7, paymentId: 3, beneficiaryUserId: 'student@example.com');
      expect(adapter.lastBody?['beneficiary_user_id'], 'student@example.com');
    });
  });
}

/// Captures the request body and answers with a minimal success payload —
/// enough for the repository's response mapping to not throw.
class _RecordingAdapter implements HttpClientAdapter {
  Map<String, dynamic>? lastBody;
  String? lastPath;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final data = options.data;
    lastBody = data is Map<String, dynamic> ? data : null;
    lastPath = options.path;
    return ResponseBody.fromString(
      jsonEncode({
        'data': {'id': 1}
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

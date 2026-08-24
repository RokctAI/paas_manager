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


import 'package:flutter_test/flutter_test.dart';
import 'package:subscriptions_sdk/subscriptions_sdk.dart';

/// Holiday Programme plan flags (business doc §2, holiday brief item 2).
/// The three-way access model is PER-PLAN FLAGS, not a tier hierarchy — no
/// tier structure exists anywhere, so plans carry their own entitlements.
void main() {
  group('SubscriptionData holiday flags', () {
    test('parses all three access shapes plus the catch-up entitlement', () {
      final bundled = SubscriptionData.fromJson({
        'id': 1,
        'bundles_holiday': 1,
        'personalized_catch_up': 'true',
      });
      expect(bundled.bundlesHoliday, isTrue);
      expect(bundled.personalizedCatchUp, isTrue);
      expect(bundled.holidayStandalone, isNull);

      final addOn = SubscriptionData.fromJson({
        'id': 2,
        'bundles_holiday': 0,
        'holiday_add_on_price': '149',
      });
      expect(addOn.bundlesHoliday, isFalse);
      expect(addOn.holidayAddOnPrice, 149);

      final standalone = SubscriptionData.fromJson({
        'id': 3,
        'holiday_standalone': true,
      });
      expect(standalone.holidayStandalone, isTrue);
    });

    test('absent fields stay null — every pre-existing plan row unchanged',
        () {
      final legacy = SubscriptionData.fromJson({'id': 1, 'price': 299});
      expect(legacy.bundlesHoliday, isNull);
      expect(legacy.holidayAddOnPrice, isNull);
      expect(legacy.holidayStandalone, isNull);
      expect(legacy.personalizedCatchUp, isNull);
    });

    test('round-trips through toJson and survives copyWith', () {
      final plan = SubscriptionData(
        id: 1,
        bundlesHoliday: true,
        holidayAddOnPrice: 149,
        holidayStandalone: false,
        personalizedCatchUp: true,
      );
      final json = plan.toJson();
      expect(json['bundles_holiday'], isTrue);
      expect(json['holiday_add_on_price'], 149);
      expect(json['personalized_catch_up'], isTrue);

      final copied = plan.copyWith(price: 249);
      expect(copied.bundlesHoliday, isTrue);
      expect(copied.holidayAddOnPrice, 149);
      expect(copied.personalizedCatchUp, isTrue);
    });

    test('malformed add-on price resolves to null rather than throwing', () {
      final plan = SubscriptionData.fromJson(
          {'id': 1, 'holiday_add_on_price': 'not-a-number'});
      expect(plan.holidayAddOnPrice, isNull);
    });
  });
}

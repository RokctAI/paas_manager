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


import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscriptions_sdk/src/common/application/subscriptions/subscriptions_provider.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:${package}/presentation/theme/theme.dart';

class PaymentDialog extends ConsumerWidget {
  const PaymentDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(subscriptionProvider);
    final notifier = ref.read(subscriptionProvider.notifier);
    final isLrt = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLrt ? TextDirection.ltr : TextDirection.rtl,
      child: SizedBox(
        height: (state.payments?.length ?? 0) > 8
            ? MediaQuery.sizeOf(context).height / 1.6
            : MediaQuery.sizeOf(context).height / 2,
        width: MediaQuery.sizeOf(context).width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppHelpers.getTranslation(TrKeys.selectPayment)),
            // @subscription-payments-list
            
            // @subscription-payments-action
          ],
        ),
      ),
    );
  }
}



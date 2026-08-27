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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:subscriptions_sdk/src/common/infrastructure/services/shop_subscription_store.dart';
import 'package:base_sdk/src/services/date_service.dart';
import 'package:${package}/presentation/theme/theme.dart';

class HaveSubscription extends StatelessWidget {
  const HaveSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    final subscription = ShopSubscriptionStore.shopSubscription()?.subscription;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppStyle.white,
      ),
      padding: REdgeInsets.all(16),
      margin: REdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.youHaveSubscription),
            style: AppStyle.interNormal(size: 14),
          ),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription?.content ?? "",
                      style: AppStyle.interNormal(size: 14),
                    ),
                    2.verticalSpace,
                    Text(
                      AppHelpers.numberFormat(number: subscription?.price),
                      style: AppStyle.interSemi(size: 16),
                    ),
                    2.verticalSpace,
                    if (subscription?.withReport ?? false)
                      Text(
                        "+ ${AppHelpers.getTranslation(TrKeys.withReport)}",
                        style: AppStyle.interRegular(
                          size: 12,
                          color: AppStyle.green,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${subscription?.month ?? 0} ${TrKeys.month}",
                      style: AppStyle.interRegular(size: 14),
                    ),
                    2.verticalSpace,
                    Text(
                      "${subscription?.productLimit ?? 0} ${AppHelpers.getTranslation(TrKeys.product).toLowerCase()}",
                      style: AppStyle.interRegular(size: 14),
                    ),
                    2.verticalSpace,
                    Text(
                      "${subscription?.orderLimit ?? 0} ${AppHelpers.getTranslation(TrKeys.order).toLowerCase()}",
                      style: AppStyle.interRegular(size: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              DateService.dateFormatForNotification(
                ShopSubscriptionStore.shopSubscription()?.createdAt,
              ),
              style: AppStyle.interNormal(size: 12, color: AppStyle.text),
            ),
          ),
        ],
      ),
    );
  }
}


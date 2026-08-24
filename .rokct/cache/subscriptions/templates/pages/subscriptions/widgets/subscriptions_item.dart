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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:subscriptions_sdk/subscriptions_sdk.dart';
import 'package:base_sdk/src/presentation/components/buttons/second_button.dart';
import 'package:base_sdk/src/presentation/components/buttons/circle_button.dart';
import 'package:${package}/presentation/theme/theme.dart';

class SubscriptionsItem extends StatelessWidget {
  final SubscriptionData subscription;
  final VoidCallback purchase;

  const SubscriptionsItem({
    super.key,
    required this.subscription,
    required this.purchase,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppStyle.white,
          ),
          padding: REdgeInsets.symmetric(vertical: 32),
          margin: REdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                subscription.title ?? "",
                style: AppStyle.interNormal(size: 14),
              ),
              Text(
                AppHelpers.numberFormat(number: subscription.price),
                style: AppStyle.interSemi(size: 18),
              ),
              12.verticalSpace,
              Text(
                "${subscription.month ?? 0} ${TrKeys.month}",
                style: AppStyle.interNormal(size: 14),
              ),
              Text(
                "${AppHelpers.getTranslation(TrKeys.product)}: ${subscription.productLimit ?? 0}",
                style: AppStyle.interNormal(size: 14),
              ),
              Text(
                "${AppHelpers.getTranslation(TrKeys.order)}: ${subscription.orderLimit ?? 0}",
                style: AppStyle.interNormal(size: 14),
              ),
              if (subscription.withReport ?? false)
                Text(
                  "+ ${AppHelpers.getTranslation(TrKeys.withReport)}",
                  style: AppStyle.interRegular(size: 12, color: AppStyle.green),
                ),
              16.verticalSpace,
              SecondButton(
                title: AppHelpers.getTranslation(TrKeys.purchase),
                bgColor: AppStyle.primary,
                titleColor: AppStyle.white,
                onTap: purchase,
              ),
            ],
          ),
        ),
        Positioned(
          right: 8.r,
          top: 8.r,
          child: CircleButton(
            size: 30,
            iconSize: 16,
            icon: Remix.question_mark,
            onTap: () {
              AppHelpers.openDialog(
                context: context,
                title:
                    "${AppHelpers.getTranslation(TrKeys.subscriptionIncludes)}, "
                    "\n${AppHelpers.getTranslation(TrKeys.productCount)}: ${subscription.productLimit ?? 0}, "
                    "\n${AppHelpers.getTranslation(TrKeys.orderCount)}: ${subscription.orderLimit ?? 0}, "
                    "\n${AppHelpers.getTranslation(TrKeys.duration)}: ${subscription.month} ${AppHelpers.getTranslation(TrKeys.month)}",
              );
            },
          ),
        ),
      ],
    );
  }
}


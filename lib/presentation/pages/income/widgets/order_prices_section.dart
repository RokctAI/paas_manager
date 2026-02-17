import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../more_orders.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class OrderPricesSection extends StatelessWidget {
  final DateTime? endTime;
  final DateTime? startTime;

  const OrderPricesSection({super.key, this.endTime, this.startTime});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(statisticsProvider);
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppStyle.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.orderPrice),
                    style: AppStyle.interNormal(
                      size: 14,
                      color: AppStyle.blackColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    AppHelpers.numberFormat(
                      state.countData?.lastOrderTotalPrice ?? 0,
                    ),
                    style: AppStyle.interSemi(
                      size: 32,
                      color: AppStyle.blackColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  4.verticalSpace,
                  RichText(
                    text: TextSpan(
                      text: AppHelpers.getTranslation(TrKeys.lastIncome),
                      style: AppStyle.interNormal(
                        size: 12,
                        color: AppStyle.blackColor,
                        letterSpacing: -0.3,
                      ),
                      children: [
                        TextSpan(
                          text: AppHelpers.numberFormat(
                            state.countData?.lastOrderIncome ?? 0,
                          ),
                          style: AppStyle.interSemi(
                            size: 12,
                            color: AppStyle.blackColor,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (MediaQuery.sizeOf(context).width - 40) / 2,
                  decoration: BoxDecoration(
                    color: AppStyle.blackColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.restaurantRevenue),
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        AppHelpers.numberFormat(
                          state.countData?.totalPrice ?? 0,
                        ),
                        style: AppStyle.interSemi(
                          size: 20,
                          color: AppStyle.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.sizeOf(context).width - 40) / 2,
                  decoration: BoxDecoration(
                    color: AppStyle.blackColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.fMRevenue),
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        AppHelpers.numberFormat(
                          state.countData?.fmTotalPrice ?? 0,
                        ),
                        style: AppStyle.interSemi(
                          size: 20,
                          color: AppStyle.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () {
                AppHelpers.showCustomModalBottomSheet(
                  paddingTop: MediaQuery.paddingOf(context).top + 200.h,
                  context: context,
                  radius: 12,
                  modal: MoreOrders(endTime: endTime, startTime: startTime),
                  isDarkMode: true,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppStyle.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 2,
                      color: AppStyle.blackColor.withOpacity(0.04),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.moreAboutOrders),
                      style: AppStyle.interNormal(
                        size: 14,
                        color: AppStyle.blackColor,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Icon(FlutterRemix.arrow_right_s_line),
                  ],
                ),
              ),
            ),
            32.verticalSpace,
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/services/app_helpers.dart';
import 'package:venderfoodyman/infrastructure/services/date_service.dart';
import 'package:venderfoodyman/infrastructure/services/local_storage.dart';
import 'package:venderfoodyman/infrastructure/services/tr_keys.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class HaveSubscription extends StatelessWidget {
  const HaveSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    final subscription = LocalStorage.getShop()?.subscription?.subscription;
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
                      AppHelpers.numberFormat(subscription?.price),
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
                LocalStorage.getShop()?.subscription?.createdAt,
              ),
              style: AppStyle.interNormal(size: 12, color: AppStyle.textColor),
            ),
          ),
        ],
      ),
    );
  }
}

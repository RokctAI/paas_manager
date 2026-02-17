import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;
  final int spacing;

  const FoodItem({
    super.key,
    required this.product,
    required this.onTap,
    this.spacing = 1,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.stocks == null || product.stocks!.isEmpty;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: product.status == 'pending' ? AppStyle.pending : AppStyle.white,
        margin: EdgeInsets.only(bottom: spacing.r),
        padding: REdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.translation?.title}',
                        style: AppStyle.interNormal(
                          size: 14,
                          color: AppStyle.blackColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        '${product.translation?.description}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        isOutOfStock
                            ? AppHelpers.getTranslation(TrKeys.outOfStock)
                            : AppHelpers.numberFormat(
                                product.stocks?.first.price ?? 0,
                              ),
                        style: AppStyle.interSemi(
                          size: 14,
                          color: isOutOfStock
                              ? AppStyle.red
                              : AppStyle.blackColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                CommonImage(
                  width: 110,
                  height: 106,
                  url: product.img,
                  radius: 0,
                  errorRadius: 0,
                  fit: BoxFit.fitWidth,
                ),
                16.horizontalSpace,
              ],
            ),
            20.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1.r,
                height: 1.r,
                color: AppStyle.tabBarBorderColor,
              ),
            ),
            14.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonsBouncingEffect(
                    child: Row(
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.parameters),
                          style: AppStyle.interNormal(size: 13),
                        ),
                        6.horizontalSpace,
                        Icon(
                          FlutterRemix.arrow_down_s_line,
                          size: 18.r,
                          color: AppStyle.blackColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30.r,
                    alignment: Alignment.center,
                    padding: REdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: product.status == 'pending'
                          ? AppStyle.pendingDark
                          : AppStyle.primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          product.status == 'pending'
                              ? FlutterRemix.time_fill
                              : FlutterRemix.check_double_line,
                          size: 20.r,
                          color: AppStyle.white,
                        ),
                        6.horizontalSpace,
                        Text(
                          product.status == 'pending'
                              ? AppHelpers.getTranslation(TrKeys.pending)
                              : AppHelpers.getTranslation(TrKeys.published),
                          style: AppStyle.interNormal(
                            size: 14,
                            color: AppStyle.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}

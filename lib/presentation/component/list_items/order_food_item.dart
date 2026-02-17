import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class OrderFoodItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;
  final int spacing;

  const OrderFoodItem({
    super.key,
    required this.product,
    required this.onTap,
    this.spacing = 1,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.stocks == null || product.stocks!.isEmpty;
    final bool hasDiscount = isOutOfStock
        ? false
        : (product.stocks!.first.discount != null &&
              (product.stocks!.first.discount ?? 0) > 0);
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: AppStyle.white,
          margin: EdgeInsets.only(bottom: spacing.r),
          padding: REdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  if ((product.cartCount ?? 0) > 0)
                    Container(
                      width: 50.r,
                      height: 78.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                        color: AppStyle.primary,
                      ),
                      child: Text(
                        '${(product.cartCount ?? 1) * (product.interval ?? 1)} ${product.unit?.translation?.title ?? ""}',
                        style: AppStyle.interSemi(size: 15),
                      ),
                    ),
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
                        isOutOfStock
                            ? Text(
                                AppHelpers.getTranslation(TrKeys.outOfStock),
                                style: AppStyle.interSemi(
                                  size: 11,
                                  color: AppStyle.red,
                                  letterSpacing: -0.3,
                                ),
                              )
                            : (hasDiscount
                                  ? Row(
                                      children: [
                                        Text(
                                          AppHelpers.numberFormat(
                                            (product.stocks?.first.price ?? 0) +
                                                (product.stocks?.first.tax ??
                                                    0),
                                          ),
                                          style: AppStyle.interSemi(
                                            size: 14,
                                            color: AppStyle.blackColor,
                                            letterSpacing: -0.3,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        10.horizontalSpace,
                                        Container(
                                          padding: REdgeInsets.only(
                                            top: 4,
                                            bottom: 4,
                                            left: 4,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              30.r,
                                            ),
                                            color: AppStyle.bgColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 20.r,
                                                height: 20.r,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppStyle.red,
                                                ),
                                                child: Icon(
                                                  FlutterRemix.percent_fill,
                                                  size: 12.r,
                                                  color: AppStyle.white,
                                                ),
                                              ),
                                              8.horizontalSpace,
                                              Text(
                                                AppHelpers.numberFormat(
                                                  product
                                                          .stocks
                                                          ?.first
                                                          .totalPrice ??
                                                      0,
                                                ),
                                                style: AppStyle.interSemi(
                                                  size: 14,
                                                  color: AppStyle.blackColor,
                                                  letterSpacing: -0.3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      AppHelpers.numberFormat(
                                        product.stocks?.first.totalPrice ?? 0,
                                      ),
                                      style: AppStyle.interSemi(
                                        size: 14,
                                        color: AppStyle.blackColor,
                                        letterSpacing: -0.3,
                                      ),
                                    )),
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
              8.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

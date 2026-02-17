import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class PriceInformation extends StatelessWidget {
  final OrderData? order;
  final bool? isHistoryOrder;

  const PriceInformation({super.key, required this.order, this.isHistoryOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: REdgeInsets.only(top: 8),
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: ExpansionTile(
        initiallyExpanded: isHistoryOrder ?? false,
        tilePadding: EdgeInsets.zero,
        title: Text(AppHelpers.getTranslation(TrKeys.priceInformation)),
        childrenPadding: REdgeInsets.only(bottom: 18),
        textColor: AppStyle.black,
        iconColor: AppStyle.black,
        children: [
          _priceItem(title: TrKeys.subtotal, price: order?.originPrice),
          _priceItem(title: TrKeys.tax, price: order?.tax),
          _priceItem(title: TrKeys.serviceFee, price: order?.serviceFee),
          _priceItem(title: TrKeys.deliveryFee, price: order?.deliveryFee),
          _priceItem(title: TrKeys.tips, price: order?.tips),
          _priceItem(
            isDiscount: true,
            title: TrKeys.discount,
            price: order?.totalDiscount,
          ),
          _priceItem(
            isDiscount: true,
            title: TrKeys.coupon,
            price: order?.couponPrice,
          ),
          _priceItem(
            isTotal: true,
            title: TrKeys.total,
            price: order?.totalPrice,
          ),
        ],
      ),
    );
  }

  RenderObjectWidget _priceItem({
    required String title,
    required num? price,
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return (price ?? 0) == 0
        ? const SizedBox.shrink()
        : Column(
            children: [
              2.verticalSpace,
              Divider(color: AppStyle.black.withOpacity(0.4)),
              2.verticalSpace,
              Row(
                children: [
                  Text(
                    AppHelpers.getTranslation(title),
                    style: isTotal
                        ? AppStyle.interSemi(size: 16, letterSpacing: -0.3)
                        : AppStyle.interNormal(
                            size: 14,
                            letterSpacing: -0.3,
                            color: isDiscount ? AppStyle.red : AppStyle.black,
                          ),
                  ),
                  8.horizontalSpace,
                  if (isTotal && order?.transaction?.paymentSystem?.tag != null)
                    Text(
                      "(${AppHelpers.getTranslation(order?.transaction?.paymentSystem?.tag ?? TrKeys.noTransaction)})",
                      style: AppStyle.interNormal(
                        size: 12,
                        color: AppStyle.black,
                      ),
                    ),
                  const Spacer(),
                  Text(
                    (isDiscount ? '-' : '') + AppHelpers.numberFormat(price),
                    style: isTotal
                        ? AppStyle.interSemi(size: 16, letterSpacing: -0.3)
                        : AppStyle.interNormal(
                            size: 14,
                            letterSpacing: -0.3,
                            color: isDiscount ? AppStyle.red : AppStyle.black,
                          ),
                  ),
                ],
              ),
            ],
          );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../loading/text_loading.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class OrderProductItem extends StatelessWidget {
  final CurrencyData? currencyData;
  final OrderDetail orderDetail;
  final bool isLast;
  final bool isLoading;
  final Function() onToggle;

  const OrderProductItem({
    super.key,
    required this.orderDetail,
    required this.isLoading,
    required this.onToggle,
    this.isLast = false,
    required this.currencyData,
  });

  @override
  Widget build(BuildContext context) {
    num totalPrice = 0;
    totalPrice += (orderDetail.totalPrice ?? 0);
    orderDetail.addons?.forEach((element) {
      totalPrice += (element.totalPrice ?? 0);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? const TextLoading(width: 200)
                      : SizedBox(
                          width: MediaQuery.sizeOf(context).width - 180.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    orderDetail
                                            .stock
                                            ?.product
                                            ?.translation
                                            ?.title ??
                                        AppHelpers.getTranslation(
                                          TrKeys.noName,
                                        ),
                                    style: AppStyle.interSemi(
                                      size: 14,
                                      color: AppStyle.black,
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  for (
                                    int i = 0;
                                    i <
                                        (orderDetail.stock?.extras?.length ??
                                            0);
                                    i++
                                  )
                                    Padding(
                                      padding: REdgeInsets.only(right: 2),
                                      child: Text(
                                        "(${orderDetail.stock?.extras?[i].value})",
                                        style: AppStyle.interNormal(
                                          size: 12,
                                          color: AppStyle.black,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              for (
                                int i = 0;
                                i < (orderDetail.addons?.length ?? 0);
                                i++
                              )
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text(
                                    "${orderDetail.addons?[i].stock?.product?.translation?.title} x ${orderDetail.addons?[i].quantity ?? 0}  ${AppHelpers.numberFormat(orderDetail.addons?[i].stock?.totalPrice ?? 0, symbol: currencyData?.symbol)}",
                                    style: AppStyle.interSemi(
                                      size: 12,
                                      color: AppStyle.black,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                  4.verticalSpace,
                  isLoading
                      ? const TextLoading(width: 150)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppHelpers.getTranslation(TrKeys.amount)} — ${(orderDetail.quantity ?? 1) * (orderDetail.stock?.product?.interval ?? 1)} ${orderDetail.stock?.product?.unit?.translation?.title ?? ""} x ${AppHelpers.numberFormat(orderDetail.stock?.totalPrice ?? 0, symbol: currencyData?.symbol)}',
                              style: AppStyle.interRegular(
                                size: 14,
                                color: AppStyle.black,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            if (orderDetail.shopBonus ?? false)
              Text(
                AppHelpers.getTranslation(TrKeys.shopBonus),
                style: AppStyle.interSemi(size: 14, color: AppStyle.blue),
              )
            else if (orderDetail.bonus ?? false)
              Text(
                AppHelpers.getTranslation(TrKeys.bonus),
                style: AppStyle.interSemi(size: 14, color: AppStyle.blue),
              )
            else
              Text(
                AppHelpers.numberFormat(
                  totalPrice,
                  symbol: currencyData?.symbol,
                ),
                style: AppStyle.interSemi(size: 14, color: AppStyle.black),
              ),
          ],
        ),
        if (!isLast)
          Divider(thickness: 1.r, height: 1.r, color: AppStyle.greyColor),
        if (orderDetail.note != '') 5.verticalSpace,
        if (orderDetail.note != '')
          Text(
            "${AppHelpers.getTranslation(TrKeys.note)}: ${orderDetail.note}",
            style: AppStyle.interRegular(size: 14, color: AppStyle.black),
          ),
      ],
    );
  }
}

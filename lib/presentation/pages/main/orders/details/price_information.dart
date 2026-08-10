// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/data/order_data.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class PriceInformation extends StatelessWidget {
  final OrderData? order;
  final bool? isHistoryOrder;

  const PriceInformation({
    super.key,
    required this.order,
    this.isHistoryOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: REdgeInsets.only(top: 8),
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: ExpansionTile(
        initiallyExpanded: isHistoryOrder ?? false,
        tilePadding: EdgeInsets.zero,
        title: Text(AppHelpers.getTranslation(TrKeys.priceInformation)),
        childrenPadding: REdgeInsets.only(bottom: 18),
        textColor: Style.black,
        iconColor: Style.black,
        children: [
          _priceItem(
            title: TrKeys.subtotal,
            price: order?.originPrice,
          ),
          _priceItem(
            title: TrKeys.tax,
            price: order?.tax,
          ),
          _priceItem(
            title: TrKeys.serviceFee,
            price: order?.serviceFee,
          ),
          _priceItem(
            title: TrKeys.deliveryFee,
            price: order?.deliveryFee,
          ),
          _priceItem(
            title: TrKeys.tips,
            price: order?.tips,
          ),
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

  _priceItem({
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
              Divider(color: Style.black.withOpacity(0.4)),
              2.verticalSpace,
              Row(
                children: [
                  Text(
                    AppHelpers.getTranslation(title),
                    style: isTotal
                        ? Style.interSemi(size: 16.sp, letterSpacing: -0.3)
                        : Style.interNormal(
                            size: 14.sp,
                            letterSpacing: -0.3,
                            color: isDiscount ? Style.red : Style.black,
                          ),
                  ),
                  8.horizontalSpace,
                  if(isTotal && order?.transaction?.paymentSystem?.tag != null)
                  Text(
                    "(${AppHelpers.getTranslation(order?.transaction?.paymentSystem?.tag ?? TrKeys.noTransaction)})",
                    style: Style.interNormal(
                      size: 12,
                      color: Style.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    (isDiscount ? '-' : '') + AppHelpers.numberFormat(price),
                    style: isTotal
                        ? Style.interSemi(size: 16.sp, letterSpacing: -0.3)
                        : Style.interNormal(
                            size: 14.sp,
                            letterSpacing: -0.3,
                            color: isDiscount ? Style.red : Style.black,
                          ),
                  )
                ],
              ),
            ],
          );
  }
}

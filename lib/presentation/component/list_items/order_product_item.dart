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

import 'package:manager/presentation/styles/style.dart';
import '../loading/text_loading.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

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
                              Text(
                                orderDetail
                                        .stock?.product?.translation?.title ??
                                    AppHelpers.getTranslation(TrKeys.noName),
                                style: Style.interSemi(
                                    size: 14.sp, color: Style.black),
                              ),
                              for (int i = 0;
                                  i < (orderDetail.addons?.length ?? 0);
                                  i++)
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text(
                                    "${orderDetail.addons?[i].stock?.product?.translation?.title} x ${orderDetail.addons?[i].quantity ?? 0}  ${AppHelpers.numberFormat(orderDetail.addons?[i].stock?.totalPrice ?? 0, symbol: currencyData?.symbol)}",
                                    style: Style.interSemi(
                                        size: 12.sp, color: Style.black),
                                  ),
                                )
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
                              style: Style.interRegular(
                                size: 14.sp,
                                color: Style.black,
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
                style: Style.interSemi(size: 14.sp, color: Style.blue),
              )
            else if (orderDetail.bonus ?? false)
              Text(
                AppHelpers.getTranslation(TrKeys.bonus),
                style: Style.interSemi(size: 14.sp, color: Style.blue),
              )
            else
              Text(
                AppHelpers.numberFormat(totalPrice,
                    symbol: currencyData?.symbol),
                style: Style.interSemi(size: 14.sp, color: Style.black),
              ),
          ],
        ),
        if (!isLast)
          Divider(thickness: 1.r, height: 1.r, color: Style.greyColor),
        if (orderDetail.note != '') 5.verticalSpace,
        if (orderDetail.note != '')
          Text(
            "${AppHelpers.getTranslation(TrKeys.note)}: ${orderDetail.note}",
            style: Style.interRegular(
              size: 14.sp,
              color: Style.black,
            ),
          )
      ],
    );
  }
}

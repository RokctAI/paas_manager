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
import '../helper/common_image.dart';
import '../buttons/buttons_bouncing_effect.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

class OrderItem extends StatelessWidget {
  final OrderData order;
  final bool isHistoryOrder;
  final VoidCallback onTap;

  const OrderItem({
    super.key,
    required this.order,
    required this.onTap,
    this.isHistoryOrder = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 134.h,
          width: double.infinity,
          margin: REdgeInsets.only(bottom: 10),
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CommonImage(
                          url: order.user?.img,
                          radius: 25,
                          width: 50,
                          height: 50,
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.user == null
                                    ? AppHelpers.getTranslation(
                                        TrKeys.deletedUser)
                                    : '${order.user?.firstname ?? AppHelpers.getTranslation(TrKeys.noName)} ${order.user?.lastname ?? ''}',
                                style: Style.interRegular(
                                  size: 14.sp,
                                  color: Style.blackColor,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                AppHelpers.getTranslation(
                                    order.deliveryType ?? ""),
                                style: Style.interNormal(
                                  size: 12.sp,
                                  color: Style.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (AppHelpers.getOrderStatus(order.status) ==
                      OrderStatus.newOrder)
                    Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.red,
                      ),
                    ),
                  if (isHistoryOrder)
                    Text(AppHelpers.getTranslation(
                        order.transaction?.paymentSystem?.tag ?? ''))
                ],
              ),
              14.verticalSpace,
              Divider(color: Style.greyColor, thickness: 1.r, height: 1.r),
              14.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '№ ${order.id}',
                      style: Style.interNormal(
                        color: Style.blackColor,
                        size: 14.sp,
                        letterSpacing: -0.3,
                      ),
                      children: [
                        TextSpan(
                          text: ' | ',
                          style: Style.interNormal(
                            color: Style.borderColor,
                            size: 14.sp,
                            letterSpacing: -0.3,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${order.deliveryDate ?? ''} ${order.deliveryTime ?? ''}',
                          style: Style.interNormal(
                            color: Style.blackColor,
                            size: 14.sp,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppHelpers.numberFormat(
                        order.totalPrice?.isNegative ?? true
                            ? 0
                            : order.totalPrice ?? 0,
                        symbol: order.currency?.symbol),
                    style:
                        Style.interNormal(size: 14.sp, color: Style.blackColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

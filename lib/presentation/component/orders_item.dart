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
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/infrastructure/services/enums.dart';
import 'driver_avatar.dart';
import 'package:manager/presentation/styles/style.dart';
import 'package:manager/infrastructure/services/tr_keys.dart';
import 'package:manager/infrastructure/services/app_helpers.dart';

class OrdersItem extends StatelessWidget {
  final String profileAvatar;
  final String name;
  final String number;
  final String time;
  final String price;
  final String paymentType;
  final OrderStatus status;
  final VoidCallback onTap;

  const OrdersItem({
    super.key,
    required this.profileAvatar,
    required this.name,
    required this.number,
    required this.time,
    required this.price,
    required this.status,
    required this.onTap,
    this.paymentType = '',
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 132.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DriverAvatar(
                  imageUrl: profileAvatar,
                  name: name,
                  desc: AppHelpers.getTranslation(TrKeys.delivery),
                ),
                Row(
                  children: [
                    Text(
                      paymentType,
                      style: Style.interSemi(size: 12.sp, letterSpacing: -0.3),
                    ),
                    status == OrderStatus.delivered
                        ? const SizedBox.shrink()
                        : status == OrderStatus.canceled
                            ? Container(
                                width: 10.r,
                                height: 10.r,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: Style.greyColor,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FlutterRemix.time_fill,
                                      size: 16.r,
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      "41:00",
                                      style: Style.interSemi(
                                          size: 14.sp, color: Style.blackColor),
                                    )
                                  ],
                                ),
                              ),
                  ],
                )
              ],
            ),
            const Divider(color: Style.greyColor),
            IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    number,
                    style:
                        Style.interNormal(size: 14.sp, color: Style.blackColor),
                  ),
                  const VerticalDivider(color: Style.greyColor),
                  Text(
                    time,
                    style:
                        Style.interNormal(size: 14.sp, color: Style.blackColor),
                  ),
                  const Spacer(),
                  Text(
                    "\$$price",
                    style:
                        Style.interNormal(size: 14.sp, color: Style.blackColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

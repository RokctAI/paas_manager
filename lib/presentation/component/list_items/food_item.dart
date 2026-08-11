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

import 'package:manager/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

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
        color: product.status == 'pending' ? Style.pending : Style.white,
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
                        style: Style.interNormal(
                          size: 14.sp,
                          color: Style.blackColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        '${product.translation?.description}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Style.interNormal(
                          size: 12.sp,
                          color: Style.textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        isOutOfStock
                            ? AppHelpers.getTranslation(TrKeys.outOfStock)
                            : AppHelpers.numberFormat(
                                product.stocks?.first.price ?? 0),
                        style: Style.interSemi(
                          size: 14.sp,
                          color: isOutOfStock ? Style.red : Style.blackColor,
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
                color: Style.tabBarBorderColor,
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
                          style: Style.interNormal(size: 13.sp),
                        ),
                        6.horizontalSpace,
                        Icon(
                          FlutterRemix.arrow_down_s_line,
                          size: 18.r,
                          color: Style.blackColor,
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
                          ? Style.pendingDark
                          : Style.primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          product.status == 'pending'
                              ? FlutterRemix.time_fill
                              : FlutterRemix.check_double_line,
                          size: 20.r,
                          color: Style.white,
                        ),
                        6.horizontalSpace,
                        Text(
                          product.status == 'pending'
                              ? AppHelpers.getTranslation(TrKeys.pending)
                              : AppHelpers.getTranslation(TrKeys.published),
                          style: Style.interNormal(
                            size: 14.sp,
                            color: Style.white,
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

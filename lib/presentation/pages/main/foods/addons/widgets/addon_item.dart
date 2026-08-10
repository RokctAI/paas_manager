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

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class AddonItem extends StatelessWidget {
  final ProductData addon;
  final VoidCallback onTap;

  const AddonItem({super.key, required this.addon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = addon.stock == null;
    return Container(
      color: addon.status == 'pending' ? Style.pending : Style.white,
      margin: REdgeInsets.only(bottom: 10),
      padding: REdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${addon.translation?.title}',
            style: Style.interNormal(
              size: 14.sp,
              color: Style.blackColor,
              letterSpacing: -0.3,
            ),
          ),
          8.verticalSpace,
          Text(
            '${addon.translation?.description}',
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
                : AppHelpers.numberFormat(addon.stock?.price ?? 0),
            style: Style.interSemi(
              size: 14.sp,
              color: isOutOfStock ? Style.red : Style.blackColor,
              letterSpacing: -0.3,
            ),
          ),
          20.verticalSpace,
          Divider(
            thickness: 1.r,
            height: 1.r,
            color: Style.tabBarBorderColor,
          ),
          14.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTap,
                child: ButtonsBouncingEffect(
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
              ),
              Container(
                height: 30.r,
                alignment: Alignment.center,
                padding: REdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: addon.status == 'pending'
                      ? Style.pendingDark
                      : Style.primary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      addon.status == 'pending'
                          ? FlutterRemix.time_fill
                          : FlutterRemix.check_double_line,
                      size: 20.r,
                      color: Style.white,
                    ),
                    6.horizontalSpace,
                    Text(
                      addon.status == 'pending'
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
        ],
      ),
    );
  }
}

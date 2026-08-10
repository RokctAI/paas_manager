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
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodPriceWidget extends StatelessWidget {
  final ProductData product;
  final Stock? stock;

  const FoodPriceWidget({super.key, required this.product, this.stock});

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = stock?.quantity == null ||
        (stock?.quantity ?? 0) < (product.minQty ?? 0);
    final bool hasDiscount = isOutOfStock
        ? false
        : (stock?.discount != null && (stock?.discount ?? 0) > 0);
    return isOutOfStock
        ? Text(
            AppHelpers.getTranslation(TrKeys.outOfStock),
            style: Style.interSemi(
              size: 11.sp,
              color: Style.red,
              letterSpacing: -0.3,
            ),
          )
        : (hasDiscount
            ? Row(
                children: [
                  Text(
                    AppHelpers.numberFormat(
                      (stock?.price ?? 0) + (stock?.tax ?? 0),
                    ),
                    style: Style.interSemi(
                      size: 14.sp,
                      color: Style.blackColor,
                      letterSpacing: -0.3,
                      decoration: TextDecoration.lineThrough,
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
                      borderRadius: BorderRadius.circular(30.r),
                      color: Style.bgColor,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          width: 20.r,
                          height: 20.r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.red,
                          ),
                          child: Icon(
                            FlutterRemix.percent_fill,
                            size: 12.r,
                            color: Style.white,
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          AppHelpers.numberFormat(stock?.totalPrice ?? 0),
                          style: Style.interSemi(
                            size: 14.sp,
                            color: Style.blackColor,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Text(
                AppHelpers.numberFormat(stock?.totalPrice ?? 0),
                style: Style.interSemi(
                  size: 14.sp,
                  color: Style.blackColor,
                  letterSpacing: -0.3,
                ),
              ));
  }
}

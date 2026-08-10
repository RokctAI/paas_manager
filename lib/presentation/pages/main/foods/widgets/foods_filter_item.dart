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
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodsFilterItem extends StatelessWidget {
  final String title;
  final List list;
  final bool isRating;
  final bool isPrice;
  final bool isOffer;
  final bool isSort;
  final String? currentItem;
  final String? currentItemTwo;
  final ValueChanged<String> onTap;

  const FoodsFilterItem({
    super.key,
    required this.title,
    required this.list,
    required this.onTap,
    this.isRating = false,
    this.isOffer = false,
    this.isSort = false,
    this.currentItem = '',
    this.currentItemTwo = '',
    this.isPrice = false,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.only(left: 18, right: 18, top: 18, bottom: 10),
      decoration: BoxDecoration(
        color: Style.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Style.interSemi(size: 16.sp, color: Style.blackColor),
          ),
          18.verticalSpace,
          Wrap(
            children: list
                .map(
                  (e) => GestureDetector(
                    onTap: () => onTap(e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: REdgeInsets.only(right: 8, bottom: 8),
                      padding:
                          REdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: currentItem == e || currentItemTwo == e
                            ? Style.primary
                            : Style.greyColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isRating
                              ? Row(
                                  children: [
                                    Icon(
                                      FlutterRemix.star_smile_fill,
                                      size: 16.r,
                                    ),
                                    6.horizontalSpace,
                                  ],
                                )
                              : isOffer
                                  ? Row(
                                      children: [
                                        Icon(
                                          FlutterRemix.leaf_fill,
                                          size: 16.r,
                                        ),
                                        6.horizontalSpace,
                                      ],
                                    )
                                  : isSort
                                      ? Row(
                                          children: [
                                            Container(
                                              width: 14.w,
                                              height: 14.h,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: currentItem == e
                                                      ? 4.r
                                                      : 2.r,
                                                  color: Style.blackColor,
                                                ),
                                                color: Style.transparent,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            6.horizontalSpace,
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                          isPrice
                              ? Text(
                                  AppHelpers.numberFormat(
                                      double.tryParse(e)),
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.blackColor,
                                  ),
                                )
                              : Text(
                                  e,
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.blackColor,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

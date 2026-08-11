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
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:manager/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

class FoodStockItem extends StatelessWidget {
  final Stock? product;
  final Function() onDelete;

  const FoodStockItem(
      {super.key, required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Style.white,
      margin: REdgeInsets.only(bottom: 1),
      padding: REdgeInsets.symmetric(vertical: 12),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.12,
          motion: const ScrollMotion(),
          children: [
            Expanded(
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Slidable.of(context)?.close();
                      onDelete();
                    },
                    child: Container(
                      width: 50.r,
                      height: 78.r,
                      decoration: BoxDecoration(
                        color: Style.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          bottomLeft: Radius.circular(16.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.close_fill,
                        color: Style.white,
                        size: 24.r,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            if ((product?.quantity ?? 0) > 0)
              Container(
                width: 50.r,
                height: 78.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  color: Style.primary,
                ),
                child: Text(
                  '${(product?.quantity ?? 1) * (product?.stock?.product?.interval ?? 1)} ${product?.stock?.product?.unit?.translation?.title ?? ""}',
                  style: Style.interSemi(size: 15.sp),
                ),
              ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.stock?.product?.translation?.title ?? '',
                    style: Style.interNormal(
                      size: 14.sp,
                      color: Style.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    product?.stock?.product?.translation?.description ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Style.interNormal(
                      size: 12.sp,
                      color: Style.textColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  ...?product?.stock?.extras?.map((e) => Padding(
                        padding: REdgeInsets.only(right: 4, top: 4),
                        child: Row(
                          children: [
                            Text(
                              "${e.group?.translation?.title ?? ''}: ",
                              style: Style.interNormal(
                                size: 12.sp,
                                color: Style.textColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Text(
                              AppHelpers.getTranslation(e.value ?? ''),
                              style: Style.interNormal(
                                size: 12.sp,
                                color: Style.black,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      )),
                  ...?product?.addons?.map((e) => Padding(
                        padding: REdgeInsets.only(right: 4, top: 4),
                        child: Row(
                          children: [
                            Text(
                              e.product?.translation?.title ?? '',
                              style: Style.interNormal(
                                size: 12.sp,
                                color: Style.textColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Text(
                              "  ${AppHelpers.numberFormat((e.totalPrice ?? 0) / (e.quantity ?? 1))} x ${e.quantity ?? 1}",
                              style: Style.interNormal(
                                size: 12.sp,
                                color: Style.black,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      )),
                  8.verticalSpace,
                  if (product?.shopBonus ?? false)
                    Text(
                      AppHelpers.getTranslation(TrKeys.shopBonus),
                      style: Style.interSemi(
                        size: 14.sp,
                        color: Style.black,
                        letterSpacing: -0.3,
                      ),
                    )
                  else if (product?.bonus ?? false)
                    Text(
                      AppHelpers.getTranslation(TrKeys.bonus),
                      style: Style.interSemi(
                        size: 14.sp,
                        color: Style.black,
                        letterSpacing: -0.3,
                      ),
                    )
                  else
                    Text(
                      AppHelpers.numberFormat(product?.totalPrice),
                      style: Style.interSemi(
                        size: 14.sp,
                        color: Style.black,
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
              url: product?.stock?.product?.img,
              radius: 0,
              errorRadius: 0,
              fit: BoxFit.fitWidth,
            ),
            16.horizontalSpace,
          ],
        ),
      ),
    );
  }
}

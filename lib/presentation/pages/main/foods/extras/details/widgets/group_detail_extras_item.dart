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

import '../../../../../../../infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../../component/components.dart';
import '../../../../../../../infrastructure/models/models.dart';

class GroupDetailExtrasItem extends StatelessWidget {
  final Extras extras;
  final Function() onEditTap;
  final Function() onDeleteTap;

  const GroupDetailExtrasItem({
    super.key,
    required this.extras,
    required this.onEditTap,
    required this.onDeleteTap,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: REdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              extras.value ?? '',
              style: Style.interRegular(
                size: 15.sp,
                color: Style.blackColor,
                letterSpacing: -0.3,
              ),
            ),
            if (extras.group?.shopId == LocalStorage.getShop()?.id)
              Row(
                children: [
                  ButtonsBouncingEffect(
                    child: GestureDetector(
                      onTap: onEditTap,
                      child: Icon(
                        FlutterRemix.pencil_fill,
                        size: 20.r,
                        color: Style.blackColor,
                      ),
                    ),
                  ),
                  20.horizontalSpace,
                  ButtonsBouncingEffect(
                    child: GestureDetector(
                      onTap: onDeleteTap,
                      child: Icon(
                        FlutterRemix.delete_bin_line,
                        size: 20.r,
                        color: Style.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

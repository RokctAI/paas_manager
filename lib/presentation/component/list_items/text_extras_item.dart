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

import 'package:venderfoodyman/presentation/styles/style.dart';

class TextExtrasItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String title;
  final bool isLast;

  const TextExtrasItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.title,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 18.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: isActive ? Style.green : Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? Style.blackColor : Style.greyColor,
                        width: isActive ? 4.r : 2.r,
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                  Text(
                    title,
                    style: Style.interNormal(
                      size: 16.sp,
                      color: Style.blackColor,
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Column(
                  children: [
                    16.verticalSpace,
                    Divider(
                      color: Style.textColor.withOpacity(0.1),
                      height: 1.r,
                      thickness: 1.r,
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

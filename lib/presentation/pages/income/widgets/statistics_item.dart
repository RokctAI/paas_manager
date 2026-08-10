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

class StatisticsItem extends StatelessWidget {
  final String title;
  final int count;
  final double? percentage;
  final Color bgColor;
  final Color textColor;
  final Color iconColor;

  const StatisticsItem({
    super.key,
    required this.title,
    required this.count,
    required this.bgColor,
    required this.textColor,
    required this.iconColor,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      width: (MediaQuery.sizeOf(context).width - 140.w) / 2,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: REdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Style.interNormal(
              size: 12.sp,
              color: textColor,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '$count',
                style: Style.interSemi(
                  size: 14.sp,
                  color: textColor,
                  letterSpacing: -0.6,
                ),
              ),
              if (percentage != null)
                Row(
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      margin: REdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: iconColor),
                    ),
                    Text(
                      '${percentage?.toStringAsFixed(1)}%',
                      style: Style.interSemi(
                        size: 14.sp,
                        color: textColor,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

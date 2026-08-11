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
import 'helper/common_image.dart';

class DriverAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String desc;

  const DriverAvatar({
    super.key,
    required this.name,
    required this.desc,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 50.r,
          width: 50.r,
          child: CommonImage(url: imageUrl, radius: 25),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Style.interRegular(size: 14.sp, color: Style.blackColor),
            ),
            4.verticalSpace,
            Text(
              desc,
              style: Style.interNormal(size: 12.sp, color: Style.blackColor),
            )
          ],
        ),
      ],
    );
  }
}

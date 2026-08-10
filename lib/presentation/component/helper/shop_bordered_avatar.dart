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

import 'blur_wrap.dart';
import 'common_image.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class ShopBorderedAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double imageSize;
  final double borderRadius;
  final Color bgColor;

  const ShopBorderedAvatar({
    super.key,
    this.imageUrl,
    required this.size,
    required this.imageSize,
    required this.borderRadius,
    this.bgColor = Style.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.circular(borderRadius.r),
      child: Container(
        width: size.r,
        height: size.r,
        color: bgColor,
        alignment: Alignment.center,
        child: CommonImage(
          url: imageUrl,
          width: imageSize,
          height: imageSize,
          radius: imageSize / 2,
        ),
      ),
    );
  }
}

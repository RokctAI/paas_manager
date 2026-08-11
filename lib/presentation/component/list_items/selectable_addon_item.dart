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
import 'package:manager/infrastructure/models/models.dart';

class SelectableAddonItem extends StatelessWidget {
  final ProductData addon;
  final bool isLast;
  final VoidCallback? onTap;

  const SelectableAddonItem({
    super.key,
    required this.addon,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          18.verticalSpace,
          Row(
            children: [
              Icon(
                (addon.isSelectedAddon ?? false)
                    ? FlutterRemix.checkbox_circle_fill
                    : FlutterRemix.checkbox_blank_circle_line,
                size: 24.r,
                color: (addon.isSelectedAddon ?? false)
                    ? Style.primary
                    : Style.blackColor,
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${addon.translation?.title}',
                      style: Style.interSemi(size: 14.sp, letterSpacing: -0.3),
                    ),
                    4.verticalSpace,
                    Text(
                      '${addon.translation?.description}',
                      style:
                          Style.interRegular(size: 12.sp, letterSpacing: -0.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          if (!isLast)
            Divider(
              thickness: 1.r,
              height: 1.r,
              color: Style.textColor.withOpacity(0.15),
            ),
        ],
      ),
    );
  }
}

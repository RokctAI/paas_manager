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
import '../buttons/buttons_bouncing_effect.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class ExtrasItem extends StatelessWidget {
  final Group extras;
  final Function()? onTap;
  final bool isLast;

  const ExtrasItem({
    super.key,
    required this.extras,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Style.transparent,
          padding: REdgeInsets.symmetric(vertical: 16),
          margin: REdgeInsets.only(right: 14),
          child: Row(
            children: [
              Icon(
                (extras.isChecked ?? false)
                    ? FlutterRemix.checkbox_circle_fill
                    : FlutterRemix.checkbox_blank_circle_line,
                color: (extras.isChecked ?? false)
                    ? Style.primary
                    : Style.blackColor,
                size: 24.r,
              ),
              4.horizontalSpace,
              Text(
                '${extras.translation?.title}',
                style: Style.interSemi(size: 14.sp, letterSpacing: -0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

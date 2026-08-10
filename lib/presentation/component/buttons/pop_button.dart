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
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'buttons_bouncing_effect.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class PopButton extends StatelessWidget {
  final String heroTag;

  const PopButton({super.key, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    return ButtonsBouncingEffect(
      child: Hero(
        tag: heroTag,
        child: GestureDetector(
          onTap: context.maybePop,
          child: Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: Style.blackColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              isLtr
                  ? FlutterRemix.arrow_left_s_line
                  : FlutterRemix.arrow_right_s_line,
              color: Style.white,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}

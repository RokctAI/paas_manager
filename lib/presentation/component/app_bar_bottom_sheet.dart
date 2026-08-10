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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'buttons/buttons_bouncing_effect.dart';

class AppBarBottomSheet extends StatelessWidget {
  final String title;

  const AppBarBottomSheet({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonsBouncingEffect(
          child: GestureDetector(
            onTap: context.maybePop,
            child: Icon(
              Icons.arrow_back,
              color: Style.blackColor,
              size: 24.r,
            ),
          ),
        ),
        Text(
          title,
          style: Style.interSemi(
            size: 20,
            color: Style.blackColor,
            letterSpacing: -0.01,
          ),
        ),
        Container(width: 24.w, height: 24.h, margin: REdgeInsets.all(8)),
      ],
    );
  }
}

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

class CustomCheckbox extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const CustomCheckbox(
      {super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 24.r,
        height: 24.r,
        decoration: BoxDecoration(
            color: isActive ? Style.primary : Style.borderColor,
            borderRadius: BorderRadius.circular(8.r)),
        duration: const Duration(milliseconds: 500),
        child: isActive
            ? Icon(
                FlutterRemix.check_fill,
                color: Style.blackColor,
                size: 18.r,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

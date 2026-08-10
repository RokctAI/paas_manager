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

class BottomNavigatorItem extends StatelessWidget {
  final VoidCallback selectItem;
  final int index;
  final int currentIndex;
  final IconData selectIcon;
  final IconData unSelectIcon;
  final bool isScrolling;

  const BottomNavigatorItem({
    super.key,
    required this.selectItem,
    required this.index,
    required this.selectIcon,
    required this.unSelectIcon,
    required this.currentIndex,
    required this.isScrolling,
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectItem,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        color: Style.transparent,
        height: isScrolling ? 0.h : 30.h,
        width: isScrolling ? 0.w : 56.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: index == currentIndex
                  ? Icon(
                      selectIcon,
                      size: isScrolling ? 0.r : 24.r,
                      color: Style.white,
                    )
                  : Icon(
                      unSelectIcon,
                      size: isScrolling ? 0.r : 24.r,
                      color: Style.white,
                    ),
            ),
            AnimatedContainer(
              height: isScrolling ? 0.h : 4.h,
              width: isScrolling ? 0.w : 24.w,
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? Style.primary
                    : Style.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.r),
                  topRight: Radius.circular(100.r),
                ),
              ),
              duration: const Duration(milliseconds: 400),
            )
          ],
        ),
      ),
    );
  }
}

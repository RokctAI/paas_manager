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
import 'package:manager/presentation/component/buttons/buttons_bouncing_effect.dart';

import 'package:manager/presentation/styles/style.dart';

class CustomButton extends StatelessWidget {
  final Icon? icon;
  final String title;
  final bool isLoading;
  final Function()? onPressed;
  final Color background;
  final Color borderColor;
  final Color textColor;
  final double weight;
  final double radius;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.background = Style.primary,
    this.textColor = Style.black,
    this.weight = double.infinity,
    this.radius = 8,
    this.icon,
    this.borderColor = Style.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              color:
                  borderColor == Style.transparent ? background : borderColor,
              width: 2.r),
          elevation: 0,
          shadowColor: Style.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
          ),
          minimumSize: Size(weight, 50.h),
          backgroundColor: background,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2.r,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon == null
                      ? const SizedBox()
                      : Row(
                          children: [
                            icon!,
                            10.horizontalSpace,
                          ],
                        ),
                  Text(
                    title,
                    style: Style.interNormal(
                      size: 15,
                      color: textColor,
                      letterSpacing: -14 * 0.01,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

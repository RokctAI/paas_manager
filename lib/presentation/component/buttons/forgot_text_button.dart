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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:manager/presentation/styles/style.dart';

class ForgotTextButton extends ConsumerWidget {
  final String title;
  final Function() onPressed;
  final double? fontSize;
  final Color? fontColor;
  final double? letterSpacing;

  const ForgotTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.fontColor = Style.blackColor,
    this.letterSpacing = -14 * 0.02,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => Style.greyColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Style.interNormal(
          textDecoration: TextDecoration.underline,
          size: 12,
          color: Style.blackColor,
        ),
      ),
    );
  }
}

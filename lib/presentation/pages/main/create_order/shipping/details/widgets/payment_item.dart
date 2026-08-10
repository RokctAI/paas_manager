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

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../../../infrastructure/models/models.dart';

class PaymentItem extends StatelessWidget {
  final Payment payment;
  final bool isSelected;
  final bool isLast;
  final Function() onTap;

  const PaymentItem({
    super.key,
    required this.payment,
    required this.isSelected,
    required this.onTap,
    this.isLast = false,
  }) ;

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  isSelected
                      ? FlutterRemix.checkbox_circle_fill
                      : FlutterRemix.checkbox_circle_line,
                  size: 24.r,
                  color: isSelected ? Style.primary : Style.blackColor,
                ),
                14.horizontalSpace,
                Text(
                  '${toBeginningOfSentenceCase(payment.payment?.tag)}',
                  style: Style.interSemi(size: 14.sp, letterSpacing: -0.3),
                ),
              ],
            ),
            if (!isLast)
              Column(
                children: [
                  14.verticalSpace,
                  Divider(
                    thickness: 1.r,
                    height: 1.r,
                    color: Style.greyColor,
                  ),
                  14.verticalSpace,
                ],
              ),
          ],
        ),
      ),
    );
  }
}

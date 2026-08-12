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
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';

// Legacy manager toggle palette - not part of base AppStyle's tokens.
const Color _toggleColor = Color(0xFFE7E7E7);
const Color _toggleShadowColor = Color(0xFF6B6B6B);

// base_sdk's TrKeys has `close` but no `open` (core follow-up: add it);
// same key string the deleted host TrKeys declared.
const String _trKeyOpen = 'open';

class CustomToggle extends StatefulWidget {
  final ValueNotifier<bool>? controller;
  final bool isText;
  final Function(bool?)? onChange;

  const CustomToggle(
      {super.key, this.controller, this.onChange, this.isText = false});

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  void initState() {
    super.initState();
    // Remove the problematic listener setup from initState
  }

  @override
  void dispose() {
    // Don't dispose the controller here since it's passed from parent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: widget.controller,
      initialValue: widget.controller?.value ?? false,

      // FIXED: Add the onChanged callback here
      onChanged: (value) {
        debugPrint('=== CustomToggle onChanged ===');
        debugPrint('AdvancedSwitch onChanged: $value');

        // Update the controller value
        widget.controller?.value = value;

        // Call the parent's onChange callback
        if (widget.onChange != null) {
          widget.onChange!(value);
        }

        debugPrint('=============================');
      },

      activeColor: AppStyle.primary,
      inactiveColor: _toggleColor,
      borderRadius: BorderRadius.circular(10.r),
      width: 70.w,
      height: 30.h,
      enabled: true,
      disabledOpacity: 0.5,
      activeChild: widget.isText
          ? Padding(
              padding: REdgeInsets.only(left: 4.r),
              child: Text(
                AppHelpers.getTranslation(_trKeyOpen),
                style: AppStyle.interNormal(size: 12.sp),
              ),
            )
          : const SizedBox.shrink(),
      inactiveChild: widget.isText
          ? Padding(
              padding: REdgeInsets.only(right: 4.r),
              child: Text(
                AppHelpers.getTranslation(TrKeys.close),
                style: AppStyle.interNormal(size: 12.sp),
              ),
            )
          : const SizedBox.shrink(),
      thumb: Container(
        margin: REdgeInsets.all(3),
        padding: REdgeInsets.symmetric(vertical: 7, horizontal: 9),
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: _toggleShadowColor.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(color: _toggleColor),
        ),
      ),
    );
  }
}

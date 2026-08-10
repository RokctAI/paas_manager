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

import 'logout_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class LogoutButton extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onChange;

  const LogoutButton({super.key, required this.isOpen, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 6.r,
      right: 16.r,
      child: Row(
        children: [
          BlurWrap(
            radius: BorderRadius.circular(10.r),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Style.blackColor.withOpacity(0.29),
              ),
              padding: EdgeInsets.all(4.r),
              child: CustomToggle(
                isText: true,
                key: UniqueKey(),
                controller: ValueNotifier<bool>(isOpen),
                onChange: (value) {
                  onChange();
                },
              ),
            ),
          ),
          16.horizontalSpace,
          ButtonsBouncingEffect(
            child: GestureDetector(
              onTap: () => AppHelpers.showCustomModalBottomSheet(
                context: context,
                modal: const LogoutModal(),
                isDarkMode: LocalStorage.getAppThemeMode(),
              ),
              child: BlurWrap(
                radius: BorderRadius.circular(10.r),
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Style.blackColor.withOpacity(0.29),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    FlutterRemix.logout_circle_r_line,
                    color: Style.white,
                    size: 22.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

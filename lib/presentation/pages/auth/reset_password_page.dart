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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/infrastructure/models/data/user.dart';

import 'package:manager/presentation/styles/style.dart';
import 'register_confirmation_page.dart';
import '../../component/components.dart';
import 'package:manager/application/providers.dart';
import 'package:manager/infrastructure/services/services.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key}) ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);
    final bool isDarkMode = LocalStorage.getAppThemeMode();
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading,
        child: KeyboardDisable(
          child: Container(
            padding: MediaQuery.viewInsetsOf(context),
            decoration: BoxDecoration(
                color: Style.greyColor.withOpacity(0.96),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                )),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        AppBarBottomSheet(
                          title: AppHelpers.getTranslation(TrKeys.resetPassword),
                        ),
                        Text(
                          AppHelpers.getTranslation(TrKeys.resetPasswordText),
                          style: Style.interRegular(
                              size: 14.sp, color: Style.blackColor),
                        ),
                        40.verticalSpace,
                        UnderlinedTextField(
                          label: AppHelpers.getTranslation(TrKeys.email).toUpperCase(),
                          onChanged: notifier.setEmail,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom,
                        top: 120.h,
                      ),
                      child: CustomButton(
                        title: AppHelpers.getTranslation(TrKeys.send),
                        onPressed: () {
                          context.maybePop();
                          AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                            context: context,
                            modal: RegisterConfirmationPage(
                              userModel: UserModel(),
                              verificationId: '',
                            ),
                            isDarkMode: isDarkMode,
                          );
                        },
                        background: Style.primary,
                        textColor: Style.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

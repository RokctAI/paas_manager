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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/presentation/component/components.dart';

import 'package:manager/application/providers.dart';
import 'package:manager/infrastructure/services/services.dart';
import '../../../component/text_fields/outline_bordered_text_field.dart';
import 'package:manager/presentation/styles/style.dart';

class SetPasswordPage extends ConsumerWidget {
  const SetPasswordPage({super.key}) ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading,
        child: KeyboardDisable(
          child: Container(
            padding: MediaQuery.viewInsetsOf(context),
            decoration: BoxDecoration(
                color: Style.black.withOpacity(0.5),
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
                        40.verticalSpace,
                        OutlinedBorderTextField(
                          label:
                              AppHelpers.getTranslation(TrKeys.password).toUpperCase(),
                          obscure: state.showPassword,
                          suffixIcon: IconButton(
                            splashRadius: 25,
                            icon: Icon(
                              state.showPassword
                                  ? FlutterRemix.eye_line
                                  : FlutterRemix.eye_close_line,
                              size: 20.r,
                            ),
                            onPressed: () => notifier.toggleShowPassword(),
                          ),
                          onChanged: (name) => notifier.setPassword(name),
                          isError: state.isPasswordInvalid,
                          descriptionText: state.isPasswordInvalid
                              ? AppHelpers.getTranslation(TrKeys
                                  .passwordShouldContainMinimum6Characters)
                              : null,
                        ),
                        34.verticalSpace,
                        OutlinedBorderTextField(
                          label:
                              AppHelpers.getTranslation(TrKeys.password).toUpperCase(),
                          obscure: state.showConfirmPassword,
                          suffixIcon: IconButton(
                            splashRadius: 25,
                            icon: Icon(
                              state.showConfirmPassword
                                  ? FlutterRemix.eye_line
                                  : FlutterRemix.eye_close_line,
                              size: 20.r,
                            ),
                            onPressed: () =>
                                notifier.toggleShowConfirmPassword(),
                          ),
                          onChanged: (name) =>
                              notifier.setConfirmPassword(name),
                          isError: state.isConfirmPasswordInvalid,
                          descriptionText: state.isConfirmPasswordInvalid
                              ? AppHelpers.getTranslation(
                                  TrKeys.confirmPasswordIsNotTheSame)
                              : null,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.paddingOf(context).bottom,
                          top: 120.h),
                      child: CustomButton(
                        isLoading: state.isLoading,
                        title: AppHelpers.getTranslation(TrKeys.send),
                        onPressed: () {
                          notifier.setResetPassword(context);
                        },
                        background: Style.green,
                        textColor: Style.black,
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

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
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/infrastructure/models/data/user.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/application/providers.dart';
import '../../component/text_fields/outline_bordered_text_field.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'register_confirmation_page.dart';

class RegisterPage extends ConsumerWidget {
  final bool isOnlyEmail;

  const RegisterPage({super.key, required this.isOnlyEmail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.read(signUpProvider.notifier);
    final state = ref.watch(signUpProvider);
    final profileNotifier = ref.read(profileProvider.notifier);
    final profileState = ref.watch(profileProvider);
    final bool isDarkMode = LocalStorage.getAppThemeMode();
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDisable(
        child: Container(
          margin: MediaQuery.viewInsetsOf(context),
          decoration: BoxDecoration(
              color: Style.greyColor.withOpacity(0.96),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              )),
          width: double.infinity,
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      AppBarBottomSheet(
                        title: AppHelpers.getTranslation(TrKeys.register),
                      ),
                      if (isOnlyEmail && !AppConstants.isSpecificNumberEnabled)
                        OutlinedBorderTextField(
                          label: AppHelpers.getTranslation(TrKeys.email)
                              .toUpperCase(),
                          onChanged: (s) {
                            event.setPhone(s);
                            event.setEmail(s);
                            profileNotifier.setPhone(s);
                          },
                          isError: state.isPhoneInvalid,
                          descriptionText: state.isPhoneInvalid
                              ? AppHelpers.getTranslation(TrKeys.cannotBeEmpty)
                              : null,
                        ),
                      if (isOnlyEmail && AppConstants.isSpecificNumberEnabled)
                        Directionality(
                          textDirection:
                              isLtr ? TextDirection.ltr : TextDirection.rtl,
                          child: IntlPhoneField(
                            disableLengthCheck:
                                !AppConstants.isNumberLengthAlwaysSame,
                            onChanged: (phoneNum) {
                              profileNotifier.setPhone(phoneNum.completeNumber);
                              event.setPhone(phoneNum.completeNumber);
                            },
                            validator: (s) {
                              if (state.isLoginError) {
                                return AppHelpers.getTranslation(
                                    TrKeys.loginCredentialsAreNotValid);
                              }
                              if (AppConstants.isNumberLengthAlwaysSame &&
                                  (s?.isValidNumber() ?? true)) {
                                return AppHelpers.getTranslation(
                                    TrKeys.phoneNumberIsNotValid);
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            initialCountryCode: AppConstants.countryCodeISO,
                            invalidNumberMessage: AppHelpers.getTranslation(
                                state.isLoginError
                                    ? TrKeys.loginCredentialsAreNotValid
                                    : TrKeys.phoneNumberIsNotValid),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            showCountryFlag: AppConstants.showFlag,
                            showDropdownIcon: AppConstants.showArrowIcon,
                            autovalidateMode: state.isLoginError
                                ? AutovalidateMode.always
                                : AppConstants.isNumberLengthAlwaysSame
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.merge(
                                      const BorderSide(
                                          color: Style.differBorderColor),
                                      const BorderSide(
                                          color: Style.differBorderColor))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.merge(
                                      const BorderSide(
                                          color: Style.differBorderColor),
                                      const BorderSide(
                                          color: Style.differBorderColor))),
                              border: const UnderlineInputBorder(),
                              focusedErrorBorder: const UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.merge(
                                      const BorderSide(
                                          color: Style.differBorderColor),
                                      const BorderSide(
                                          color: Style.differBorderColor))),
                              focusedBorder: const UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      if (!isOnlyEmail)
                        Column(
                          children: [
                            (state.verificationId.isEmpty)
                                ? 30.verticalSpace
                                : 0.verticalSpace,
                            (state.verificationId.isEmpty)
                                ? OutlinedBorderTextField(
                                    label:
                                        AppHelpers.getTranslation(TrKeys.email)
                                            .toUpperCase(),
                                    onChanged: event.setEmail,
                                    isError: state.isEmailInvalid,
                                    descriptionText: state.isEmailInvalid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.cannotBeEmpty)
                                        : null,
                                  )
                                : const SizedBox.shrink(),
                            30.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.sizeOf(context).width - 40) /
                                          2,
                                  child: OutlinedBorderTextField(
                                    label: AppHelpers.getTranslation(
                                            TrKeys.firstname)
                                        .toUpperCase(),
                                    onChanged: (name) =>
                                        event.setFirstName(name),
                                    isError: state.isFirstNameInvalid,
                                    descriptionText: state.isFirstNameInvalid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.cannotBeEmpty)
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      (MediaQuery.sizeOf(context).width - 40) /
                                          2,
                                  child: OutlinedBorderTextField(
                                    label: AppHelpers.getTranslation(
                                            TrKeys.surname)
                                        .toUpperCase(),
                                    onChanged: (name) => event.setLatName(name),
                                    isError: state.isSurNameInvalid,
                                    descriptionText: state.isSurNameInvalid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.cannotBeEmpty)
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            30.verticalSpace,
                            OutlinedBorderTextField(
                              label: AppHelpers.getTranslation(TrKeys.password)
                                  .toUpperCase(),
                              obscure: state.showPassword,
                              suffixIcon: IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  state.showPassword
                                      ? FlutterRemix.eye_line
                                      : FlutterRemix.eye_close_line,
                                  color: isDarkMode
                                      ? Style.black
                                      : Style.hintColor,
                                  size: 20.r,
                                ),
                                onPressed: () => event.toggleShowPassword(),
                              ),
                              onChanged: (name) => event.setPassword(name),
                              isError: state.isPasswordInvalid,
                              descriptionText: state.isPasswordInvalid
                                  ? AppHelpers.getTranslation(TrKeys
                                      .passwordShouldContainMinimum6Characters)
                                  : null,
                            ),
                            34.verticalSpace,
                            OutlinedBorderTextField(
                              label: AppHelpers.getTranslation(
                                      TrKeys.confirmPassword)
                                  .toUpperCase(),
                              obscure: state.showConfirmPassword,
                              suffixIcon: IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  state.showConfirmPassword
                                      ? FlutterRemix.eye_line
                                      : FlutterRemix.eye_close_line,
                                  color: isDarkMode
                                      ? Style.black
                                      : Style.hintColor,
                                  size: 20.r,
                                ),
                                onPressed: () =>
                                    event.toggleShowConfirmPassword(),
                              ),
                              onChanged: (name) =>
                                  event.setConfirmPassword(name),
                              isError: state.isConfirmPasswordInvalid,
                              descriptionText: state.isConfirmPasswordInvalid
                                  ? AppHelpers.getTranslation(
                                      TrKeys.confirmPasswordIsNotTheSame)
                                  : null,
                            ),
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: CustomButton(
                      isLoading: state.isLoading,
                      title: AppHelpers.getTranslation(TrKeys.register),
                      onPressed: () {
                        isOnlyEmail
                            ? (event.checkEmail()
                                ? event.sendCode(context, () {
                                    Navigator.pop(context);
                                    AppHelpers
                                        .showCustomModalBottomSheetWithoutIosIcon(
                                      context: context,
                                      modal: RegisterConfirmationPage(
                                          verificationId: "",
                                          userModel: UserModel(
                                              firstname: state.firstName,
                                              lastname: state.lastName,
                                              phone: state.phone,
                                              email: state.email,
                                              password: state.password,
                                              confirmPassword:
                                                  state.confirmPassword)),
                                      isDarkMode: isDarkMode,
                                    );
                                  })
                                : event.sendCodeToNumber(context, (s) {
                                    Navigator.pop(context);
                                    AppHelpers
                                        .showCustomModalBottomSheetWithoutIosIcon(
                                      context: context,
                                      modal: RegisterConfirmationPage(
                                          verificationId: s,
                                          userModel: UserModel(
                                              firstname: state.firstName,
                                              lastname: state.lastName,
                                              phone: state.phone,
                                              email: state.email,
                                              password: state.password,
                                              confirmPassword:
                                                  state.confirmPassword)),
                                      isDarkMode: isDarkMode,
                                    );
                                  }))
                            : state.verificationId.isEmpty
                                ? event.registerWithPhone(
                                    context, profileState.userData?.phone)
                                : event.registerWithPhone(
                                    context, profileState.userData?.phone);
                      },
                    ),
                  ),
                  32.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

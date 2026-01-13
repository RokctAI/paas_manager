import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../styles/style.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import '../../../../../application/providers.dart';
import '../../../../../infrastructure/services/services.dart';
import '../../reset_password_page.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Add local SignUpType variable to track the current state
  SignUpType currentSignUpType = AppConstants.signUpType;

  // Method to toggle between phone and email sign up types
  void toggleSignUpType() {
    setState(() {
      if (currentSignUpType == SignUpType.phone) {
        currentSignUpType = SignUpType.email;
      } else {
        currentSignUpType = SignUpType.phone;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.getAppThemeMode();
    final bool isLtr = LocalStorage.getLangLtr();
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

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
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Consumer(
                  builder: (context, ref, child) {
                    final event = ref.read(loginProvider.notifier);
                    final state = ref.watch(loginProvider);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            8.verticalSpace,
                            AppBarBottomSheet(
                              title: AppHelpers.getTranslation(TrKeys.login),
                            ),

                            // Add segmented control for iOS
                            if (isIOS)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16.h),
                                child: CupertinoSegmentedControl<SignUpType>(
                                  children: {
                                    SignUpType.phone: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Text(AppHelpers.getTranslation(TrKeys.phone)),
                                    ),
                                    SignUpType.email: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Text(AppHelpers.getTranslation(TrKeys.email)),
                                    ),
                                  },
                                  onValueChanged: (SignUpType value) {
                                    setState(() {
                                      currentSignUpType = value;
                                    });
                                  },
                                  groupValue: currentSignUpType,
                                ),
                              ),

                            30.verticalSpace,

                            // Phone field for when phone signup is selected
                            if (currentSignUpType == SignUpType.phone)
                              Directionality(
                                textDirection: isLtr
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: IntlPhoneField(
                                  disableLengthCheck: !AppConstants.isNumberLengthAlwaysSame,
                                  onChanged: (phoneNum) {
                                    event.setEmail(phoneNum.completeNumber);
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
                                  initialCountryCode:
                                  AppConstants.countryCodeISO,
                                  invalidNumberMessage:
                                  AppHelpers.getTranslation(state
                                      .isLoginError
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
                                                color:
                                                Style.differBorderColor))),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.merge(
                                            const BorderSide(
                                                color: Style.differBorderColor),
                                            const BorderSide(
                                                color:
                                                Style.differBorderColor))),
                                    border: const UnderlineInputBorder(),
                                    focusedErrorBorder:
                                    const UnderlineInputBorder(),
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.merge(
                                            const BorderSide(
                                                color: Style.differBorderColor),
                                            const BorderSide(
                                                color:
                                                Style.differBorderColor))),
                                    focusedBorder: const UnderlineInputBorder(),
                                  ),
                                ),
                              ),

                            // Email field for when email signup is selected
                            if (currentSignUpType == SignUpType.email)
                              UnderlinedTextField(
                                inputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.none,
                                textController: emailController,
                                label: AppHelpers.getTranslation(TrKeys.email).toUpperCase(),
                                onChanged: event.setEmail,
                                validator: AppValidators.emptyCheck,
                                isError: state.isLoginError,
                                descriptionText: state.isLoginError
                                    ? AppHelpers.getTranslation(
                                    TrKeys.loginCredentialsAreNotValid)
                                    : null,
                              ),

                            // Both field for when both signup is selected
                            if (currentSignUpType == SignUpType.both)
                              UnderlinedTextField(
                                inputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.none,
                                textController: emailController,
                                label: AppHelpers.getTranslation(
                                    TrKeys.emailOrPhone)
                                    .toUpperCase(),
                                onChanged: event.setEmail,
                                validator: AppValidators.emptyCheck,
                                isError: state.isLoginError,
                                descriptionText: state.isLoginError
                                    ? AppHelpers.getTranslation(
                                    TrKeys.loginCredentialsAreNotValid)
                                    : null,
                              ),

                            // Fallback for when AppConstants.isSpecificNumberEnabled is true
                            if (AppConstants.isSpecificNumberEnabled && currentSignUpType != SignUpType.email && currentSignUpType != SignUpType.both)
                              Directionality(
                                textDirection: isLtr
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: IntlPhoneField(
                                  disableLengthCheck: !AppConstants.isNumberLengthAlwaysSame,
                                  onChanged: (phoneNum) {
                                    event.setEmail(phoneNum.completeNumber);
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
                                  initialCountryCode:
                                  AppConstants.countryCodeISO,
                                  invalidNumberMessage:
                                  AppHelpers.getTranslation(state
                                      .isLoginError
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
                                                color:
                                                Style.differBorderColor))),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.merge(
                                            const BorderSide(
                                                color: Style.differBorderColor),
                                            const BorderSide(
                                                color:
                                                Style.differBorderColor))),
                                    border: const UnderlineInputBorder(),
                                    focusedErrorBorder:
                                    const UnderlineInputBorder(),
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.merge(
                                            const BorderSide(
                                                color: Style.differBorderColor),
                                            const BorderSide(
                                                color:
                                                Style.differBorderColor))),
                                    focusedBorder: const UnderlineInputBorder(),
                                  ),
                                ),
                              ),

                            34.verticalSpace,
                            UnderlinedTextField(
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.none,
                              label: AppHelpers.getTranslation(TrKeys.password)
                                  .toUpperCase(),
                              obscure: state.showPassword,
                              textController: passwordController,
                              validator: AppValidators.passwordCheck,
                              isError: state.isLoginError,
                              descriptionText: state.isLoginError
                                  ? AppHelpers.getTranslation(
                                  TrKeys.loginCredentialsAreNotValid)
                                  : null,
                              suffixIcon: ButtonsBouncingEffect(
                                child: GestureDetector(
                                  onTap: event.toggleShowPassword,
                                  child: Icon(
                                    state.showPassword
                                        ? FlutterRemix.eye_line
                                        : FlutterRemix.eye_close_line,
                                    color: isDarkMode
                                        ? Style.blackColor
                                        : Style.textColor,
                                    size: 20.r,
                                  ),
                                ),
                              ),
                              onChanged: event.setPassword,
                            ),
                            30.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: Checkbox(
                                        side: BorderSide(
                                          color: Style.blackColor,
                                          width: 2.r,
                                        ),
                                        activeColor: Style.blackColor,
                                        value: state.isKeepLogin,
                                        onChanged: (value) =>
                                            event.toggleKeepLogin(),
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.keepMeLoggedIn),
                                      style: Style.interNormal(
                                        size: 12.sp,
                                        color: Style.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add forgot password button
                                ForgotTextButton(
                                  title: AppHelpers.getTranslation(
                                    TrKeys.forgotPassword,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    AppHelpers.showCustomModalBottomSheet(
                                      context: context,
                                      modal: const ResetPasswordPage(),
                                      isDarkMode: isDarkMode,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        40.verticalSpace,
                        Column(
                          children: [
                            CustomButton(
                              title: AppHelpers.getTranslation(TrKeys.login),
                              isLoading: state.isLoading,
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  event.login(
                                    checkYourNetwork: () =>
                                        AppHelpers.showCheckTopSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                              TrKeys.checkYourNetworkConnection),
                                        ),
                                    loginSuccess: () {
                                      ref
                                          .read(restaurantProvider.notifier)
                                          .fetchMyShop(
                                        afterFetched: () {
                                          Navigator.pop(context);
                                          context.router.popUntilRoot();
                                          context
                                              .replaceRoute(const MainRoute());
                                        },
                                      );
                                    },
                                    seller: () =>
                                        AppHelpers.showCheckTopSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                              TrKeys.youAreASeller),
                                          type: SnackBarType.success,
                                        ),
                                    admin: () =>
                                        AppHelpers.showCheckTopSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                              TrKeys.youAreAnAdmin),
                                          type: SnackBarType.success,
                                        ),
                                    accessDenied: () {
                                      Navigator.pop(context);
                                      context.router.popUntilRoot();
                                      context.replaceRoute(
                                          const CreateShopRoute());
                                    },
                                  );
                                }
                              },
                            ),

                            // Add social login section
                            32.verticalSpace,
                            Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                    color: Style.blackColor.withOpacity(0.5),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(right: 12, left: 12),
                                child: Text(
                                  AppHelpers.getTranslation(TrKeys.orAccessQuickly),
                                  style: Style.interNormal(
                                    size: 12.sp,
                                    color: Style.textColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                    color: Style.blackColor.withOpacity(0.5),
                                  )),
                            ]),
                            22.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (isIOS)
                                  SocialButton(
                                      iconData: FlutterRemix.apple_fill,
                                      onPressed: () {
                                        event.loginWithApple(
                                          checkYourNetwork: () =>
                                              AppHelpers.showCheckTopSnackBar(
                                                context,
                                                text: AppHelpers.getTranslation(
                                                    TrKeys.checkYourNetworkConnection),
                                              ),
                                          loginSuccess: () {
                                            ref
                                                .read(restaurantProvider.notifier)
                                                .fetchMyShop(
                                              afterFetched: () {
                                                Navigator.pop(context);
                                                context.router.popUntilRoot();
                                                context
                                                    .replaceRoute(const MainRoute());
                                              },
                                            );
                                          },
                                          seller: () =>
                                              AppHelpers.showCheckTopSnackBar(
                                                context,
                                                text: AppHelpers.getTranslation(
                                                    TrKeys.youAreASeller),
                                                type: SnackBarType.success,
                                              ),
                                          admin: () =>
                                              AppHelpers.showCheckTopSnackBar(
                                                context,
                                                text: AppHelpers.getTranslation(
                                                    TrKeys.youAreAnAdmin),
                                                type: SnackBarType.success,
                                              ),
                                          accessDenied: () {
                                            Navigator.pop(context);
                                            context.router.popUntilRoot();
                                            context.replaceRoute(
                                                const CreateShopRoute());
                                          },
                                        );
                                      },
                                      title: "Apple"),
                                // Add toggle button for email/phone when on Android
                                if (!isIOS)
                                  SocialButton(
                                      iconData: currentSignUpType == SignUpType.phone
                                          ? FlutterRemix.mail_fill
                                          : FlutterRemix.phone_fill,
                                      onPressed: toggleSignUpType,
                                      title: currentSignUpType == SignUpType.phone
                                          ? "Email"
                                          : "Phone"),
                                SocialButton(
                                    iconData: FlutterRemix.facebook_fill,
                                    onPressed: () {
                                      event.loginWithFacebook(
                                        checkYourNetwork: () =>
                                            AppHelpers.showCheckTopSnackBar(
                                              context,
                                              text: AppHelpers.getTranslation(
                                                  TrKeys.checkYourNetworkConnection),
                                            ),
                                        loginSuccess: () {
                                          ref
                                              .read(restaurantProvider.notifier)
                                              .fetchMyShop(
                                            afterFetched: () {
                                              Navigator.pop(context);
                                              context.router.popUntilRoot();
                                              context
                                                  .replaceRoute(const MainRoute());
                                            },
                                          );
                                        },
                                        seller: () =>
                                            AppHelpers.showCheckTopSnackBar(
                                              context,
                                              text: AppHelpers.getTranslation(
                                                  TrKeys.youAreASeller),
                                              type: SnackBarType.success,
                                            ),
                                        admin: () =>
                                            AppHelpers.showCheckTopSnackBar(
                                              context,
                                              text: AppHelpers.getTranslation(
                                                  TrKeys.youAreAnAdmin),
                                              type: SnackBarType.success,
                                            ),
                                        accessDenied: () {
                                          Navigator.pop(context);
                                          context.router.popUntilRoot();
                                          context.replaceRoute(
                                              const CreateShopRoute());
                                        },
                                      );
                                    },
                                    title: "Facebook"),
                                SocialButton(
                                    iconData: FlutterRemix.google_fill,
                                    onPressed: () {
                                      event.loginWithGoogle(
                                        checkYourNetwork: () =>
                                            AppHelpers.showCheckTopSnackBar(
                                              context,
                                              text: AppHelpers.getTranslation(
                                                  TrKeys.checkYourNetworkConnection),
                                            ),
                                        loginSuccess: () {
                                          ref
                                              .read(restaurantProvider.notifier)
                                              .fetchMyShop(
                                            afterFetched: () {
                                              Navigator.pop(context);
                                              context.router.popUntilRoot();
                                              context
                                                  .replaceRoute(const MainRoute());
                                            },
                                          );
                                        },
                                        seller: () =>
                                            AppHelpers.showCheckTopSnackBar(
                                              context,
                                              text: AppHelpers.getTranslation(
                                                  TrKeys.youAreASeller),
                                              type: SnackBarType.success,
                                            ),
                                        admin: () =>
                                            AppHelpers.showCheckTopSnackBar(
                                              context,
                                              text: AppHelpers.getTranslation(
                                                  TrKeys.youAreAnAdmin),
                                              type: SnackBarType.success,
                                            ),
                                        accessDenied: () {
                                          Navigator.pop(context);
                                          context.router.popUntilRoot();
                                          context.replaceRoute(
                                              const CreateShopRoute());
                                        },
                                      );
                                    },
                                    title: "Google"),
                              ],
                            ),
                            22.verticalSpace,
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
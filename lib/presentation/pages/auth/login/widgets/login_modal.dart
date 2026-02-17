import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                            30.verticalSpace,
                            if (AppConstants.isSpecificNumberEnabled)
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
                            if (!AppConstants.isSpecificNumberEnabled)
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
                            32.verticalSpace,
                            if(AppConstants.isDemo)
                            Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Divider(color: Style.shimmerBase),
                                    ),
                                    Padding(
                                      padding:
                                          REdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        AppHelpers.getTranslation(
                                            TrKeys.demoLoginPassword),
                                        style: Style.interNormal(
                                          size: 12.sp,
                                          color: Style.textColor,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Divider(color: Style.shimmerBase),
                                    ),
                                  ],
                                ),
                                22.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    emailController.text =
                                        AppConstants.demoSellerLogin;
                                    passwordController.text =
                                        AppConstants.demoSellerPassword;
                                    event
                                        .setEmail(AppConstants.demoSellerLogin);
                                    event.setPassword(
                                        AppConstants.demoSellerPassword);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${AppHelpers.getTranslation(TrKeys.login)}:',
                                          style: Style.interNormal(
                                              letterSpacing: -0.3),
                                          children: [
                                            TextSpan(
                                              text:
                                                  ' ${AppConstants.demoSellerLogin}',
                                              style: Style.interRegular(
                                                letterSpacing: -0.3,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      6.verticalSpace,
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${AppHelpers.getTranslation(TrKeys.password)}:',
                                          style: Style.interNormal(
                                              letterSpacing: -0.3),
                                          children: [
                                            TextSpan(
                                              text:
                                                  ' ${AppConstants.demoSellerPassword}',
                                              style: Style.interRegular(
                                                letterSpacing: -0.3,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                22.verticalSpace,
                              ],
                            ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/pages/auth/login/widgets/demo_credentials.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/presentation/component/components.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: AppHelpers.getAuthOption() == SignUpType.email ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLtr = LocalStorage.getLangLtr();
    final isDarkMode = LocalStorage.getAppThemeMode();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDisable(
        child: Container(
          margin: MediaQuery.viewInsetsOf(context),
          decoration: BoxDecoration(
            color: AppStyle.greyColor.withOpacity(0.99),
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
                            AppBarBottomSheet(
                              title: AppHelpers.getTranslation(TrKeys.login),
                            ),
                            12.verticalSpace,
                            AuthTabBar(controller: _tabController),
                            SizedBox(
                              height: 76.r,
                              child: TabBarView(
                                controller: _tabController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Directionality(
                                    textDirection: isLtr
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    child: IntlPhoneField(
                                      disableLengthCheck: !AppConstants
                                          .isNumberLengthAlwaysSame,
                                      onChanged: (phoneNum) {
                                        event.setEmail(phoneNum.completeNumber);
                                      },
                                      validator: (s) {
                                        if (state.isLoginError) {
                                          return AppHelpers.getTranslation(
                                            TrKeys.loginCredentialsAreNotValid,
                                          );
                                        }
                                        return null;
                                        // if (AppConstants.isNumberLengthAlwaysSame &&
                                        //     (s?.isValidNumber() ?? true)) {
                                        //   return AppHelpers.getTranslation(
                                        //     TrKeys.phoneNumberIsNotValid,
                                        //   );
                                        // }
                                        // return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      initialCountryCode:
                                          AppConstants.countryCodeISO,
                                      invalidNumberMessage:
                                          AppHelpers.getTranslation(
                                            state.isLoginError
                                                ? TrKeys
                                                      .loginCredentialsAreNotValid
                                                : TrKeys.phoneNumberIsNotValid,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      showCountryFlag: AppConstants.showFlag,
                                      showDropdownIcon:
                                          AppConstants.showArrowIcon,
                                      autovalidateMode: state.isLoginError
                                          ? AutovalidateMode.always
                                          : AppConstants
                                                .isNumberLengthAlwaysSame
                                          ? AutovalidateMode.onUserInteraction
                                          : AutovalidateMode.disabled,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                            const BorderSide(
                                              color: AppStyle.shimmerBase,
                                            ),
                                            const BorderSide(
                                              color: AppStyle.shimmerBase,
                                            ),
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                            const BorderSide(
                                              color: AppStyle.shimmerBase,
                                            ),
                                            const BorderSide(
                                              color: AppStyle.shimmerBase,
                                            ),
                                          ),
                                        ),
                                        border: const UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            const UnderlineInputBorder(),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                            const BorderSide(
                                              color: AppStyle.differBorderColor,
                                            ),
                                            const BorderSide(
                                              color: AppStyle.differBorderColor,
                                            ),
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  UnderlinedTextField(
                                    inputType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.none,
                                    textController: _emailController,
                                    textInputAction: TextInputAction.next,
                                    validator: AppValidators.emailCheck,
                                    label: AppHelpers.getTranslation(
                                      TrKeys.email,
                                    ).toUpperCase(),
                                    onChanged: event.setEmail,
                                    isError:
                                        state.isEmailNotValid ||
                                        state.isLoginError,
                                    descriptionText: state.isLoginError
                                        ? AppHelpers.getTranslation(
                                            TrKeys.loginCredentialsAreNotValid,
                                          )
                                        : state.isEmailNotValid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.emailIsNotValid,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            UnderlinedTextField(
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.none,
                              label: AppHelpers.getTranslation(
                                TrKeys.password,
                              ).toUpperCase(),
                              obscure: state.showPassword,
                              textController: _passwordController,
                              validator: AppValidators.passwordCheck,
                              isError: state.isLoginError,
                              descriptionText: state.isLoginError
                                  ? AppHelpers.getTranslation(
                                      TrKeys.loginCredentialsAreNotValid,
                                    )
                                  : null,
                              suffixIcon: ButtonsBouncingEffect(
                                child: GestureDetector(
                                  onTap: event.toggleShowPassword,
                                  child: Icon(
                                    state.showPassword
                                        ? FlutterRemix.eye_line
                                        : FlutterRemix.eye_close_line,
                                    color: isDarkMode
                                        ? AppStyle.blackColor
                                        : AppStyle.textColor,
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
                                      height: 20.r,
                                      width: 20.r,
                                      child: Checkbox(
                                        side: BorderSide(
                                          color: AppStyle.blackColor,
                                          width: 2.r,
                                        ),
                                        activeColor: AppStyle.blackColor,
                                        value: state.isKeepLogin,
                                        onChanged: (value) =>
                                            event.toggleKeepLogin(),
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      AppHelpers.getTranslation(
                                        TrKeys.keepMeLoggedIn,
                                      ),
                                      style: AppStyle.interNormal(
                                        size: 12,
                                        color: AppStyle.blackColor,
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
                                    index: _tabController.index,
                                    checkYourNetwork: () =>
                                        AppHelpers.showCheckTopSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                            TrKeys.checkYourNetworkConnection,
                                          ),
                                        ),
                                    loginSuccess: () {
                                      ref
                                          .read(restaurantProvider.notifier)
                                          .fetchMyShop(
                                            afterFetched: () {
                                              Navigator.pop(context);
                                              context.router.popUntilRoot();
                                              context.replaceRoute(
                                                const MainRoute(),
                                              );
                                            },
                                          );
                                    },
                                    seller: () =>
                                        AppHelpers.showCheckTopSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                            TrKeys.youAreASeller,
                                          ),
                                          type: SnackBarType.success,
                                        ),
                                    admin: () =>
                                        AppHelpers.showCheckTopSnackBar(
                                          context,
                                          text: AppHelpers.getTranslation(
                                            TrKeys.youAreAnAdmin,
                                          ),
                                          type: SnackBarType.success,
                                        ),
                                    accessDenied: () {
                                      Navigator.pop(context);
                                      context.router.popUntilRoot();
                                      context.replaceRoute(
                                        const CreateShopRoute(),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            24.verticalSpace,
                            if (AppConstants.isDemo)
                              DemoCredentials(
                                onTap: () {
                                  _tabController.animateTo(
                                    1,
                                    duration: Duration(milliseconds: 300),
                                  );
                                  _emailController.text =
                                      AppConstants.demoSellerLogin;
                                  _passwordController.text =
                                      AppConstants.demoSellerPassword;
                                  event.setEmail(AppConstants.demoSellerLogin);
                                  event.setPassword(
                                    AppConstants.demoSellerPassword,
                                  );
                                },
                              ),
                            12.verticalSpace,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../confirmation/register_confirmation_page.dart';

class RegisterModal extends ConsumerStatefulWidget {
  final bool isOnlyEmail;

  const RegisterModal({super.key, required this.isOnlyEmail});

  @override
  ConsumerState<RegisterModal> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeTabController();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeTabController() {
    _tabController = TabController(length: 2, vsync: this);
  }

  void _disposeControllers() {
    _tabController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = ref.read(signUpProvider.notifier);
    final state = ref.watch(signUpProvider);
    final profileState = ref.watch(profileProvider);
    final bool isDarkMode = LocalStorage.getAppThemeMode();
    final bool isLtr = LocalStorage.getLangLtr();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      AppBarBottomSheet(
                        title: AppHelpers.getTranslation(TrKeys.register),
                      ),
                      12.verticalSpace,
                      AuthTabBar(controller: _tabController),
                      SizedBox(
                        height: 80.r,
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Directionality(
                              textDirection: isLtr
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: IntlPhoneField(
                                disableLengthCheck:
                                    !AppConstants.isNumberLengthAlwaysSame,
                                onChanged: (phoneNum) {
                                  event.setPhone(phoneNum.completeNumber);
                                },
                                validator: (s) {
                                  if (state.isLoginError) {
                                    return AppHelpers.getTranslation(
                                      TrKeys.loginCredentialsAreNotValid,
                                    );
                                  }
                                  if (AppConstants.isNumberLengthAlwaysSame &&
                                      (s?.isValidNumber() ?? true)) {
                                    return AppHelpers.getTranslation(
                                      TrKeys.phoneNumberIsNotValid,
                                    );
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                initialCountryCode: AppConstants.countryCodeISO,
                                invalidNumberMessage: AppHelpers.getTranslation(
                                  state.isLoginError
                                      ? TrKeys.loginCredentialsAreNotValid
                                      : TrKeys.phoneNumberIsNotValid,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
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
                                  focusedBorder: const UnderlineInputBorder(),
                                ),
                              ),
                            ),
                            OutlinedBorderTextField(
                              inputType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              textController: _emailController,
                              validation: AppValidators.emailCheck,
                              textInputAction: TextInputAction.next,
                              label: AppHelpers.getTranslation(
                                TrKeys.email,
                              ).toUpperCase(),
                              onChanged: event.setEmail,
                              isError:
                                  state.isEmailInvalid || state.isLoginError,
                              descriptionText: state.isLoginError
                                  ? AppHelpers.getTranslation(
                                      TrKeys.loginCredentialsAreNotValid,
                                    )
                                  : state.isEmailInvalid
                                  ? AppHelpers.getTranslation(
                                      TrKeys.emailIsNotValid,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      if (!widget.isOnlyEmail)
                        Column(
                          children: [
                            (state.verificationId.isEmpty &&
                                    AppConstants.isSpecificNumberEnabled)
                                ? 30.verticalSpace
                                : 0.verticalSpace,
                            (state.verificationId.isEmpty &&
                                    AppConstants.isSpecificNumberEnabled)
                                ? OutlinedBorderTextField(
                                    label: AppHelpers.getTranslation(
                                      TrKeys.email,
                                    ).toUpperCase(),
                                    onChanged: event.setEmail,
                                    isError: state.isEmailInvalid,
                                    descriptionText: state.isEmailInvalid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.cannotBeEmpty,
                                          )
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
                                      TrKeys.firstname,
                                    ).toUpperCase(),
                                    onChanged: (name) =>
                                        event.setFirstName(name),
                                    isError: state.isFirstNameInvalid,
                                    descriptionText: state.isFirstNameInvalid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.cannotBeEmpty,
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      (MediaQuery.sizeOf(context).width - 40) /
                                      2,
                                  child: OutlinedBorderTextField(
                                    label: AppHelpers.getTranslation(
                                      TrKeys.surname,
                                    ).toUpperCase(),
                                    onChanged: (name) => event.setLatName(name),
                                    isError: state.isSurNameInvalid,
                                    descriptionText: state.isSurNameInvalid
                                        ? AppHelpers.getTranslation(
                                            TrKeys.cannotBeEmpty,
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            30.verticalSpace,
                            OutlinedBorderTextField(
                              label: AppHelpers.getTranslation(
                                TrKeys.password,
                              ).toUpperCase(),
                              obscure: state.showPassword,
                              suffixIcon: IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  state.showPassword
                                      ? FlutterRemix.eye_line
                                      : FlutterRemix.eye_close_line,
                                  color: isDarkMode
                                      ? AppStyle.black
                                      : AppStyle.hintColor,
                                  size: 20.r,
                                ),
                                onPressed: () => event.toggleShowPassword(),
                              ),
                              onChanged: (name) => event.setPassword(name),
                              isError: state.isPasswordInvalid,
                              descriptionText: state.isPasswordInvalid
                                  ? AppHelpers.getTranslation(
                                      TrKeys
                                          .passwordShouldContainMinimum6Characters,
                                    )
                                  : null,
                            ),
                            34.verticalSpace,
                            OutlinedBorderTextField(
                              label: AppHelpers.getTranslation(
                                TrKeys.confirmPassword,
                              ).toUpperCase(),
                              obscure: state.showConfirmPassword,
                              suffixIcon: IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  state.showConfirmPassword
                                      ? FlutterRemix.eye_line
                                      : FlutterRemix.eye_close_line,
                                  color: isDarkMode
                                      ? AppStyle.black
                                      : AppStyle.hintColor,
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
                                      TrKeys.confirmPasswordIsNotTheSame,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28.h),
                    child: CustomButton(
                      isLoading: state.isLoading,
                      title: AppHelpers.getTranslation(TrKeys.register),
                      onPressed: () {
                        widget.isOnlyEmail
                            ? (_tabController.index == 1
                                  ? event.sendCode(context, () {
                                      Navigator.pop(context);
                                      AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
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
                                                state.confirmPassword,
                                          ),
                                        ),
                                        isDarkMode: isDarkMode,
                                      );
                                    })
                                  : event.sendCodeToNumber(context, (s) {
                                      Navigator.pop(context);
                                      AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
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
                                                state.confirmPassword,
                                          ),
                                        ),
                                        isDarkMode: isDarkMode,
                                      );
                                    }))
                            : state.verificationId.isEmpty
                            ? event.register(
                                context,
                                profileState.userData?.phone,
                              )
                            : event.registerWithPhone(
                                context,
                                profileState.userData?.phone,
                              );
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

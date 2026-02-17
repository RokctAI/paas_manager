// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../register/register_modal.dart';
import '../reset/set_password_page.dart';

class RegisterConfirmationPage extends ConsumerStatefulWidget {
  final UserModel userModel;
  final bool isResetPassword;
  final String verificationId;

  const RegisterConfirmationPage({
    super.key,
    required this.userModel,
    this.isResetPassword = false,
    required this.verificationId,
  });

  @override
  ConsumerState<RegisterConfirmationPage> createState() =>
      _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState
    extends ConsumerState<RegisterConfirmationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(registerConfirmationProvider);
      ref.read(registerConfirmationProvider.notifier).startTimer();
    });
  }

  @override
  void deactivate() {
    ref.read(registerConfirmationProvider.notifier).disposeTimer();
    super.deactivate();
  }

  void _handleResendCode() {
    final notifier = ref.read(registerConfirmationProvider.notifier);
    if (widget.verificationId.isEmpty) {
      notifier.resendConfirmation(
        context,
        widget.userModel.email ?? "",
        isResetPassword: widget.isResetPassword,
      );
    } else {
      notifier.sendCodeToNumber(context, widget.userModel.email ?? "");
    }
    notifier.startTimer();
  }

  void _handleConfirmCode() {
    final notifier = ref.read(registerConfirmationProvider.notifier);
    final state = ref.read(registerConfirmationProvider);

    if (state.confirmCode.length != 6) return;

    if (widget.isResetPassword) {
      if (widget.verificationId.isEmpty) {
        notifier.confirmCodeResetPassword(
          context,
          widget.userModel.email ?? "",
        );
      } else {
        notifier.confirmCodeResetPasswordWithPhone(
          context,
          widget.userModel.email ?? "",
          widget.verificationId,
        );
      }
    } else {
      if (widget.verificationId.isEmpty) {
        notifier.confirmCode(context);
      } else {
        notifier.confirmCodeWithFirebase(
          context: context,
          verificationId: widget.verificationId,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(registerConfirmationProvider.notifier);
    final state = ref.watch(registerConfirmationProvider);
    final isDarkMode = LocalStorage.getAppThemeMode();
    final isLtr = LocalStorage.getLangLtr();

    ref.listen(registerConfirmationProvider, (previous, next) {
      if (previous!.isSuccess != next.isSuccess && next.isSuccess) {
        Navigator.pop(context);
        AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
          context: context,
          modal: const RegisterModal(isOnlyEmail: false),
          isDarkMode: isDarkMode,
        );
      }
      if (previous.isResetPasswordSuccess != next.isResetPasswordSuccess &&
          next.isResetPasswordSuccess) {
        Navigator.pop(context);
        AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
          context: context,
          modal: const SetPasswordPage(),
          isDarkMode: isDarkMode,
        );
      }
    });

    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading || state.isResending,
        child: KeyboardDisable(
          child: _buildModalContainer(state, notifier, isDarkMode),
        ),
      ),
    );
  }

  Widget _buildModalContainer(
    dynamic state,
    dynamic notifier,
    bool isDarkMode,
  ) {
    return Container(
      padding: MediaQuery.viewInsetsOf(context),
      decoration: _buildModalDecoration(),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: _buildContent(state, notifier, isDarkMode),
        ),
      ),
    );
  }

  BoxDecoration _buildModalDecoration() {
    return BoxDecoration(
      color: AppStyle.greyColor.withOpacity(0.96),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    );
  }

  Widget _buildContent(dynamic state, dynamic notifier, bool isDarkMode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildFormSection(state, notifier, isDarkMode),
        _buildActionSection(state),
      ],
    );
  }

  Widget _buildFormSection(dynamic state, dynamic notifier, bool isDarkMode) {
    return Column(
      children: [
        AppBarBottomSheet(title: AppHelpers.getTranslation(TrKeys.enterOtp)),
        Text(
          AppHelpers.getTranslation(TrKeys.sendOtp),
          style: AppStyle.interRegular(size: 14, color: AppStyle.black),
        ),
        Text(
          widget.userModel.email ?? "",
          style: AppStyle.interRegular(size: 14, color: AppStyle.black),
        ),
        40.verticalSpace,
        SizedBox(
          height: 64,
          child: PinFieldAutoFill(
            codeLength: 6,
            currentCode: state.confirmCode,
            onCodeChanged: notifier.setCode,
            cursor: Cursor(
              width: 1,
              height: 24,
              color: isDarkMode ? AppStyle.white : AppStyle.black,
              enabled: true,
            ),
            decoration: BoxLooseDecoration(
              gapSpace: 10.r,
              textStyle: AppStyle.interNormal(
                size: 15,
                color: isDarkMode ? AppStyle.white : AppStyle.black,
              ),
              bgColorBuilder: FixedColorBuilder(
                isDarkMode ? AppStyle.black : AppStyle.transparent,
              ),
              strokeColorBuilder: FixedColorBuilder(
                state.isCodeError
                    ? AppStyle.red
                    : isDarkMode
                    ? AppStyle.borderColor
                    : AppStyle.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(dynamic state) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom,
        top: 120.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            isLoading: state.isResending,
            title: state.isTimeExpired
                ? AppHelpers.getTranslation(TrKeys.resendOtp)
                : state.timerText,
            onPressed: state.isTimeExpired ? _handleResendCode : null,
            weight: (MediaQuery.sizeOf(context).width - 40) / 3,
            background: AppStyle.black,
            textColor: AppStyle.white,
          ),
          CustomButton(
            isLoading: state.isLoading,
            title: AppHelpers.getTranslation(TrKeys.confirmation),
            onPressed: _handleConfirmCode,
            weight: 2 * (MediaQuery.sizeOf(context).width - 40) / 3,
            background: state.isConfirm ? AppStyle.primary : AppStyle.white,
            textColor: state.isConfirm ? AppStyle.black : AppStyle.black,
          ),
        ],
      ),
    );
  }
}

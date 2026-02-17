import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class SetPasswordPage extends ConsumerWidget {
  const SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);
    final isLtr = LocalStorage.getLangLtr();

    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading,
        child: KeyboardDisable(
          child: _buildModalContainer(context, state, notifier),
        ),
      ),
    );
  }

  Widget _buildModalContainer(
    BuildContext context,
    dynamic state,
    dynamic notifier,
  ) {
    return Container(
      padding: MediaQuery.viewInsetsOf(context),
      decoration: _buildModalDecoration(),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: _buildContent(context, state, notifier),
        ),
      ),
    );
  }

  BoxDecoration _buildModalDecoration() {
    return BoxDecoration(
      color: AppStyle.black.withOpacity(0.5),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic state, dynamic notifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildFormSection(state, notifier),
        _buildActionSection(context, state, notifier),
      ],
    );
  }

  Widget _buildFormSection(dynamic state, dynamic notifier) {
    return Column(
      children: [
        AppBarBottomSheet(
          title: AppHelpers.getTranslation(TrKeys.resetPassword),
        ),
        40.verticalSpace,
        OutlinedBorderTextField(
          label: AppHelpers.getTranslation(TrKeys.password).toUpperCase(),
          obscure: state.showPassword,
          suffixIcon: IconButton(
            splashRadius: 25,
            icon: Icon(
              state.showPassword
                  ? FlutterRemix.eye_line
                  : FlutterRemix.eye_close_line,
              size: 20.r,
            ),
            onPressed: notifier.toggleShowPassword,
          ),
          onChanged: notifier.setPassword,
          isError: state.isPasswordInvalid,
          descriptionText: state.isPasswordInvalid
              ? AppHelpers.getTranslation(
                  TrKeys.passwordShouldContainMinimum6Characters,
                )
              : null,
        ),
        34.verticalSpace,
        OutlinedBorderTextField(
          label: AppHelpers.getTranslation(TrKeys.password).toUpperCase(),
          obscure: state.showConfirmPassword,
          suffixIcon: IconButton(
            splashRadius: 25,
            icon: Icon(
              state.showConfirmPassword
                  ? FlutterRemix.eye_line
                  : FlutterRemix.eye_close_line,
              size: 20.r,
            ),
            onPressed: notifier.toggleShowConfirmPassword,
          ),
          onChanged: notifier.setConfirmPassword,
          isError: state.isConfirmPasswordInvalid,
          descriptionText: state.isConfirmPasswordInvalid
              ? AppHelpers.getTranslation(TrKeys.confirmPasswordIsNotTheSame)
              : null,
        ),
      ],
    );
  }

  Widget _buildActionSection(
    BuildContext context,
    dynamic state,
    dynamic notifier,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom,
        top: 120.h,
      ),
      child: CustomButton(
        isLoading: state.isLoading,
        title: AppHelpers.getTranslation(TrKeys.send),
        onPressed: () => notifier.setResetPassword(context),
        background: AppStyle.green,
        textColor: AppStyle.black,
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/app_assets.dart';
import 'package:venderfoodyman/presentation/pages/auth/languages_modal.dart';

import 'register/register_modal.dart';
import 'login/login_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

@RoutePage()
class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(languagesProvider.notifier).checkLanguage(context),
    );
  }

  void selectLanguage() {
    AppHelpers.showCustomModalBottomSheet(
      isDismissible: false,
      isDrag: false,
      context: context,
      modal: LanguageScreen(afterUpdate: (lang) {}),
      isDarkMode: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    ref.listen(languagesProvider, (previous, next) {
      if (!next.isSelectLanguage &&
          !((previous?.isSelectLanguage ?? false) == next.isSelectLanguage)) {
        selectLanguage();
      }
    });
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imageSplash),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  30.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelpers.getAppName(),
                        style: AppStyle.interBold(
                          color: AppStyle.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Consumer(
                    builder: (context, ref, child) {
                      ref.watch(languagesProvider);
                      return Column(
                        children: [
                          CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.login),
                            onPressed: () =>
                                AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                                  context: context,
                                  modal: const LoginModal(),
                                  isDarkMode: false,
                                ),
                          ),
                          10.verticalSpace,
                          CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.register),
                            onPressed: () {
                              AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                                context: context,
                                modal: const RegisterModal(isOnlyEmail: true),
                                isDarkMode: false,
                              );
                            },
                            background: AppStyle.transparent,
                            textColor: AppStyle.white,
                            borderColor: AppStyle.white,
                          ),
                        ],
                      );
                    },
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

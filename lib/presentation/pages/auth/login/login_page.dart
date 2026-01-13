import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/pages/auth/login/widgets/languages_modal.dart';
import 'package:venderfoodyman/application/providers/app_providers.dart';

import '../register_page.dart';
import 'widgets/login_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(languagesProvider.notifier).checkLanguage(context);
      // Debug print to check initialization state
      print('Remote Config State: ${ref.read(remoteConfigInitializedProvider)}');
    });
  }

  void selectLanguage() {
    AppHelpers.showCustomModalBottomSheet(
        isDismissible: false,
        isDrag: false,
        context: context,
        modal: LanguageScreen(
          afterUpdate: (lang) {},
        ),
        isDarkMode: false);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    final bool isInitialized = ref.watch(remoteConfigInitializedProvider);

    // Debug print
    print('Building LoginPage, isInitialized: $isInitialized');

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
              image: AssetImage(AppAssets.pngSplash),
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
                      Image.asset(
                        AppAssets.pngLogo,
                        width: 30.w,
                        height: 30.h,
                      ),
                      8.horizontalSpace,
                      if (isInitialized)
                        Text(
                          AppHelpers.getAppName(),
                          style: Style.interBold(color: Style.white, size: 24),
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
                            onPressed: () => AppHelpers
                                .showCustomModalBottomSheetWithoutIosIcon(
                              context: context,
                              modal: const LoginModal(),
                              isDarkMode: false,
                            ),
                          ),
                          10.verticalSpace,
                          CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.register),
                            onPressed: () {
                              AppHelpers
                                  .showCustomModalBottomSheetWithoutIosIcon(
                                context: context,
                                modal: const RegisterPage(
                                  isOnlyEmail: true,
                                ),
                                isDarkMode: false,
                              );
                            },
                            background: Style.transparent,
                            textColor: Style.white,
                            borderColor: Style.white,
                          ),
                        ],
                      );
                    },
                  ),
                  30.verticalSpace
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
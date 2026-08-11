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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/presentation/pages/auth/login/widgets/languages_modal.dart';
import 'package:manager/application/providers/app_providers.dart';

import '../register_page.dart';
import 'widgets/login_modal.dart';
import 'package:manager/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:manager/application/providers.dart';
import 'package:manager/infrastructure/services/services.dart';

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
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
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:manager/presentation/routes/app_router.dart';
import 'package:manager/application/providers.dart';
import 'package:manager/infrastructure/services/services.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(splashProvider.notifier).fetchTranslations(
              noConnection: () =>
                  context.replaceRoute(const NoConnectionRoute()),
              goMain: () {
                ref.read(restaurantProvider.notifier).fetchMyShop(
                    afterFetched: () {
                  context.replaceRoute(const MainRoute());
                });
              },
              goLogin: () => context.replaceRoute(const LoginRoute()),
              // become_seller was dropped from the manager shell (Ray ruling
              // in the fork plan): users without a shop go to login instead
              // of the retired create-shop funnel.
              goBecome: () => context.replaceRoute(const LoginRoute()),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Image.asset(AppAssets.pngSplash, fit: BoxFit.cover);
  }
}

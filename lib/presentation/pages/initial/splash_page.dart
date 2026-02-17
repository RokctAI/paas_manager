import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

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
              goBecome: () => context.replaceRoute(const CreateShopRoute()),
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

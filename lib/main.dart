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

// Host main for the composed manager shell. Shaped after base_sdk's
// templates/main.dart (all @generated marker blocks present, so the
// composer's update_main_dependencies()/update_app_routes()/
// update_embedded_widgets() keep working) with the manager app's own startup
// preserved - on a first-ever compose the installer has no hash record and
// would otherwise clobber this file (the paas_driver 760191c lesson), so the
// host copy is committed pre-shaped and the installer warn-skips it.
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
// Deep theme import (not the base_sdk barrel - that arrives via the
// generated sdk-imports block; importing the barrel here too would produce
// a duplicate_import lint on every compose).
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:manager/domain/di/dependency_manager.dart';
import 'package:manager/presentation/app_widget.dart';
import 'package:manager/presentation/routes/orders_adapters.dart';
import 'package:manager/presentation/routes/zones_adapters.dart';
import 'package:manager/utils/app_initializer_widget.dart';
// Direct src/ imports: the manager DI hooks and ADR-005 seam facades are
// role-scoped SDK code, not part of the SDK barrels (commerce#3 host-consume
// notes).
import 'package:merchants_sdk/src/manager/di/manager_merchants_di.dart';
import 'package:orders_sdk/src/manager/di/manager_orders_di.dart';
import 'package:orders_sdk/src/manager/domain/interface/pos_customers.dart';
import 'package:orders_sdk/src/manager/domain/interface/pos_sections_tables.dart';

// @generated-sdk-imports-start
import 'package:base_sdk/base_sdk.dart';
import 'package:auth_sdk/auth_sdk.dart';
import 'package:calc_sdk/calc_sdk.dart';
import 'package:comms_sdk/comms_sdk.dart';
import 'package:corporate_sdk/corporate_sdk.dart';
import 'package:hardware_sdk/hardware_sdk.dart';
import 'package:kitchen_sdk/kitchen_sdk.dart';
import 'package:map_sdk/map_sdk.dart';
import 'package:merchants_sdk/merchants_sdk.dart';
import 'package:orders_sdk/orders_sdk.dart';
import 'package:payments_sdk/payments_sdk.dart';
import 'package:processing_sdk/processing_sdk.dart';
import 'package:productivity_sdk/productivity_sdk.dart';
import 'package:products_sdk/products_sdk.dart';
import 'package:promotions_sdk/promotions_sdk.dart';
import 'package:revenue_sdk/revenue_sdk.dart';
import 'package:subscriptions_sdk/subscriptions_sdk.dart';
import 'package:users_sdk/users_sdk.dart';
import 'package:weather_sdk/weather_sdk.dart';
import 'package:zones_sdk/zones_sdk.dart';
// @generated-sdk-imports-end

// Wiring imports: each SDK manifest's app_routes / embedded_widgets /
// brand_hook entries may carry an "imports" list of FULL import lines; they
// land here (deduped, sorted) so the injected bodies' symbols resolve
// without any hand-written imports in this file.
// @generated-wiring-imports-start
import 'package:auto_route/auto_route.dart';
import 'package:manager/presentation/components/weather/weather_widget.dart';
import 'package:manager/presentation/routes/app_router.dart';
// @generated-wiring-imports-end

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Host-specific startup (kept through the compose flip): the splash is
  // held until the router decides where to go, Firebase must be initialized
  // before anything touches messaging.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Brand hook: at most ONE installed SDK (normally the home SDK) declares
  // "brand_hook" in its manifest and its call is injected here to load the
  // app's brand palette into the shared AppStyle tokens before the first
  // frame. The kernel ships neutral defaults only.
  // @generated-brandhook-start

  // @generated-brandhook-end

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppStyle.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppStyle.transparent,
      systemNavigationBarDividerColor: AppStyle.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await LocalStorage.init();
  // base_sdk's import and DI registration are injected into the generated
  // blocks (base_sdk first - update_main_dependencies() orders it ahead of
  // every feature SDK). Do NOT also import/register it by hand up here.
  // @generated-sdk-di-start
  BaseSdkDependencies.register(GetIt.instance);
  AuthSdkDependencies.register(GetIt.instance);
  CalcSdkDependencies.register(GetIt.instance);
  CommsSdkDependencies.register(GetIt.instance);
  CorporateSdkDependencies.register(GetIt.instance);
  HardwareSdkDependencies.register(GetIt.instance);
  KitchenSdkDependencies.register(GetIt.instance);
  MapSdkDependencies.register(GetIt.instance);
  MerchantsSdkDependencies.register(GetIt.instance);
  OrdersSdkDependencies.register(GetIt.instance);
  PaymentsSdkDependencies.register(GetIt.instance);
  ProcessingSdkDependencies.register(GetIt.instance);
  ProductivitySdkDependencies.register(GetIt.instance);
  ProductsSdkDependencies.register(GetIt.instance);
  PromotionsSdkDependencies.register(GetIt.instance);
  RevenueSdkDependencies.register(GetIt.instance);
  SubscriptionsSdkDependencies.register(GetIt.instance);
  UsersSdkDependencies.register(GetIt.instance);
  WeatherSdkDependencies.register(GetIt.instance);
  ZonesSdkDependencies.register(GetIt.instance);
// @generated-sdk-di-end

  // ---- Host-owned DI ----
  // Deliberately OUTSIDE the generated block: update_sdk_di() rewrites
  // everything between the markers on every compose, so anything placed
  // inside is silently lost. The installer detects hand edits to main.dart
  // and stops overwriting the file, which is what keeps this section alive.

  // The manager app's own repositories (auth, settings, users, notification,
  // ... - see dependency_manager.dart). Must run before the adapters below,
  // which resolve the users repository.
  await setUpDependencies();

  // Manager role DI hooks (commerce#3): orders_sdk's seller-orders/POS
  // repositories and merchants_sdk's seller-shop/sections-tables
  // repositories. Both are idempotent (isRegistered-guarded).
  ManagerOrdersDependencies.register(GetIt.instance);
  ManagerMerchantsDependencies.register(GetIt.instance);

  // ADR-005 seam adapters, registered per the instructions inside the
  // installed adapter files. Without these the POS section/table/customer
  // providers and the delivery-zone provider fall back to 501 "not wired"
  // stand-ins.
  GetIt.instance.registerLazySingleton<PosSectionsTablesFacade>(
    () => ManagerPosSectionsTablesAdapter(),
  );
  GetIt.instance.registerLazySingleton<PosCustomersFacade>(
    () => ManagerPosCustomersAdapter(),
  );
  // zones_sdk: the shop's catchment polygon lives behind the host's users
  // repository (see zones_adapters.dart). No ZoneEditPolicy registration,
  // deliberately: a merchant editing their own shop's zone is unrestricted,
  // and registering nothing is the contract's way to say so.
  GetIt.instance.registerLazySingleton<DeliveryZonesFacade>(
    () => ManagerDeliveryZonesAdapter(),
  );

  // AppRoutes.I: SDK-resident code (splash, auth flows) navigates through
  // this indirection since it can't reference host-generated route classes
  // directly. Methods are injected per-SDK from each manifest's "app_routes"
  // list; anything not injected keeps throwing a descriptive StateError via
  // noSuchMethod rather than failing silently.
  //
  // EmbeddedWidgets.I: same indirection for host-composed widgets - SDK code
  // renders another SDK's pages/widgets through it without importing that
  // SDK directly (ADR-005), e.g. weather_sdk's header widget.
  EmbeddedWidgets.I = _HostEmbeddedWidgets();
  AppRoutes.I = _HostAppRoutes();

  runApp(
    const ProviderScope(
      child: AppInitializerWidget(
        child: AppWidget(),
      ),
    ),
  );
}

class _HostEmbeddedWidgets implements EmbeddedWidgets {
  // @generated-embeddedwidgets-start
  @override
  Widget policyPage() {
    return const PolicyPage();
  }

  @override
  Widget termPage() {
    return const TermPage();
  }

  @override
  Widget weatherHeaderWidget() {
    return const AppWeatherWidget(inlineExpansion: false);
  }

  // @generated-embeddedwidgets-end

  @override
  dynamic noSuchMethod(Invocation invocation) => throw StateError(
      'EmbeddedWidgets.I.${invocation.memberName} has not been implemented — '
      'no installed SDK declares it in "embedded_widgets", and it was not '
      'added by hand in main.dart.');
}

class _HostAppRoutes implements AppRoutes {
  // @generated-approutes-start
  @override
  Future<Object?> replaceSplashRoute(BuildContext context) =>
      context.router.replace(SplashRoute());

  @override
  Future<Object?> replaceNoConnectionRoute(BuildContext context) =>
      context.router.replace(NoConnectionRoute());

  @override
  Future<Object?> replaceClosedRoute(BuildContext context) =>
      context.router.replace(ClosedRoute());

  @override
  Future<Object?> replaceUiTypeRoute(BuildContext context) =>
      context.router.replace(UiTypeRoute());

  @override
  Future<Object?> replaceLoginRoute(BuildContext context) =>
      context.router.replace(LoginRoute());

  // @generated-approutes-end

  @override
  dynamic noSuchMethod(Invocation invocation) => throw StateError(
      'AppRoutes.I.${invocation.memberName} has not been implemented — no '
      'installed SDK declares it in "app_routes", and it was not added by '
      'hand in main.dart.');
}

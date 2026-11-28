// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

// Render harness for the Manager shell, from
// RokctAI/shared-workflows templates/render-harness/render_screen_test.dart.
// Conventions, numbering rules and the status vocabulary live in that repo at
// scripts/render/README.md.
//
// What this is: a widget test that renders a REAL screen of this shell at
// phone size, writes a PNG of it, and writes a sidecar JSON of every element
// rect the review points a number at. `.github/workflows/render-strip.yml`
// runs it on demand and composes the results into one review page.
//
// The screen: auth_sdk's sign-in route (LoginPage, with its LoginScreen sheet
// opened on top) - the first screen a Manager user sees. The PAGE is rendered,
// not the sheet alone: the page is what paints the full-bleed splash artwork,
// the app-name logo and the Skip affordance, and the sheet is only ever
// reached by tapping the page's own Login button. Chosen because it is the one
// manager-shell surface that
// renders FULLY POPULATED from the SDKs' own demo fixtures with no live
// backend: the harness activates a demo session, AuthSdkDependencies installs
// the real auth repository (base_sdk's DemoGatewayInterceptor answers its
// platform calls from auth_sdk's fixtures), and every string on it resolves
// offline
// through base_sdk's BundledTranslations. See test/render/strip.json's notes
// for why the manager-role screens (POS, order queue, restaurant profile) are
// not the proof frame.
//
// The harness renders demo/seed fixtures and is never wired to a live client
// or backend.
//
// Fidelity rule this file exists to keep: render the screen the app renders,
// wrapper included. A harness that supplies its own wrapper is drawing a
// picture of the app, not photographing it - see buildScreen's doc comment for
// the revision of this harness that got that wrong and what it cost.
//
// Run:  flutter test test/render/render_screen_test.dart
//       RENDER_SUFFIX=_draft flutter test test/render/render_screen_test.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:base_sdk/src/di/base_di.dart';
import 'package:base_sdk/src/models/response/languages_response.dart';
import 'package:base_sdk/src/presentation/components/app_bars/app_bar_bottom_sheet.dart';
import 'package:base_sdk/src/presentation/components/buttons/custom_button.dart';
import 'package:base_sdk/src/presentation/components/buttons/forgot_text_button.dart';
import 'package:base_sdk/src/presentation/components/buttons/social_button.dart';
import 'package:base_sdk/src/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:base_sdk/src/presentation/components/buttons/second_button.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/demo_session.dart';
import 'package:base_sdk/src/services/local_storage.dart';

import 'package:auth_sdk/src/common/di/auth_di.dart';
import 'package:auth_sdk/src/common/presentation/pages/auth/login/login_screen.dart';
import 'package:auth_sdk/src/common/presentation/pages/auth/login/login_page.dart';
import 'package:comms_sdk/src/common/di/comms_di.dart';
import 'package:users_sdk/src/common/di/users_di.dart';
import 'package:booking_sdk/src/common/di/booking_di.dart';
import 'package:booking_sdk/src/manager/di/manager_booking_di.dart';
import 'package:merchants_sdk/src/common/di/merchants_di.dart';
import 'package:merchants_sdk/src/manager/di/manager_merchants_di.dart';
import 'package:orders_sdk/src/common/di/orders_di.dart';
import 'package:orders_sdk/src/manager/di/manager_orders_di.dart';
import 'package:products_sdk/src/common/di/products_di.dart';

// Tour screens: one entry per guided-tour step that an SDK's render fragment
// (templates/render/*.render.yaml) binds by name. Written by shared-workflows'
// merge_render_fragments.py on every strip run; the committed copy is an empty
// stub so this test compiles (and renders only the shell's own screen).
import 'render_screens.g.dart';

// ---------------------------------------------------------------------------
// Render settings - phone size the reviews are judged at. Only change these
// if the whole review is moving to a different device class.
// ---------------------------------------------------------------------------

/// Logical width of the frame (iPhone-class phone). The strip composer scales
/// the PNG to the bezel, so this only affects LAYOUT, not output resolution.
const double kLogicalWidth = 390;

/// Device pixel ratio the PNG is captured at (3 = @3x, crisp on any display).
const double kDevicePixelRatio = 3.0;

/// Tall probe viewport for the first pass. Must exceed the tallest screen; the
/// second pass shrinks to the measured content height.
const double kProbeHeight = 2600;

/// Slack below the last element in the final frame, in logical pixels.
/// Only used when the frame shrinks to its content.
/// Height of a generated tour screen's frame: one phone screen, as the tour's
/// own stills capture it.
const double kGeneratedHeight = 844;

const double kBottomPadding = 20;

/// Whether the frame shrinks to its measured content, as the shared template
/// does, or is pinned to [kFrameHeight].
///
/// Deviation from the template, and the reason for it. The template renders a
/// long page as a full-length strip: it measures the content in a tall probe
/// viewport, then re-renders at exactly that height. That is a fixed point
/// only when content height is independent of viewport height. This screen is
/// a MODAL BOTTOM SHEET laid out with `flutter_screenutil`, whose `.h` sizes
/// are a fraction OF THE VIEWPORT - so every shrink pass shrinks the content
/// too, and iterating converges downward onto a squashed sheet (measured:
/// 439 logical px, with the keep-logged-in checkbox down to 11px) that no
/// phone ever draws. A sheet has a device-sized frame by definition, so this
/// one is pinned to an iPhone-class phone viewport instead - which is also
/// the height the sheet's own `maxHeight: screenHeight - 200` is taken from.
const bool kShrinkToContent = false;

/// Frame height in logical pixels when [kShrinkToContent] is false.
const double kFrameHeight = 844;

/// The SDKs' own demo data. THIS IS THE MAIN PATH.
///
/// Every SDK ships `<cmd>.json` fixtures and registers them from its own DI.
/// The harness activates a demo session (in [renderVariant]) and calls the DI
/// registrations in the same order the composed `main.dart` does: base first,
/// then each feature SDK. They register their REAL repositories, and base_sdk's
/// DemoGatewayInterceptor answers every platform cmd from the fixtures, so
/// `loginProvider` is backed by the same auth repository a demo session of
/// Manager uses.
///
/// Only the SDKs this screen's widget tree actually resolves are registered;
/// the manager-role hooks (`ManagerOrdersDependencies`,
/// `ManagerMerchantsDependencies`) are deliberately absent - see the note in
/// strip.json.
Future<void> registerDemoDependencies() async {
  assert(
    DemoSession.demoActive,
    'demo session not active: the real repositories would call a live '
    'backend and the render is of a broken, empty screen',
  );
  BaseSdkDependencies.register(GetIt.I);
  AuthSdkDependencies.register(GetIt.I);
  UsersSdkDependencies.register(GetIt.I);
  CommsSdkDependencies.register(GetIt.I);
}

/// The SDKs the guided tour's manager screens resolve (order history, POS
/// products, loads, drivers, reservations), mirroring main.dart's generated
/// DI hooks. Registered only for generated tour screens, so the login
/// sheet's own frames are unchanged. Without them each screen throws a GetIt
/// "not registered" StateError and is skipped (paas_manager run 44811013166).
void registerTourDependencies() {
  MerchantsSdkDependencies.register(GetIt.I);
  ProductsSdkDependencies.register(GetIt.I);
  OrdersSdkDependencies.register(GetIt.I);
  BookingSdkDependencies.register(GetIt.I);
  ManagerOrdersDependencies.register(GetIt.I);
  ManagerMerchantsDependencies.register(GetIt.I);
  ManagerBookingDependencies.register(GetIt.I);
}

/// EXCEPTION: device history the demo mode cannot supply.
///
/// Empty, and expected to stay empty for this screen: the sign-in sheet reads
/// no store the device accumulates through use.
Future<void> seedDeviceHistory(WidgetTester tester) async {}

/// EXCEPTION: stub a service with no demo implementation.
///
/// Empty. Everything this screen resolves goes through the platform gateway,
/// so its SDK's fixtures answer it.
void registerExceptionStubs() {}

/// Register sections / routes / gates.
///
/// The sign-in sheet has no registry or gate of its own; the app-wide state it
/// reads (language, theme) is set per variant in [renderVariant].
void registerScreen() {}

/// The widget under test: auth_sdk's real [LoginPage] - the whole sign-in
/// route, not just the sheet.
///
/// It is the PAGE because the sheet is not a screen. `LoginScreen` is reached
/// exactly one way in the app: as the `modal:` argument of
/// `AppHelpers.showCustomModalBottomSheet`, called from the Login button of
/// `LoginPage` - the only reference to the class anywhere in auth_sdk. The
/// page underneath is what paints the sign-in surface. On a compact window it
/// draws the app's splash artwork FULL-BLEED behind everything
/// (`AssetImage(splashImage)` over `assets/images/splash*.png`, picked by
/// date in `_LoginPageState.initState`), and above that the app-name logo,
/// the Skip affordance and the Login/Register buttons.
///
/// Why this is spelled out: an earlier revision of this harness pumped
/// `LoginScreen` alone as the body of a bare `Scaffold`. Every widget in that
/// frame was real, and the frame was still not the app - no splash image, no
/// logo, no Skip, no scrim, the sheet floating on a flat surface no build of
/// Manager has ever drawn. Rendering a real widget is not the same as
/// rendering the real screen; the wrapper is part of the screen. [openSheet]
/// opens the sheet the way the Login button does, so what the PNG shows is
/// the app's own composition: real page, real barrier, real sheet.
Widget buildScreen({required bool dark, Widget? screen}) {
  return ProviderScope(
    child: ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // The app's OWN two ThemeDatas, copied from base_sdk's
        // templates/app_widget.dart (the template this shell's
        // lib/app_widget.dart is composed from) - both of them, plus the
        // themeMode that chooses between them.
        //
        // This used to be one ThemeData with `brightness: dark ? dark :
        // light`, which is NOT the app's dark theme: it is the LIGHT theme
        // with a flag flipped. Material derives most of a ThemeData from
        // `brightness`, but the app's dark theme is not derived - it pins
        // `scaffoldBackgroundColor: AppStyle.surfaceDarkRaw` and the shared
        // `systemOverlayStyle`, and a synthesised theme has neither. Anything
        // that styles itself from the ambient theme rather than from an
        // AppStyle token therefore rendered in colours the app never shows,
        // and the dark frame reviewed a product that does not exist.
        //
        // paas_driver and minilauncher already wire both themes; this shell
        // was the odd one out. Copy the app's arguments; do not synthesise
        // them from a flag.
        theme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppStyle.surfaceLightRaw,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: AppStyle.systemUiOverlay,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppStyle.surfaceDarkRaw,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: AppStyle.systemUiOverlay,
          ),
        ),
        // The app reads this from AppNotifier's isDarkMode; the harness sets
        // the same stored value in renderVariant before the first pump, so
        // both sides of the frame agree on which theme is active.
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        home: screen ?? const LoginPage(),
      ),
    ),
  );
}

/// Opens the sign-in sheet the way the app opens it: by tapping [LoginPage]'s
/// Login button, which calls `AppHelpers.showCustomModalBottomSheet` with
/// `const LoginScreen()`.
///
/// Driving the real button rather than pushing a route by hand is the point -
/// the sheet's constraints, its `maxHeight: screenHeight - 200`, its rounded
/// shape and its scrim all come from the app's own call site, so none of them
/// can drift away from what ships without this test noticing.
Future<void> openSheet(WidgetTester tester) async {
  final loginButton = find.widgetWithText(
    CustomButton,
    AppHelpers.getTranslation(TrKeys.login),
  );
  expect(
    loginButton,
    findsWidgets,
    reason: 'no Login button on LoginPage - the sheet cannot be opened the '
        'way the app opens it',
  );
  await tester.tap(loginButton.first, warnIfMissed: false);
  await _drain(tester, rounds: 4);
  expect(
    find.byType(LoginScreen),
    findsOneWidget,
    reason: 'tapping Login did not put the sign-in sheet on screen',
  );
}

/// Scopes a finder to the sheet's own subtree.
///
/// Required now that the real page is behind the sheet: `LoginPage` has
/// `CustomButton`s of its own (Login, Register), and an unscoped
/// `find.byType(CustomButton)` labels them all "Sign-in button - primary
/// action" - three numbered points on one frame, two of them wrong.
Finder _inSheet(Finder matching) =>
    find.descendant(of: find.byType(LoginScreen), matching: matching);

/// The full-bleed splash artwork [LoginPage] paints behind everything on a
/// compact window: the `Container` whose `BoxDecoration.image` is the
/// `AssetImage(splashImage)` resolved in `_LoginPageState.initState`.
///
/// Matched by the decoration rather than by a key so it keeps pointing at the
/// real backdrop if the widget around it is refactored - and so the review
/// FAILS LOUD (no rect, no numbered point) if the image ever stops being
/// painted, which is the regression this whole spec exists to catch.
Finder _splashBackdrop() => find.descendant(
      of: find.byType(LoginPage),
      matching: find.byWidgetPredicate((w) {
        if (w is! Container) return false;
        final decoration = w.decoration;
        return decoration is BoxDecoration && decoration.image != null;
      }),
    );

/// The elements the review points at.
///
/// `key` is the STABLE IDENTITY the strip composer binds a number to for the
/// life of the page. Reword `label` freely; never reword `key`.
List<ElementSpec> elementSpecs() {
  return <ElementSpec>[
    // --- the page behind the sheet -----------------------------------------
    ElementSpec(
      key: 'auth.login.page_backdrop',
      label: 'Splash artwork - full-bleed behind the sheet',
      finder: _splashBackdrop(),
    ),
    ElementSpec(
      key: 'auth.login.page_skip',
      label: 'Skip - continue without an account',
      finder: find.byType(SecondButton),
    ),
    // --- the sheet ----------------------------------------------------------
    // Every finder below is scoped to the sheet subtree: the page behind it
    // has widgets of the same types (CustomButton most of all).
    ElementSpec(
      key: 'auth.login.sheet_header',
      label: 'Sheet header - title and close affordance',
      finder: _inSheet(find.byType(AppBarBottomSheet)),
    ),
    ElementSpec(
      key: 'auth.login.phone_field',
      label: 'Phone field - country picker, flag, dial code',
      finder: _inSheet(find.byType(IntlPhoneField)),
    ),
    ElementSpec.each(
      keyOf: (i, w) =>
          'auth.login.text_field.${(w as OutlinedBorderTextField).label}',
      labelOf: (i, w) =>
          'Text field - ${(w as OutlinedBorderTextField).label ?? 'unlabelled'}',
      finder: _inSheet(find.byType(OutlinedBorderTextField)),
    ),
    ElementSpec(
      key: 'auth.login.keep_logged',
      label: 'Keep me logged in - checkbox',
      finder: _inSheet(find.byType(Checkbox)),
    ),
    ElementSpec(
      key: 'auth.login.forgot_password',
      label: 'Forgot password - opens the reset sheet',
      finder: _inSheet(find.byType(ForgotTextButton)),
    ),
    ElementSpec(
      key: 'auth.login.submit',
      label: 'Sign-in button - primary action',
      finder: _inSheet(find.byType(CustomButton)),
    ),
    ElementSpec.each(
      keyOf: (i, w) => 'auth.login.social.${(w as SocialButton).title}',
      labelOf: (i, w) => 'Quick access - ${(w as SocialButton).title}',
      finder: _inSheet(find.byType(SocialButton)),
    ),
  ];
}

/// Real fonts.
///
/// Without this every glyph renders as the Ahem/FlutterTest block font and the
/// PNG is worthless.
///
/// Inter and Montserrat - the two families base_sdk's `AppStyle` asks
/// `google_fonts` for - are NOT loaded here: they are committed as app assets
/// under `assets/google_fonts/` (see that directory's README), which is the
/// path `google_fonts` itself checks before it reaches for the network. That
/// is deliberate. `GoogleFonts.config.allowRuntimeFetching = false` makes the
/// package THROW when a face is neither in assets nor on the device, and the
/// throw happens inside a future the test cannot catch - so registering the
/// families with a bare [FontLoader] is not enough to keep the run green.
///
/// What is left for this function is everything `google_fonts` does not own:
/// the icon fonts and the bare-`TextStyle` fallback family.
Future<void> loadRealFonts() async {
  Future<void> loadFiles(String family, List<String> paths) async {
    final loader = FontLoader(family);
    var any = false;
    for (final path in paths) {
      final file = File(path);
      if (!file.existsSync()) continue;
      loader.addFont(
        Future<ByteData>.value(ByteData.view(file.readAsBytesSync().buffer)),
      );
      any = true;
    }
    if (any) await loader.load();
  }

  Future<void> loadAsset(String family, String assetKey) async {
    try {
      final data = await rootBundle.load(assetKey);
      await (FontLoader(family)..addFont(Future<ByteData>.value(data))).load();
    } catch (e) {
      debugPrint('==> render harness: no asset font at $assetKey ($e)');
    }
  }

  // Bare TextStyles with no family fall back to the platform default, which
  // ships inside the Flutter SDK cache alongside MaterialIcons.
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot != null) {
    final materialFonts = '$flutterRoot/bin/cache/artifacts/material_fonts';
    await loadFiles('MaterialIcons', [
      '$materialFonts/MaterialIcons-Regular.otf',
    ]);
    await loadFiles('Roboto', [
      '$materialFonts/Roboto-Regular.ttf',
      '$materialFonts/Roboto-Medium.ttf',
      '$materialFonts/Roboto-Bold.ttf',
    ]);
  }

  // Package icon fonts are registered under their package-scoped family name.
  // Read through the asset bundle rather than the pub cache so the path does
  // not depend on where pub happens to have unpacked the package.
  await loadAsset(
    'packages/remixicon/Remix',
    'packages/remixicon/fonts/Remix.ttf',
  );
  await loadAsset(
    'packages/flutter_remix/FlutterRemix',
    'packages/flutter_remix/lib/fonts/FlutterRemix.ttf',
  );
}

// ===========================================================================
// Below here is the proven mechanism from the shared template. Leave it alone.
// ===========================================================================

/// Render-time errors the frame is allowed to EXPOSE rather than die on.
///
/// A review frame's whole value is that it disagrees with what the code was
/// believed to do, and two of the ways real code disagrees are a `RenderFlex`
/// overflow and a plugin that has no headless implementation. `flutter_test`
/// turns both into a failed test and no PNG, which would mean the harness can
/// only ever render screens that are already perfect - the opposite of the
/// point. So these two, and ONLY these two, are collected, printed, and
/// written into the sidecar as `warnings` for the strip's notes to quote.
/// Anything else still fails the run.
final List<String> renderWarnings = <String>[];

bool _isExposableRenderError(FlutterErrorDetails details) {
  final Object exception = details.exception;
  if (exception is MissingPluginException) return true;
  return exception is FlutterError &&
      exception.toString().contains('overflowed by');
}

/// One numbered point: a finder, a stable key, and a human label.
class ElementSpec {
  ElementSpec({required this.key, required this.label, required this.finder})
      : keyOf = null,
        labelOf = null;

  /// A finder that matches SEVERAL widgets (e.g. every social button); key and
  /// label are derived per match, so the numbering stays per-row.
  ElementSpec.each({
    required this.keyOf,
    required this.labelOf,
    required this.finder,
  })  : key = '',
        label = '';

  final String key;
  final String label;
  final Finder finder;
  final String Function(int index, Widget widget)? keyOf;
  final String Function(int index, Widget widget)? labelOf;
}

class _Measured {
  _Measured(this.key, this.label, this.rect);

  final String key;
  final String label;
  final Rect rect;
}

/// Mocks the path_provider channel so real drift/sqlite stores can open a
/// database in a temp dir. This is the ONLY platform channel the harness
/// fakes - everything else runs its real code path.
void _mockPathProvider(String dir) {
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (call) async => dir);
}

/// Answers connectivity_plus the way a phone on Wi-Fi does.
///
/// `LoginPage` asks for the language list as it initialises
/// (`LoginNotifier.checkLanguage` -> `AppConnectivity.connectivity()`), and
/// with no plugin behind the channel that call raises a
/// `MissingPluginException` after the test body has returned, which fails the
/// run. `['wifi']` is the honest answer for the device this frame stands in
/// for; the request that follows it is served by the SDKs' own demo
/// repositories, never the network.
void _mockConnectivity() {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  messenger.setMockMethodCallHandler(
    const MethodChannel('dev.fluttercommunity.plus/connectivity'),
    (call) async => <String>['wifi'],
  );
  // The status stream is an EventChannel; its listen/cancel arrive as method
  // calls on the channel's own name.
  messenger.setMockMethodCallHandler(
    const MethodChannel('dev.fluttercommunity.plus/connectivity_status'),
    (call) async => null,
  );
}

/// Lets REAL async work (drift isolate, futures, file IO) complete, then pumps
/// frames so the resulting setStates land.
///
/// `pumpAndSettle` cannot do this: widget-test fake-async never runs the real
/// event loop, so a screen that waits on a real Future settles as empty.
Future<void> _drain(WidgetTester tester, {int rounds = 8}) async {
  for (var i = 0; i < rounds; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 120)),
    );
    await tester.pump(const Duration(milliseconds: 250));
  }
}

List<_Measured> _measure(WidgetTester tester, List<ElementSpec> specs) {
  final measured = <_Measured>[];
  for (final spec in specs) {
    // A chip finder narrowed with `.first` throws when nothing matches; a
    // point that is not on the frame is dropped, never failing the render.
    final List<Element> elements;
    try {
      elements = spec.finder.evaluate().toList();
    } catch (_) {
      continue;
    }
    for (var i = 0; i < elements.length; i++) {
      try {
        final widget = elements[i].widget;
        measured.add(
          _Measured(
            spec.keyOf?.call(i, widget) ?? spec.key,
            spec.labelOf?.call(i, widget) ?? spec.label,
            tester.getRect(spec.finder.at(i)),
          ),
        );
      } catch (_) {
        // Off-stage or unlaid-out matches are skipped rather than failing the
        // render: a section hidden by a gate is a legitimate outcome.
      }
    }
  }

  // Top-to-bottom, then drop wrappers that share a rect with a more specific
  // match (a decorated card whose child is the row we already measured).
  //
  // Deviation from the shared template, and the reason for it: the template
  // compares only `top` and `height`, which also collapses elements that sit
  // SIDE BY SIDE. On this screen the three quick-access buttons share a row,
  // so two of the three vanished from the sidecar while being plainly visible
  // in the PNG. Comparing the full rect still catches the wrapper case it was
  // written for - a wrapper shares its child's whole rect, not just its band.
  measured.sort((a, b) => a.rect.top.compareTo(b.rect.top));
  final deduped = <_Measured>[];
  for (final item in measured) {
    final clash = deduped.any(
      (kept) =>
          (kept.rect.top - item.rect.top).abs() < 2 &&
          (kept.rect.height - item.rect.height).abs() < 4 &&
          (kept.rect.left - item.rect.left).abs() < 2 &&
          (kept.rect.width - item.rect.width).abs() < 4,
    );
    if (!clash) deduped.add(item);
  }
  return deduped;
}

/// Renders one variant end to end and writes out/<name>.png + out/<name>.json.
Future<void> renderVariant(
  WidgetTester tester, {
  required bool dark,
  required String name,
  required String dbDir,
  // A tour screen from kGeneratedScreens: its widget and the finder that
  // proves it is on screen. When set, the shell's own specs
  // (elementSpecs/verifyFinders) do not apply - the frame is the whole screen
  // at one phone height, chipped only by kTourScreenChips.
  Widget Function()? screen,
  Finder Function()? screenFinder,
  List<ElementSpec> Function()? screenChips,
}) async {
  final outDir = Directory('${Directory.current.path}/out')
    ..createSync(recursive: true);

  // Each variant starts from nothing: rootBundle caches every loadString
  // future, and a load a previous variant never finished would be awaited
  // forever by the next one.
  rootBundle.clear();

  final void Function(FlutterErrorDetails)? previousOnError =
      FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (_isExposableRenderError(details)) {
      final String summary = details.exceptionAsString().split('\n').first;
      if (!renderWarnings.contains(summary)) renderWarnings.add(summary);
      debugPrint('==> render harness exposed: $summary');
      return;
    }
    previousOnError?.call(details);
  };
  addTearDown(() => FlutterError.onError = previousOnError);

  // The manager shell ships to Android/iOS; `flutter test` reports the host
  // (Linux), and auth_sdk's own platform guards hide the Google/Facebook
  // quick-access buttons off-mobile. Without this the frame would review a
  // desktop variant of the sheet nobody installs on a phone.
  // Reset before the test body returns, not in addTearDown: flutter_test
  // verifies the foundation debug vars are unset BEFORE tearDowns run.
  debugDefaultTargetPlatformOverride = TargetPlatform.android;

  _mockPathProvider(dbDir);
  _mockConnectivity();

  // App-wide state the screen reads before it builds. Mirrors the guided
  // tour's own setup block (tour/app.tour.yaml): the language must be seeded
  // or base_sdk's BundledTranslations has no locale to resolve against and
  // every label on the sheet renders as a humanised key.
  SharedPreferences.setMockInitialValues(<String, Object>{});
  await tester.runAsync(() async {
    await LocalStorage.init();
    // Demo on: the mock preferences above start empty, so the persisted flag
    // is set again for each variant. DemoGatewayInterceptor reads it.
    await DemoSession.instance.activate();
    if (LocalStorage.getLanguage() == null) {
      await LocalStorage.setLanguageData(
        LanguageData(
          id: '1',
          title: 'English',
          locale: 'en',
          backward: false,
          isDefault: true,
          active: true,
        ),
      );
      await LocalStorage.setLanguageSelected(true);
      await LocalStorage.setLangLtr(false);
    }
    await LocalStorage.setAppThemeMode(dark);
  });
  AppStyle.setBrightness(dark ? Brightness.dark : Brightness.light);

  await tester.runAsync(_loadRealFontsOnce);

  // Order matters. Exception stubs go into GetIt FIRST so the SDKs' guarded
  // registrations stand aside; then the SDKs register their own demo
  // implementations; then any device history the demo mode cannot supply.
  registerExceptionStubs();
  await tester.runAsync(registerDemoDependencies);
  if (screen != null)
    await tester.runAsync(() async => registerTourDependencies());
  await seedDeviceHistory(tester);
  registerScreen();

  tester.view.physicalSize = Size(
    kLogicalWidth * kDevicePixelRatio,
    (kShrinkToContent ? kProbeHeight : kFrameHeight) * kDevicePixelRatio,
  );
  tester.view.devicePixelRatio = kDevicePixelRatio;
  addTearDown(tester.view.reset);

  final boundaryKey = GlobalKey();
  await tester.pumpWidget(
    RepaintBoundary(
        key: boundaryKey,
        child: buildScreen(dark: dark, screen: screen?.call())),
  );
  await _drain(tester);
  final generated = screen != null;
  if (generated) {
    expect(
      screenFinder!(),
      findsOneWidget,
      reason: 'the tour screen did not build under the harness',
    );
  } else {
    await openSheet(tester);
  }

  // Pass 1 measures the real content height in the tall probe viewport; pass 2
  // re-renders at exactly that height so the PNG is a full-length strip with
  // no dead space. Two passes are REQUIRED, not an optimisation: screenutil
  // `.h` sizes scale with the viewport, so the height converges to a fixed
  // point rather than being known up front.
  var measured = generated
      ? (screenChips == null ? <_Measured>[] : _measure(tester, screenChips()))
      : _measure(tester, elementSpecs());
  if (!generated)
    expect(
      measured,
      isNotEmpty,
      reason: 'no elements matched - check elementSpecs() and the gates in '
          'registerScreen()',
    );

  var targetHeight = generated
      ? kGeneratedHeight
      : (kShrinkToContent ? kProbeHeight : kFrameHeight);
  if (generated) {
    tester.view.physicalSize = Size(
      kLogicalWidth * kDevicePixelRatio,
      targetHeight * kDevicePixelRatio,
    );
    await tester.pump(const Duration(milliseconds: 50));
    await _drain(tester, rounds: 4);
    measured = generated
        ? (screenChips == null
            ? <_Measured>[]
            : _measure(tester, screenChips()))
        : _measure(tester, elementSpecs());
  }
  // ignore: dead_code
  if (kShrinkToContent && !generated) {
    // Shrink-to-content, for a screen that opts into it by leaving
    // [kFixedFrameHeight] null. The template does exactly one shrink pass;
    // this iterates until the height stops moving, because a screenutil
    // layout's content height is a function OF the viewport height and one
    // pass can leave hundreds of logical px of dead space below the last
    // element. A screen that was already stable settles on the first round,
    // so the extra rounds cost nothing for the template's original case.
    for (var pass = 0; pass < 6; pass++) {
      final contentBottom =
          measured.map((m) => m.rect.bottom).reduce((a, b) => a > b ? a : b);
      final next = (contentBottom + kBottomPadding).clamp(400.0, kProbeHeight);
      final settled = (next - targetHeight).abs() < 1.0;
      targetHeight = next;

      tester.view.physicalSize = Size(
        kLogicalWidth * kDevicePixelRatio,
        targetHeight * kDevicePixelRatio,
      );
      await tester.pump(const Duration(milliseconds: 50));
      await _drain(tester, rounds: 4);
      measured = _measure(tester, elementSpecs());
      if (settled) break;
    }
  }

  await tester.runAsync(() async {
    final boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: kDevicePixelRatio);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File(
      '${outDir.path}/$name.png',
    ).writeAsBytesSync(bytes!.buffer.asUint8List());

    // Sidecar consumed by scripts/render/compose_strip.py. `number` is a
    // convenience only - the composer re-derives stable global numbers from
    // `key`, so a new element never renumbers the ones already reviewed.
    final sidecar = <String, Object?>{
      'variant': name,
      'logicalWidth': kLogicalWidth,
      'logicalHeight': targetHeight,
      'devicePixelRatio': kDevicePixelRatio,
      'warnings': List<String>.from(renderWarnings),
      'elements': <Object>[
        for (var i = 0; i < measured.length; i++)
          <String, Object?>{
            'number': i + 1,
            'key': measured[i].key,
            'label': measured[i].label,
            'x': measured[i].rect.left,
            'y': measured[i].rect.top,
            'w': measured[i].rect.width,
            'h': measured[i].rect.height,
          },
      ],
    };
    File(
      '${outDir.path}/$name.json',
    ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(sidecar));
  });

  debugDefaultTargetPlatformOverride = null;
}

bool _fontsLoaded = false;
Future<void> _loadRealFontsOnce() async {
  if (_fontsLoaded) return;
  await loadRealFonts();
  _fontsLoaded = true;
}

/// Chips for the guided tour's generated screens, keyed by tour step key.
/// Written by hand; a screen without an entry renders clean. Finders anchor
/// on visible demo text, and a point that no longer resolves is dropped by
/// [_measure] rather than failing the run. Never reword `key`.
List<ElementSpec> _textChip(String key, String label, String text) =>
    <ElementSpec>[
      ElementSpec(
          key: key,
          label: label,
          finder: find.textContaining(text, findRichText: true).first),
    ];

final Map<String, List<ElementSpec> Function()> kTourScreenChips =
    <String, List<ElementSpec> Function()>{
  'order_history': () => <ElementSpec>[
        ..._textChip('manager.history.tabs', 'Delivered and cancelled orders',
            'Delivered'),
      ],
  'order_pos_products': () => <ElementSpec>[
        ..._textChip('manager.walkin.search',
            'Search products for a walk-in order', 'Search products'),
        ..._textChip('manager.walkin.categories',
            'Categories - popular, mains and more', 'Popular'),
        ..._textChip('manager.walkin.product',
            'Tap a product to add it to the order', 'Peri-peri chicken wrap'),
      ],
  'order_loads': () => <ElementSpec>[
        ..._textChip(
            'manager.loads.tabs', 'Open and closed loads', 'Open loads'),
        ..._textChip('manager.loads.card',
            'A load - driver, stock left of what was issued', 'Sipho Dlamini'),
      ],
  'order_issue_load': () => <ElementSpec>[
        ..._textChip('manager.issue.driver',
            'Choose the driver who takes the load', 'Choose a deliveryman'),
        ..._textChip('manager.issue.product',
            'Tap products to put them on the load', 'Peri-peri chicken wrap'),
        ..._textChip('manager.issue.submit', 'Issue the load to the driver',
            'Issue to driver'),
      ],
  'order_shop_drivers': () => <ElementSpec>[
        ..._textChip('manager.drivers.card',
            'Your shop drivers - remove one with the icon', 'Sipho Dlamini'),
      ],
  'quick_flow': () => <ElementSpec>[
        ..._textChip('manager.quick.shop', 'The shop these switches apply to',
            'Blue Tap'),
        ..._textChip('manager.quick.accept', 'Auto-accept incoming orders',
            'Auto-accept'),
        ..._textChip('manager.quick.complete', 'Auto-complete at Ready',
            'Auto-complete'),
        ..._textChip('manager.quick.autodial', 'Keypad autodial presets',
            'Keypad autodial'),
      ],
  'sync_issues': () => <ElementSpec>[
        ..._textChip('manager.sync.filters',
            'Filter parked changes by shop, product or order', 'Product'),
      ],
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Never let a test reach out for a webfont: the render must be reproducible
  // offline, and a silent fetch failure is a silent Ahem fallback.
  GoogleFonts.config.allowRuntimeFetching = false;

  final dbDir = Directory.systemTemp.createTempSync('render_harness_db').path;

  // RENDER_SUFFIX distinguishes runs of the SAME harness against different
  // checkouts (e.g. `_draft` for the PR heads, empty for main), so both sets
  // of outputs can sit in one out/ dir and be composed into one page.
  final suffix = Platform.environment['RENDER_SUFFIX'] ?? '';

  testWidgets('render manager sign-in sheet - light', (tester) async {
    await renderVariant(
      tester,
      dark: false,
      name: 'login_light$suffix',
      dbDir: dbDir,
    );
  });

  testWidgets('render manager sign-in sheet - dark (app default)', (
    tester,
  ) async {
    await renderVariant(
      tester,
      dark: true,
      name: 'login_dark$suffix',
      dbDir: dbDir,
    );
  });

  // The guided tour's screens. run_strip.sh passes the tour plan to
  // merge_render_fragments.py, which writes render_screens.g.dart with one
  // entry per tour step that an SDK's render fragment names the same as the
  // step key (marketplace_home, wallet_topup, customer_orders, ...). Nothing
  // is named here: with the committed empty stub this loop has no entries.
  //
  // A screen the harness cannot render headlessly must not fail the run: it
  // is logged and skipped, no PNG is written, and the strip config drops its
  // frame (merge_render_fragments.py --prune-config). Check the log for
  // "SKIPPED tour screen" lines when a screen is missing from the strip.
  for (final entry in kGeneratedScreens.entries) {
    for (final dark in <bool>[true, false]) {
      final mode = dark ? 'dark' : 'light';
      testWidgets('render tour screen ${entry.key} - $mode', (tester) async {
        final name = '${entry.key}_$mode$suffix';
        // Framework errors (a build that throws, a failed lookup, an
        // overflow) are reported through FlutterError.onError, not thrown to
        // the caller. Collect them for THIS screen instead. The handler is
        // restored in the finally block below and again in a tear-down, as
        // flutter_test checks FlutterError.onError is back to its original.
        final problems = <Object>[];
        final priorOnError = FlutterError.onError;
        addTearDown(() => FlutterError.onError = priorOnError);
        FlutterError.onError = (FlutterErrorDetails details) {
          problems.add(details.exception);
        };
        try {
          await _runGuarded(problems, () async {
            await renderVariant(
              tester,
              dark: dark,
              name: name,
              dbDir: dbDir,
              screen: entry.value.build,
              screenFinder: entry.value.finder,
              screenChips: kTourScreenChips[entry.key],
            );
            // Unmount while the handler is still ours, so errors thrown by
            // disposing the screen are collected too.
            await tester.pumpWidget(const SizedBox.shrink());
          });
        } finally {
          // The frame is captured (or given up on) by now; what follows is
          // clean-up, and nothing from it may change the outcome.
          final captured = problems.length;
          await _drainPending(tester);
          if (problems.length > captured) problems.length = captured;
          while (tester.takeException() != null) {}
          FlutterError.onError = priorOnError;
        }
        // A RenderFlex overflow is a cosmetic layout warning: the frame is
        // still drawn and its PNG is worth keeping. Only other errors (a
        // build that throws, a failed lookup) make a frame untrustworthy.
        final hard = problems.where((e) => !_isOverflow(e)).toList();
        if (problems.isNotEmpty && hard.isEmpty) {
          // ignore: avoid_print
          print('NOTE tour screen ${entry.key} - $mode: '
              '${problems.length} layout overflow(s), PNG kept; '
              'first: ${problems.first.toString().split('\n').first}');
        }
        if (hard.isNotEmpty) {
          // A screen that reported hard errors is not a trustworthy frame: drop
          // anything it wrote so it is skipped, not half-composed.
          final outDir = '${Directory.current.path}/out';
          for (final ext in <String>['png', 'json']) {
            final file = File('$outDir/$name.$ext');
            if (file.existsSync()) file.deleteSync();
          }
          // ignore: avoid_print
          print('SKIPPED tour screen ${entry.key} - $mode: '
              '${problems.length} error(s); first: ${hard.first}');
          // One JSON line per skipped screen, for the render strip's
          // plain-language list (run_strip.sh turns these into
          // render-skipped.md). Only the first line of the error is kept.
          final reason = hard.first.toString().split('\n').first.trim();
          Directory(outDir).createSync(recursive: true);
          File('$outDir/skipped.jsonl').writeAsStringSync(
            '${jsonEncode(<String, String>{
                  'key': entry.key,
                  'mode': mode,
                  'reason': reason.length > 200
                      ? '${reason.substring(0, 197)}...'
                      : reason,
                })}\n',
            mode: FileMode.append,
          );
        }
      });
    }
  }
}

/// Runs [body] in an error zone. Anything it throws, and any uncaught async
/// error raised while it runs, is appended to [problems] rather than failing
/// the test.
Future<void> _runGuarded(
  List<Object> problems,
  Future<void> Function() body,
) {
  final done = Completer<void>();
  runZonedGuarded(() async {
    try {
      await body();
    } catch (error) {
      problems.add(error);
    } finally {
      if (!done.isCompleted) done.complete();
    }
  }, (error, stack) {
    problems.add(error);
  });
  return done.future;
}

/// Whether [error] is only a RenderFlex/RenderBox overflow warning.
bool _isOverflow(Object error) => error.toString().contains('overflowed by');

/// Lets everything still scheduled after the screen was unmounted (a zero
/// length timer from an in-flight request, a timeout) run on the fake clock.
/// flutter_test fails a test that ends with a timer pending, and a tour screen
/// that kicks off a request would otherwise fail the whole run for it.
Future<void> _drainPending(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    try {
      await tester.pump(const Duration(seconds: 30));
    } catch (_) {
      // Ignored: the frame is already captured.
    }
  }
}

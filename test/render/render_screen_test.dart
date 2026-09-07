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
// The screen: auth_sdk's sign-in sheet (LoginScreen) - the first screen a
// Manager user sees. Chosen because it is the one manager-shell surface that
// renders FULLY POPULATED from the SDKs' own IS_DEMO fixtures with no live
// backend: AuthSdkDependencies installs MockAuthRepository under
// `--dart-define=IS_DEMO=true`, and every string on it resolves offline
// through base_sdk's BundledTranslations. See test/render/strip.json's notes
// for why the manager-role screens (POS, order queue, restaurant profile) are
// not the proof frame.
//
// The harness renders demo/seed fixtures and is never wired to a live client
// or backend.
//
// Run:  flutter test --dart-define=IS_DEMO=true test/render/render_screen_test.dart
//       RENDER_SUFFIX=_draft flutter test --dart-define=IS_DEMO=true \
//           test/render/render_screen_test.dart

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

import 'package:base_sdk/src/constants/app_constants.dart';
import 'package:base_sdk/src/di/base_di.dart';
import 'package:base_sdk/src/models/response/languages_response.dart';
import 'package:base_sdk/src/presentation/components/app_bars/app_bar_bottom_sheet.dart';
import 'package:base_sdk/src/presentation/components/buttons/custom_button.dart';
import 'package:base_sdk/src/presentation/components/buttons/forgot_text_button.dart';
import 'package:base_sdk/src/presentation/components/buttons/social_button.dart';
import 'package:base_sdk/src/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/local_storage.dart';

import 'package:auth_sdk/src/common/di/auth_di.dart';
import 'package:auth_sdk/src/common/presentation/pages/auth/login/login_screen.dart';
import 'package:comms_sdk/src/common/di/comms_di.dart';
import 'package:users_sdk/src/common/di/users_di.dart';

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
/// Every SDK ships its demo fixtures and swaps them in itself behind
/// `AppConstants.isDemo` (`bool.fromEnvironment('IS_DEMO')`). The test runs
/// with `--dart-define=IS_DEMO=true` and calls the DI registrations in the
/// same order the composed `main.dart` does: base first, then each feature
/// SDK. For this screen that means auth_sdk's `MockAuthRepository` backs
/// `loginProvider`, exactly as it does in a demo build of Manager.
///
/// Only the SDKs this screen's widget tree actually resolves are registered;
/// the manager-role hooks (`ManagerOrdersDependencies`,
/// `ManagerMerchantsDependencies`) are deliberately absent - see the note in
/// strip.json.
Future<void> registerDemoDependencies() async {
  assert(
    AppConstants.isDemo,
    'run with --dart-define=IS_DEMO=true, or the SDKs register their real '
    'HTTP repositories and the render is of a broken, empty screen',
  );
  BaseSdkDependencies.register(GetIt.I);
  AuthSdkDependencies.register(GetIt.I); // MockAuthRepository
  UsersSdkDependencies.register(GetIt.I); // MockAddressRepository
  CommsSdkDependencies.register(GetIt.I); // MockSettingsRepository
}

/// EXCEPTION: device history the demo mode cannot supply.
///
/// Empty, and expected to stay empty for this screen: the sign-in sheet reads
/// no store the device accumulates through use.
Future<void> seedDeviceHistory(WidgetTester tester) async {}

/// EXCEPTION: stub a service with no demo implementation.
///
/// Empty. Everything this screen resolves has an `isDemo` path in its own SDK.
void registerExceptionStubs() {}

/// Register sections / routes / gates.
///
/// The sign-in sheet has no registry or gate of its own; the app-wide state it
/// reads (language, theme) is set per variant in [renderVariant].
void registerScreen() {}

/// The widget under test: auth_sdk's real [LoginScreen], wrapped the way the
/// app wraps it. In the app it is shown by
/// `AppHelpers.showCustomModalBottomSheet`, so it is pumped here as the body
/// of a sheet-shaped Scaffold rather than as a full page - substituting a
/// plain page would review a layout the app never shows.
Widget buildScreen({required bool dark}) {
  return ProviderScope(
    child: ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: dark ? Brightness.dark : Brightness.light,
          useMaterial3: false,
        ),
        home: Scaffold(
          backgroundColor: AppStyle.surfaceDark,
          // Bottom-anchored, as `AppHelpers.showCustomModalBottomSheet`
          // puts it: the frame is a phone screen with the sheet resting on
          // its bottom edge, so the reviewer sees the sheet at the size and
          // position a phone actually draws it.
          body: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(child: const LoginScreen()),
          ),
        ),
      ),
    ),
  );
}

/// The elements the review points at.
///
/// `key` is the STABLE IDENTITY the strip composer binds a number to for the
/// life of the page. Reword `label` freely; never reword `key`.
List<ElementSpec> elementSpecs() {
  return <ElementSpec>[
    ElementSpec(
      key: 'auth.login.sheet_header',
      label: 'Sheet header - title and close affordance',
      finder: find.byType(AppBarBottomSheet),
    ),
    ElementSpec(
      key: 'auth.login.phone_field',
      label: 'Phone field - country picker, flag, dial code',
      finder: find.byType(IntlPhoneField),
    ),
    ElementSpec.each(
      keyOf: (i, w) =>
          'auth.login.text_field.${(w as OutlinedBorderTextField).label}',
      labelOf: (i, w) =>
          'Text field - ${(w as OutlinedBorderTextField).label ?? 'unlabelled'}',
      finder: find.byType(OutlinedBorderTextField),
    ),
    ElementSpec(
      key: 'auth.login.keep_logged',
      label: 'Keep me logged in - checkbox',
      finder: find.byType(Checkbox),
    ),
    ElementSpec(
      key: 'auth.login.forgot_password',
      label: 'Forgot password - opens the reset sheet',
      finder: find.byType(ForgotTextButton),
    ),
    ElementSpec(
      key: 'auth.login.submit',
      label: 'Sign-in button - primary action',
      finder: find.byType(CustomButton),
    ),
    ElementSpec.each(
      keyOf: (i, w) => 'auth.login.social.${(w as SocialButton).title}',
      labelOf: (i, w) => 'Quick access - ${(w as SocialButton).title}',
      finder: find.byType(SocialButton),
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
    final elements = spec.finder.evaluate().toList();
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
}) async {
  final outDir = Directory('${Directory.current.path}/out')
    ..createSync(recursive: true);

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

  // App-wide state the screen reads before it builds. Mirrors the guided
  // tour's own setup block (tour/app.tour.yaml): the language must be seeded
  // or base_sdk's BundledTranslations has no locale to resolve against and
  // every label on the sheet renders as a humanised key.
  SharedPreferences.setMockInitialValues(<String, Object>{});
  await tester.runAsync(() async {
    await LocalStorage.init();
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
    RepaintBoundary(key: boundaryKey, child: buildScreen(dark: dark)),
  );
  await _drain(tester);

  // Pass 1 measures the real content height in the tall probe viewport; pass 2
  // re-renders at exactly that height so the PNG is a full-length strip with
  // no dead space. Two passes are REQUIRED, not an optimisation: screenutil
  // `.h` sizes scale with the viewport, so the height converges to a fixed
  // point rather than being known up front.
  var measured = _measure(tester, elementSpecs());
  expect(
    measured,
    isNotEmpty,
    reason: 'no elements matched - check elementSpecs() and the gates in '
        'registerScreen()',
  );

  var targetHeight = kShrinkToContent ? kProbeHeight : kFrameHeight;
  // ignore: dead_code
  if (kShrinkToContent) {
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
}

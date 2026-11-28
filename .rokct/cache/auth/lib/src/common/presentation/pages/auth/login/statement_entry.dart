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

import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:auth_sdk/src/common/services/auth_tr_keys.dart';
import 'package:auth_sdk/src/common/services/entry_config.dart';

/// One tone of a [StatementEntrySpec]: the colours of the approved renders
/// (login-per-app/approved/src: b3.css with each app's own variables, and
/// light.css for light mode).
@immutable
class StatementEntryTone {
  const StatementEntryTone({
    required this.background,
    required this.glow,
    required this.accent,
    required this.onAccent,
    required this.accentText,
    this.glowCenter = const Alignment(1, -1),
  });

  final Color background;
  final Color glow;
  final Alignment glowCenter;

  /// The main button's fill and its label colour.
  final Color accent;
  final Color onAccent;

  /// The label above the headline and the headline's second line.
  final Color accentText;
}

/// What a home SDK fills in to get the "statement" login (Ray approved it
/// for Polaris, Driver, Manager and Launcher, 2026-11-27/28): the app's
/// name top left with Skip top right, a soft glow, a small mono label, a
/// two-line headline whose second line is in the accent, one line of
/// promise, two facts, the main button and Create an account. Every text
/// is a translation key; the colours come per mode.
@immutable
class StatementEntrySpec {
  const StatementEntrySpec({
    required this.appName,
    required this.kickerKey,
    required this.titleLeadKey,
    required this.titleAccentKey,
    required this.subtitleKey,
    required this.facts,
    required this.dark,
    required this.light,
    this.primaryLabelKey,
    this.registerLabelKey = AuthTrKeys.createAnAccount,
    this.mark,
  });

  /// The wordmark, as the app writes its own name (not translated).
  final String appName;

  /// Drawn left of [appName] when set (Polaris's P tile).
  final Widget? mark;

  final String kickerKey;
  final String titleLeadKey;
  final String titleAccentKey;
  final String subtitleKey;

  /// Exactly two (label key, value key) pairs.
  final List<(String, String)> facts;

  /// The main button's label key. Null reads "Login".
  final String? primaryLabelKey;
  final String registerLabelKey;

  final StatementEntryTone dark;
  final StatementEntryTone light;
}

/// The statement login, drawn from a [StatementEntrySpec] with auth_sdk's
/// own sign-in [actions]. A home SDK sets it as its page:
/// `AuthEntryConfig.pageBuilder = (c, a) => StatementEntry(spec: s, actions: a);`
class StatementEntry extends StatelessWidget {
  const StatementEntry({super.key, required this.spec, required this.actions});

  static const Key loginKey = ValueKey('auth.statement.login');
  static const Key registerKey = ValueKey('auth.statement.register');
  static const Key skipKey = ValueKey('auth.statement.skip');

  final StatementEntrySpec spec;
  final AuthEntryActions actions;

  @override
  Widget build(BuildContext context) {
    final bool light = Theme.of(context).brightness == Brightness.light;
    final StatementEntryTone tone = light ? spec.light : spec.dark;
    // The shared text colours of the approved renders (b3.css dark,
    // light.css light).
    final Color ink = light ? const Color(0xFF14130F) : const Color(0xFFF4F4F2);
    final Color skip = light
        ? const Color(0xFF55534C)
        : const Color(0xFFCFCFCF);
    final Color sub = light ? const Color(0xFF5D5B54) : const Color(0xFFA3A3A0);
    final Color line = light
        ? const Color(0x14000000)
        : const Color(0x1AFFFFFF);
    final Color factText = light
        ? const Color(0xFF2A2925)
        : const Color(0xFFD9D9D6);
    final Color label = light
        ? const Color(0xFF8A877E)
        : const Color(0xFF7D7D7A);
    final Color terms = light
        ? const Color(0xFF8A877E)
        : const Color(0xFF7A7A77);

    String t(String key) => AppHelpers.getTranslation(key);
    TextStyle tight(
      double size,
      FontWeight w,
      Color c, {
      double spacing = 0,
      double? height,
    }) => GoogleFonts.interTight(
      fontSize: size.sp,
      fontWeight: w,
      color: c,
      letterSpacing: spacing,
      height: height,
    );
    TextStyle inter(double size, FontWeight w, Color c, {double? height}) =>
        GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: w,
          color: c,
          height: height,
        );
    TextStyle mono(double size, Color c, double spacing) =>
        GoogleFonts.jetBrainsMono(
          fontSize: size.sp,
          fontWeight: FontWeight.w500,
          color: c,
          letterSpacing: spacing,
        );

    Widget fact((String, String) f) => Expanded(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t(f.$1).toUpperCase(), style: mono(10, label, 1.1)),
            5.verticalSpace,
            Text(
              t(f.$2),
              style: inter(12, FontWeight.w400, factText, height: 1.35),
            ),
          ],
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tone.background,
        gradient: RadialGradient(
          center: tone.glowCenter,
          radius: 1.15,
          colors: [tone.glow, tone.background],
          stops: const [0, 0.62],
        ),
      ),
      child: SafeArea(
        // Scrolls only on phones too short for the whole page.
        child: LayoutBuilder(
          builder: (context, box) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: REdgeInsets.fromLTRB(25, 12, 25, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          if (spec.mark != null) ...[
                            spec.mark!,
                            11.horizontalSpace,
                          ],
                          Expanded(
                            child: Text(
                              spec.appName,
                              style: spec.mark == null
                                  ? tight(
                                      19,
                                      FontWeight.w700,
                                      ink,
                                      spacing: -0.4,
                                    )
                                  : tight(
                                      17,
                                      FontWeight.w600,
                                      ink,
                                      spacing: -0.2,
                                    ),
                            ),
                          ),
                          // Hidden for apps with nothing to show a guest (Driver,
                          // Manager: showsGuestSkip = false).
                          if (AuthEntryConfig.showsGuestSkip)
                            TextButton(
                              key: skipKey,
                              onPressed: actions.skip,
                              child: Text(
                                t(TrKeys.skip),
                                style: inter(13.5, FontWeight.w500, skip),
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        t(spec.kickerKey).toUpperCase(),
                        style: mono(11, tone.accentText, 1.5),
                      ),
                      16.verticalSpace,
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '${t(spec.titleLeadKey)}\n'),
                            TextSpan(
                              text: t(spec.titleAccentKey),
                              style: TextStyle(color: tone.accentText),
                            ),
                          ],
                        ),
                        style: tight(
                          47,
                          FontWeight.w600,
                          ink,
                          spacing: -1.6,
                          height: 1.02,
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        t(spec.subtitleKey),
                        style: inter(15.3, FontWeight.w400, sub, height: 1.55),
                      ),
                      30.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(color: line),
                          ),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              fact(spec.facts[0]),
                              VerticalDivider(width: 1, color: line),
                              14.horizontalSpace,
                              fact(spec.facts[1]),
                            ],
                          ),
                        ),
                      ),
                      28.verticalSpace,
                      SizedBox(
                        height: 52.r,
                        child: FilledButton(
                          key: loginKey,
                          onPressed: actions.login,
                          style: FilledButton.styleFrom(
                            backgroundColor: tone.accent,
                            foregroundColor: tone.onAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              t(spec.primaryLabelKey ?? TrKeys.login),
                              style: inter(
                                15.3,
                                FontWeight.w600,
                                tone.onAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (actions.register != null)
                        SizedBox(
                          height: 52.r,
                          child: TextButton(
                            key: registerKey,
                            onPressed: actions.register,
                            child: Text(
                              t(spec.registerLabelKey),
                              style: inter(15.3, FontWeight.w600, ink),
                            ),
                          ),
                        ),
                      8.verticalSpace,
                      Text(
                        t(AuthTrKeys.statementTerms),
                        textAlign: TextAlign.center,
                        style: inter(11, FontWeight.w400, terms, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

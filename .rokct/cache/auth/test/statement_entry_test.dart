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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:base_sdk/src/services/local_storage.dart';
import 'package:auth_sdk/src/common/presentation/pages/auth/login/statement_entry.dart';
import 'package:auth_sdk/src/common/services/entry_config.dart';

const _tone = StatementEntryTone(
  background: Color(0xFF0D0B0A),
  glow: Color(0xFF3A1600),
  accent: Color(0xFFFF6600),
  onAccent: Color(0xFF0B0B0B),
  accentText: Color(0xFFFF6600),
);

const _spec = StatementEntrySpec(
  appName: 'Juvo Driver',
  kickerKey: 'k',
  titleLeadKey: 'a',
  titleAccentKey: 'b',
  subtitleKey: 's',
  facts: [('f1', 'v1'), ('f2', 'v2')],
  dark: _tone,
  light: _tone,
);

Widget _host(List<String> taps, {bool register = true}) => ScreenUtilInit(
  designSize: const Size(390, 844),
  builder: (_, __) => MaterialApp(
    home: Scaffold(
      body: StatementEntry(
        spec: _spec,
        actions: AuthEntryActions(
          login: () => taps.add('login'),
          skip: () => taps.add('skip'),
          register: register ? () => taps.add('register') : null,
          socialSignIns: const [],
          socialSignIn: (_) {},
        ),
      ),
    ),
  ),
);

void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.init();
  });
  tearDown(AuthEntryConfig.reset);

  testWidgets('login, register and skip run auth_sdk actions', (t) async {
    final taps = <String>[];
    await t.pumpWidget(_host(taps));
    expect(find.text('Juvo Driver'), findsOneWidget);
    await t.tap(find.byKey(StatementEntry.loginKey));
    await t.tap(find.byKey(StatementEntry.registerKey));
    await t.tap(find.byKey(StatementEntry.skipKey));
    expect(taps, ['login', 'register', 'skip']);
  });

  testWidgets('no register action, no Create an account', (t) async {
    await t.pumpWidget(_host([], register: false));
    expect(find.byKey(StatementEntry.registerKey), findsNothing);
  });

  testWidgets('apps with no guest surface hide Skip', (t) async {
    AuthEntryConfig.showsGuestSkip = false;
    await t.pumpWidget(_host([]));
    expect(find.byKey(StatementEntry.skipKey), findsNothing);
  });
}

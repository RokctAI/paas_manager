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
// The fleet productivity entry (productivity_sdk 1.8.0): every app that
// composes productivity_sdk declares an activity-alias the launcher can find
// by ACTION and open straight on /tasks, the way it opens a fleet calculator
// (Ray, 2026-10-12). Back on that page returns to the launcher. These read
// the manifest the protocol installer applies and the installed route page.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final Map<String, dynamic> manifest =
      jsonDecode(File('manifest.json').readAsStringSync())
          as Map<String, dynamic>;

  test('one exported alias of MainActivity, by action and scheme', () {
    final List<dynamic> elements =
        (manifest['host_integration']
            as Map<String, dynamic>)['android_application_xml'] as List<dynamic>;
    expect(elements, hasLength(1));
    final String alias = elements.single as String;
    expect(alias, startsWith('<activity-alias '));
    expect(alias, contains('android:name=".RokctProductivityEntry"'));
    expect(alias, contains('android:targetActivity=".MainActivity"'));
    expect(alias, contains('android:exported="true"'));
    expect(
      alias,
      contains('<action android:name="rokct.intent.action.PRODUCTIVITY" />'),
    );
    expect(
      alias,
      contains('<category android:name="android.intent.category.DEFAULT" />'),
    );
    expect(alias, contains('<data android:scheme="rokct" />'));
    expect(
      alias,
      contains(
        '<meta-data android:name="io.flutter.embedding.android.NormalTheme" '
        'android:resource="@style/NormalTheme" />',
      ),
    );
  });

  test('the route the entry lands on is the one this SDK mounts', () {
    final List<dynamic> routes = manifest['routes'] as List<dynamic>;
    expect(
      routes.map((dynamic r) => (r as Map<String, dynamic>)['path']),
      contains('/tasks'),
    );
  });

  test('the tasks page returns to the launcher when it opened it', () {
    final String page =
        File('templates/pages/tasks/tasks_page.dart').readAsStringSync();
    expect(page, contains('ReturnToLauncherScope('));
    expect(page, contains("queryParams.optString('from')"));
    // The constructor stays const: merchants pushes `const TasksRoute()`.
    expect(page, contains('const TasksPage({super.key});'));
  });

  test('manifest and pubspec agree on the version', () {
    final String pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('version: ${manifest['version']}'));
  });
}

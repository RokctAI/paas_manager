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

// Regression guard for the composed app's wiring, which is DATA in this
// manifest rather than code in lib/: a composed app's lib/ is generated
// and gitignored, so nothing else in this package can fail when the
// manifest stops declaring what the shell needs (the radio_sdk pattern).
//
// What it guards: design strip section 46 reaches the guided run by ROUTE
// PATH — `/tasks/run?task=<id>` — from the /tasks page at one plane and
// from any other SDK that wants a run without importing this one. The
// route is only real if this manifest declares it against the template
// the installer copies in; a page with a @RoutePage the manifest never
// mentions is dropped from the generated router without a word.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final manifest =
      jsonDecode(File('manifest.json').readAsStringSync()) as Map<String, dynamic>;

  List<Map<String, dynamic>> listOf(String key) =>
      ((manifest[key] as List?) ?? const [])
          .cast<Map<String, dynamic>>()
          .toList();

  group('productivity_sdk manifest wiring', () {
    test('declares the tasks workspace and the guided run routes', () {
      final routes = listOf('routes');
      final byPath = {for (final r in routes) r['path'] as String: r};

      expect(byPath.keys, containsAll(['/tasks', '/tasks/run']));
      expect(byPath['/tasks']!['page'], 'TasksRoute.page');
      expect(byPath['/tasks/run']!['page'], 'TaskRunRoute.page');
    });

    test('every route imports a page the installer actually copies in', () {
      final installs = listOf('installs');
      final targets = installs.map((i) => i['to'] as String).toList();
      for (final route in listOf('routes')) {
        final import = route['import'] as String;
        expect(import, startsWith('package:\${package}/'),
            reason: 'routes resolve inside the composed app, not this SDK');
        final path = import
            .replaceFirst('package:\${package}/', 'lib/')
            .replaceFirst(RegExp(r"';?$"), '');
        expect(
          targets.any(path.startsWith),
          isTrue,
          reason: '${route['path']} imports $path, which no installs entry '
              'places in the composed app',
        );
      }
    });

    test('the run page template exists where the route says it does', () {
      final installs = listOf('installs');
      for (final route in listOf('routes')) {
        final import = route['import'] as String;
        final relative = import.replaceFirst('package:\${package}/', 'lib/');
        final install = installs.firstWhere(
          (i) => relative.startsWith(i['to'] as String),
        );
        final template = relative.replaceFirst(
          install['to'] as String,
          install['from'] as String,
        );
        expect(File(template).existsSync(), isTrue,
            reason: '${route['path']} points at $template');
        final source = File(template).readAsStringSync();
        final page = (route['page'] as String).replaceAll('.page', '');
        expect(
          source.contains('@RoutePage(') &&
              (source.contains("name: '$page'") ||
                  source.contains('class ${page.replaceAll('Route', 'Page')} ')),
          isTrue,
          reason: '$template must declare the $page @RoutePage',
        );
      }
    });

    test('the version moved with the new route', () {
      final version = manifest['version'] as String;
      final parts = version.split('.').map(int.parse).toList();
      expect(parts.length, 3);
      expect(parts[0] > 1 || (parts[0] == 1 && parts[1] >= 1), isTrue,
          reason: 'a route added is a minor bump: 1.1.0 or later');
    });

    test('the schema the run persists into is still declared', () {
      final tables = ((manifest['database'] as Map)['tables'] as List)
          .cast<Map<String, dynamic>>()
          .map((t) => t['class'])
          .toSet();
      // The run writes its step timestamps into TasksTable.data; there is
      // no run table, and a migration that added one would be a mistake.
      expect(tables, contains('TasksTable'));
      expect(tables.any((t) => '$t'.toLowerCase().contains('run')), isFalse,
          reason: 'the run is derived state on the task, not a table');
    });
  });
}

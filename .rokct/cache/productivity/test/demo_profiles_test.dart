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

// Per-app demo profiles (1.10.0): each templates/demo_profiles/<profile>/
// replaces the default fixture set in the app its manifest entry names, so
// it must carry every default file, parse, keep its ids linked, and be
// installed AFTER the default directory (the later copy wins).

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _default = 'templates/assets/demo/productivity';
const Map<String, String> _profiles = <String, String>{
  'school': 'supacharge',
  'shop': 'manager',
  'assistant': 'sticks',
  'personal': 'launcher',
};

Set<String> _names(String dir) => Directory(dir)
    .listSync()
    .whereType<File>()
    .map((File f) => f.uri.pathSegments.last)
    .toSet();

dynamic _read(String path) => jsonDecode(File(path).readAsStringSync());

void main() {
  test('default set carries a tour task profile', () {
    final Map<String, dynamic> p =
        _read('$_default/demo_profile.json') as Map<String, dynamic>;
    expect(p['profile'], 'business');
    expect((p['tour_tasks'] as List<dynamic>).length, greaterThanOrEqualTo(3));
  });

  for (final String profile in _profiles.keys) {
    final String dir = 'templates/demo_profiles/$profile';
    test('$profile replaces every default fixture with linked ids', () {
      expect(_names(dir), _names(_default));
      final Set<String> pillars = <String>{
        for (final dynamic p in _read('$dir/tenant.api.get_pillars.json') as List<dynamic>)
          (p as Map<String, dynamic>)['name'] as String,
      };
      final List<dynamic> objectives =
          _read('$dir/tenant.api.get_strategic_objectives.json') as List<dynamic>;
      for (final dynamic o in objectives) {
        expect(pillars, contains((o as Map<String, dynamic>)['pillar']));
      }
      final Set<String> objectiveIds = <String>{
        for (final dynamic o in objectives) (o as Map<String, dynamic>)['name'] as String,
      };
      for (final dynamic k in _read('$dir/tenant.api.get_kpis.json') as List<dynamic>) {
        expect(objectiveIds, contains((k as Map<String, dynamic>)['strategic_objective']));
      }
      final Map<String, dynamic> p = _read('$dir/demo_profile.json') as Map<String, dynamic>;
      expect(p['profile'], profile);
      for (final dynamic t in p['tour_tasks'] as List<dynamic>) {
        final Map<String, dynamic> m = t as Map<String, dynamic>;
        expect(m['title'], isA<String>());
        expect(m['created_hours_ago'], isA<int>());
        expect(m['isLongTerm'] == true || m['due_days'] is int, isTrue);
      }
    });
  }

  test('manifest installs each profile after the default, scoped to its app', () {
    final List<dynamic> installs =
        (_read('manifest.json') as Map<String, dynamic>)['installs'] as List<dynamic>;
    final int base = installs.indexWhere(
      (dynamic e) => (e as Map<String, dynamic>)['from'] == _default,
    );
    expect(base, isNonNegative);
    _profiles.forEach((String profile, String appType) {
      final int i = installs.indexWhere(
        (dynamic e) =>
            (e as Map<String, dynamic>)['from'] == 'templates/demo_profiles/$profile',
      );
      expect(i, greaterThan(base));
      final Map<String, dynamic> e = installs[i] as Map<String, dynamic>;
      expect(e['to'], 'assets/demo/productivity');
      expect(e['app_types'], <String>[appType]);
    });
  });
}

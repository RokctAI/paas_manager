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

// Demo runs the REAL VisionRepositoryImpl: base_sdk's DemoGatewayInterceptor
// answers tenant.api.get_personal_mastery_goals from
// templates/assets/demo/productivity, so the demo mastery card shows the
// same to-dos and progress a live backend sends.
//
// Imports the repository and model directly (not the barrel or the DI
// file), for the reason test/vision_repository_test.dart gives: the drift
// tables they reach exist only in a composed app. The DI registration and
// the manifest install are checked by reading the files instead.

import 'dart:convert';
import 'dart:io';

import 'package:base_sdk/base_sdk.dart'
    show ApiResult, DemoFixtures, DemoSession, HttpService, LocalStorage, Success, getIt;
import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/src/common/infrastructure/repositories/vision_repository_impl.dart';
import 'package:productivity_sdk/src/common/models/data/vision_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _hostDir = 'assets/demo/productivity';
const String _templateDir = 'templates/assets/demo/productivity';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.init();
    await DemoSession.instance.activate();
    if (!getIt.isRegistered<HttpService>()) {
      getIt.registerSingleton<HttpService>(HttpService());
    }
    DemoFixtures.reset();
    DemoFixtures.loader = (key) async {
      final File f = File(key.replaceFirst('$_hostDir/', '$_templateDir/'));
      return f.existsSync() ? f.readAsString() : null;
    };
    DemoFixtures.registerAssetDirectory(_hostDir);
  });

  tearDown(() async {
    DemoFixtures.reset();
    await DemoSession.instance.clear();
  });

  test('demo mastery goals carry their to-dos and show progress', () async {
    final ApiResult<List<MasteryGoal>> result =
        await const VisionRepositoryImpl().loadMasteryGoals();
    final List<MasteryGoal> goals =
        (result as Success<List<MasteryGoal>>).data;

    expect(goals, hasLength(3));
    expect(goals[0].todosTotal, 3);
    expect(goals[0].todosDone, 2);
    expect(goals[0].progress, closeTo(2 / 3, 1e-9));
    expect(goals[0].isComplete, isFalse);
    expect(goals[0].todos![2].date, isNotNull,
        reason: r'the $today token resolves to a real date');
    expect(goals[1].isComplete, isTrue);
    expect(goals[1].progress, 1.0);
    // A goal with no to-dos draws no progress, not "0 of 0".
    expect(goals[2].hasTodos, isFalse);
    expect(goals[2].progress, isNull);
  });

  test('the fixture sums agree with what the card derives', () {
    final List<dynamic> rows = jsonDecode(File(
      '$_templateDir/tenant.api.get_personal_mastery_goals.json',
    ).readAsStringSync()) as List<dynamic>;
    for (final dynamic row in rows) {
      final MasteryGoal goal =
          MasteryGoal.fromMap((row as Map).cast<String, dynamic>());
      expect(row['todos_total'], goal.todosTotal, reason: goal.name);
      expect(row['todos_done'], goal.todosDone, reason: goal.name);
      expect(row['progress'], goal.progress, reason: goal.name);
    }
  });

  test('the fixtures are installed and registered for the composed app', () {
    final Map<String, dynamic> manifest =
        jsonDecode(File('manifest.json').readAsStringSync())
            as Map<String, dynamic>;
    expect(
      (manifest['installs'] as List<dynamic>).any((dynamic e) =>
          e is Map && e['from'] == _templateDir && e['to'] == _hostDir),
      isTrue,
    );
    expect(manifest['app_assets'], contains('$_hostDir/'));
    final String di =
        File('lib/src/common/di/productivity_di.dart').readAsStringSync();
    expect(di, contains("'$_hostDir'"));
    expect(
      di,
      contains(
          'DemoFixtures.registerAssetDirectory(productivityDemoFixtureDirectory)'),
    );
  });
}

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
// answers the plan-on-a-page cmds (get_visions, get_plan_on_a_page,
// get_pillars, get_strategic_objectives, get_kpis) from
// templates/assets/demo/productivity, so /vision draws a stocked board
// (masthead, pillar columns, objective cards, KPI counts) in a demo session.
//
// Imports the repository and model directly (not the barrel or the DI
// file), for the reason test/vision_repository_test.dart gives: the drift
// tables they reach exist only in a composed app. The DI registration and
// the manifest install are checked by reading the files instead.

import 'dart:io';

import 'package:base_sdk/base_sdk.dart'
    show ApiResult, DemoFixtures, DemoSession, HttpService, LocalStorage, Success, getIt;
import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/src/common/infrastructure/repositories/vision_repository_impl.dart';
import 'package:productivity_sdk/src/common/models/data/objective_data.dart';
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

  test('demo plan board has a masthead, pillars, objectives and KPIs',
      () async {
    final ApiResult<PlanBoard> result =
        await const VisionRepositoryImpl().loadPlan();
    final PlanBoard board = (result as Success<PlanBoard>).data;

    expect(board.isEmpty, isFalse);
    expect(board.vision?.name, 'VIS-DEMO-0001');
    expect(board.vision?.title, isNotEmpty);
    expect(board.pillars, hasLength(3));
    expect(board.objectives, hasLength(4));
    expect(board.kpis, hasLength(4));
    expect(board.kpisRead, isTrue);
    // Every objective sits under a pillar the board draws, every KPI under
    // an objective it draws.
    for (final StrategicObjective o in board.objectives) {
      expect(board.pillarNamed(o.pillar), isNotNull, reason: o.name);
    }
    final Set<String> objectives =
        board.objectives.map((StrategicObjective o) => o.name).toSet();
    for (final Kpi k in board.kpis) {
      expect(objectives, contains(k.strategicObjective), reason: k.name);
    }
  });
}

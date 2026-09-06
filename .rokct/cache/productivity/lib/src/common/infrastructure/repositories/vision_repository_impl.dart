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

import 'package:base_sdk/base_sdk.dart';
import 'package:flutter/foundation.dart';

import '../../domain/interface/vision_repository_facade.dart';
import '../../models/data/objective_data.dart';
import '../../models/data/vision_data.dart';
import 'objectives_repository_impl.dart';

/// Gateway command names, as the productivity manifest routes them.
///
/// `productivity/frappe/manifest.json` registers
/// `{app_name}.tenant.api.<method>`; the platform gateway drops the leading
/// app segment and resolves the rest against the composed app's whitelist,
/// exactly as [ObjectiveCmds] does for the three the picker already asks.
/// These three had ZERO Dart callers before section 41.
class VisionCmds {
  VisionCmds._();

  static const String plan = 'tenant.api.get_plan_on_a_page';
  static const String visions = 'tenant.api.get_visions';
  static const String masteryGoals = 'tenant.api.get_personal_mastery_goals';
}

/// Reads the plan and the mastery goals through the platform gateway.
/// Nothing here writes.
class VisionRepositoryImpl implements VisionRepositoryFacade {
  const VisionRepositoryImpl({
    PlatformGateway gateway = const PlatformGateway(),
  }) : _gateway = gateway;

  final PlatformGateway _gateway;

  @override
  Future<ApiResult<PlanBoard>> loadPlan() async {
    try {
      // Pillars and objectives are the board itself: either missing and
      // there is nothing honest to draw, so both are required. The
      // masthead and the KPI counts are dress ON the board; a failure
      // there costs the masthead or the pills, never the columns.
      final List<Map<String, dynamic>> pillarRows = _rows(
        await _gateway.call(ObjectiveCmds.pillars),
      );
      final List<Map<String, dynamic>> objectiveRows = _rows(
        await _gateway.call(ObjectiveCmds.objectives),
      );

      // The single Plan On A Page doc names the vision the board is a
      // plan FOR. A plan with no link falls back to the one vision the
      // tenant has, when there is exactly one — two or more with no link
      // is a choice nobody made, so the board draws no masthead.
      String? plannedVision;
      List<Vision> visions = const <Vision>[];
      try {
        final Object? plan = await _gateway.call(VisionCmds.plan);
        if (plan is Map) plannedVision = planText(plan['vision']);
      } catch (e) {
        debugPrint(
          '==> get_plan_on_a_page failed; masthead from get_visions alone: $e',
        );
      }
      try {
        visions = <Vision>[
          for (final Map<String, dynamic> row in _rows(
            await _gateway.call(VisionCmds.visions),
          ))
            if ((row['name'] ?? '').toString().isNotEmpty) Vision.fromMap(row),
        ];
      } catch (e) {
        debugPrint(
          '==> get_visions failed; board drawn without a masthead: $e',
        );
      }
      Vision? vision;
      for (final Vision v in visions) {
        if (v.name == plannedVision) vision = v;
      }
      if (vision == null && plannedVision == null && visions.length == 1) {
        vision = visions.single;
      }

      List<Kpi> kpis = const <Kpi>[];
      bool kpisRead = true;
      try {
        kpis = <Kpi>[
          for (final Map<String, dynamic> row in _rows(
            await _gateway.call(ObjectiveCmds.kpis),
          ))
            if ((row['name'] ?? '').toString().isNotEmpty) Kpi.fromMap(row),
        ];
      } catch (e) {
        kpisRead = false;
        debugPrint(
          '==> get_kpis failed; objective cards drawn without a KPI count: $e',
        );
      }

      final List<Pillar> pillars = <Pillar>[
        for (final Map<String, dynamic> row in pillarRows)
          if ((row['name'] ?? '').toString().isNotEmpty) Pillar.fromMap(row),
      ];
      // The board is the plan for ITS vision: pillars linked elsewhere
      // are another vision's. A pillar with no link at all stays — the
      // link is optional on the doctype and an orphan pillar is still a
      // pillar of the tenant's one plan.
      final String? visionName = vision?.name;
      final List<Pillar> shown = visionName == null
          ? pillars
          : pillars
                .where((p) => p.vision == null || p.vision == visionName)
                .toList();

      return ApiResult<PlanBoard>.success(
        data: PlanBoard(
          vision: vision,
          pillars: shown,
          objectives: <StrategicObjective>[
            for (final Map<String, dynamic> row in objectiveRows)
              if ((row['name'] ?? '').toString().isNotEmpty)
                StrategicObjective.fromMap(row),
          ],
          kpis: kpis,
          kpisRead: kpisRead,
        ),
      );
    } catch (e) {
      debugPrint('==> load plan failure: $e');
      return ApiResult<PlanBoard>.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<List<MasteryGoal>>> loadMasteryGoals() async {
    try {
      final List<Map<String, dynamic>> rows = _rows(
        await _gateway.call(VisionCmds.masteryGoals),
      );
      return ApiResult<List<MasteryGoal>>.success(
        data: <MasteryGoal>[
          for (final Map<String, dynamic> row in rows)
            if ((row['name'] ?? '').toString().isNotEmpty)
              MasteryGoal.fromMap(row),
        ],
      );
    } catch (e) {
      debugPrint('==> load mastery goals failure: $e');
      return ApiResult<List<MasteryGoal>>.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  /// A whitelisted `get_all` comes back — once the shared interceptor has
  /// unwrapped Frappe's `message` envelope — as a plain list of maps.
  /// Anything else is read as no rows rather than as a throw.
  static List<Map<String, dynamic>> _rows(Object? response) {
    if (response is! List) return const <Map<String, dynamic>>[];
    return <Map<String, dynamic>>[
      for (final Object? row in response)
        if (row is Map) row.cast<String, dynamic>(),
    ];
  }
}

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

import '../../domain/interface/objectives_repository_facade.dart';
import '../../models/data/objective_data.dart';

/// Gateway command names, as the productivity manifest routes them.
///
/// `productivity/frappe/manifest.json` registers
/// `{app_name}.tenant.api.<method>`; the platform gateway drops the leading
/// app segment and resolves the rest against the composed app's whitelist,
/// exactly as base_sdk's own `tenant.api.get_app_usage_stats` does. These
/// three had ZERO Dart callers before frame 44c.
class ObjectiveCmds {
  ObjectiveCmds._();

  static const String objectives = 'tenant.api.get_strategic_objectives';
  static const String pillars = 'tenant.api.get_pillars';
  static const String kpis = 'tenant.api.get_kpis';
}

/// Reads the plan through the platform gateway. Nothing here writes.
class ObjectivesRepositoryImpl implements ObjectivesRepositoryFacade {
  const ObjectivesRepositoryImpl({PlatformGateway gateway = const PlatformGateway()})
    : _gateway = gateway;

  final PlatformGateway _gateway;

  @override
  Future<ApiResult<ObjectiveCatalog>> loadCatalog() async {
    try {
      // Objectives and pillars are the picker's content and its filter:
      // either missing and there is nothing honest to draw, so both are
      // required. The KPI count is a chip ON a card; a failure there
      // costs the chip and not the list.
      final List<Map<String, dynamic>> objectiveRows = _rows(
        await _gateway.call(ObjectiveCmds.objectives),
      );
      final List<Map<String, dynamic>> pillarRows = _rows(
        await _gateway.call(ObjectiveCmds.pillars),
      );
      final Map<String, int> kpiCounts = <String, int>{};
      try {
        for (final Map<String, dynamic> kpi in _rows(
          await _gateway.call(ObjectiveCmds.kpis),
        )) {
          final String objective = (kpi['strategic_objective'] ?? '').toString();
          if (objective.isEmpty) continue;
          kpiCounts[objective] = (kpiCounts[objective] ?? 0) + 1;
        }
      } catch (e) {
        debugPrint('==> get_kpis failed; objective cards drawn without a KPI count: $e');
      }
      return ApiResult<ObjectiveCatalog>.success(
        data: ObjectiveCatalog(
          objectives: <StrategicObjective>[
            for (final Map<String, dynamic> row in objectiveRows)
              if ((row['name'] ?? '').toString().isNotEmpty)
                StrategicObjective.fromMap(row),
          ],
          pillars: <Pillar>[
            for (final Map<String, dynamic> row in pillarRows)
              if ((row['name'] ?? '').toString().isNotEmpty) Pillar.fromMap(row),
          ],
          kpiCountByObjective: kpiCounts,
        ),
      );
    } catch (e) {
      debugPrint('==> load objectives failure: $e');
      return ApiResult<ObjectiveCatalog>.failure(
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

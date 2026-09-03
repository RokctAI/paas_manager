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

// compliance-ignore-file: obs-flutter-trace (abstract facade interface; no HTTP calls in this file — flagged only by the repository/service filename heuristic)

import 'package:base_sdk/base_sdk.dart';

import '../../models/data/objective_data.dart';

/// The plan, read for the M2 bridge (design strip frame 44c).
///
/// READ-ONLY BY DESIGN. The productivity module whitelists six `get_*`
/// methods and nothing else on this chain, and the only write this bridge
/// ever performs is `strategic_objective` on the TASK, through the task
/// sync's `sync_personal_task`. Productivity's `commit_plan` is a
/// destructive whole-plan replace and is deliberately not reachable from
/// here.
abstract class ObjectivesRepositoryFacade {
  /// Reads the objectives, the pillars they belong to and the KPI count
  /// under each, from `get_strategic_objectives` / `get_pillars` /
  /// `get_kpis`.
  ///
  /// A failure is an [ApiResult.failure] with the backend's own message,
  /// never a throw: the picker draws it in place of the list.
  Future<ApiResult<ObjectiveCatalog>> loadCatalog();
}

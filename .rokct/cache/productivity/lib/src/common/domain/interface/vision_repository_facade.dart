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

import '../../models/data/vision_data.dart';

/// The plan and the mastery goals, read for design strip section 41 (the
/// M2 vision cluster: plan on a page, the objective drill, personal
/// mastery).
///
/// VIEW-FIRST, READ-ONLY BY DESIGN (flag (a) of the section). The
/// productivity module whitelists six `get_*` methods and nothing else;
/// every add/edit verb of the legacy CRUD dialogs is a write endpoint to
/// add at build time, and none exists yet — so nothing here writes, and
/// the screens draw no compose or edit chrome. `commit_plan` is a
/// destructive whole-plan replace and is deliberately not reachable.
abstract class VisionRepositoryFacade {
  /// Reads the board: the single Plan On A Page doc's vision (from
  /// `get_plan_on_a_page` + `get_visions`), its pillars (`get_pillars`),
  /// their objectives (`get_strategic_objectives`) and the KPIs under
  /// them (`get_kpis`).
  ///
  /// A failure is an [ApiResult.failure] with the backend's own message,
  /// never a throw: the page draws it in place of the board.
  Future<ApiResult<PlanBoard>> loadPlan();

  /// Reads the Personal Mastery Goals (`get_personal_mastery_goals`).
  Future<ApiResult<List<MasteryGoal>>> loadMasteryGoals();
}

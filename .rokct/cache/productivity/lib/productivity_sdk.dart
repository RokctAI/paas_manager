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

library productivity_sdk;

export 'src/common/domain/interface/todo_repository_facade.dart';
export 'src/common/domain/interface/recovery_repository_facade.dart';
export 'src/common/infrastructure/database/tasks_table.dart';
export 'src/common/infrastructure/database/productivity_owner_scope.dart';
export 'src/common/infrastructure/database/recovery_tables.dart';
export 'src/common/infrastructure/repositories/todo_repository_impl.dart';
export 'src/common/infrastructure/repositories/recovery_repository_impl.dart';
export 'src/common/infrastructure/services/task_service.dart';
// Task sync (2026-09-01): the client half of the personal-task endpoints
// that landed server-side on 2026-08-31. Exported so a host can register the
// handlers, trigger a sync or read the queue state without reaching into
// src/.
export 'src/common/infrastructure/services/task_sync_handlers.dart';
export 'src/common/infrastructure/services/task_sync_queue.dart';
export 'src/common/infrastructure/services/task_sync_store.dart';
export 'src/common/infrastructure/services/task_pull_service.dart';
export 'src/common/models/data/task_data.dart';
// Design strip frame 44c — the M2 bridge: the plan read for the objective
// picker, and the picker itself. Read-only over the gateway.
export 'src/common/models/data/objective_data.dart';
export 'src/common/domain/interface/objectives_repository_facade.dart';
export 'src/common/infrastructure/repositories/objectives_repository_impl.dart';
export 'src/common/presentation/tasks/objective_picker_pane.dart';
// Design strip section 41 — the M2 vision cluster: plan on a page (41a /
// 41d), the objective drill (41b) and personal mastery (41c). Read-only
// over the gateway (flag (a): view-first, the write endpoints do not exist
// yet); the installed `templates/pages/vision` pages are host code and
// reach the SDK through this barrel.
export 'src/common/models/data/vision_data.dart';
export 'src/common/domain/interface/vision_repository_facade.dart';
export 'src/common/infrastructure/repositories/vision_repository_impl.dart';
export 'src/common/presentation/vision/plan_board.dart';
export 'src/common/presentation/vision/objective_detail_pane.dart';
export 'src/common/presentation/vision/mastery_goal_card.dart';
export 'src/common/models/request/task_request.dart';
export 'src/common/models/response/task_response.dart';
export 'src/common/application/recovery/recovery_state.dart';
export 'src/common/application/recovery/recovery_notifier.dart';
export 'src/common/application/recovery/recovery_provider.dart';
export 'src/common/di/productivity_di.dart';

// Design strip section 44 — the /tasks workspace components. Exported so
// the installed `tasks_page.dart` template can compose them: the page is
// host code and reaches the SDK through this barrel.
export 'src/common/presentation/tasks/task_view_model.dart';
export 'src/common/presentation/tasks/task_card.dart';
export 'src/common/presentation/tasks/task_list_controls.dart';
export 'src/common/presentation/tasks/tasks_plane_claims.dart';

// Design strip section 46 — the guided run: the derivation (pure Dart,
// no store) and the view the installed `tasks_page.dart` and
// `task_run_page.dart` templates host.
export 'src/common/application/run/task_run.dart';
export 'src/common/application/run/maintenance_plant.dart';
export 'src/common/application/run/maintenance_seed.dart';
export 'src/common/application/run/recipe_seed.dart';
export 'src/common/application/run/maintenance_templates.dart';
export 'src/common/presentation/run/task_run_view.dart';
export 'src/common/presentation/plane_back_clearance.dart';
// Design strip frame 46i — the paused run on the hub's Tasks row: the
// derivation and its provider, and the line the host composes through the
// manifest's `// @productivity-tasks-row` integration.
export 'src/common/application/run/paused_run.dart';
export 'src/common/presentation/hub/paused_run_line.dart';
export 'src/common/application/glance/productivity_attention.dart';
export 'src/common/presentation/glance/needs_attention_glance.dart';

// Design strip section 47 — snooze, the long-term band and the sync-state
// badge, generic to every task.
export 'src/common/application/sync/task_sync_state.dart';
export 'src/common/presentation/tasks/task_reminder_controls.dart';
export 'src/common/presentation/tasks/task_sync_notice.dart';

// Section 47m, second pass — the long-term band is DERIVED from the task's
// end date (Ray: "long term task is selected not automatically detected
// from end date"). Exported because the installed tasks page applies the
// rule when it builds a task map, and the store applies it again on save.
export 'src/common/application/tasks/long_term_rule.dart';

// Notes — a second list on the /tasks workspace (Ray: "i cant do notes its
// only tasks and no seperate notes if need to be"). LOCAL ONLY: no backend
// this app composes has a note doctype, so there is no sync half to this
// feature and no note ever leaves the device.
export 'src/common/domain/interface/note_repository_facade.dart';
export 'src/common/infrastructure/database/notes_table.dart';
export 'src/common/infrastructure/repositories/note_repository_impl.dart';
export 'src/common/presentation/notes/note_view_model.dart';
export 'src/common/presentation/notes/note_card.dart';
export 'src/common/presentation/notes/notes_list_controls.dart';

// Ray, on the launcher's Tasks page: "plus opens new but i think hlding it
// should give me option like tasks notes" — the add button's long press, and
// the rule that picks the status filter the tasks list opens on ("when there
// is completed task switch from all to pending").
export 'src/common/presentation/tasks/new_item_sheet.dart';
export 'src/common/presentation/tasks/productivity_plus_nav.dart';
export 'src/common/application/tasks/initial_status_filter.dart';

// Sign-out — Ray, 2026-09-19: "if on temp local user you logout all your
// tasks still show". This SDK's own session-end tidy-up, registered against
// users_sdk's SessionEndHooks from this manifest's boot hook. Exported
// because that hook body is composed into the HOST's main.dart, which reaches
// this package only through this barrel.
export 'src/common/application/session/productivity_session_end.dart';

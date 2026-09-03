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

// Design strip section 46 — the guided run: the derivation (pure Dart,
// no store) and the view the installed `tasks_page.dart` and
// `task_run_page.dart` templates host.
export 'src/common/application/run/task_run.dart';
export 'src/common/presentation/run/task_run_view.dart';
// Design strip frame 46i — the paused run on the hub's Tasks row: the
// derivation and its provider, and the line the host composes through the
// manifest's `// @productivity-tasks-row` integration.
export 'src/common/application/run/paused_run.dart';
export 'src/common/presentation/hub/paused_run_line.dart';

// Design strip section 47 — snooze, the long-term band and the sync-state
// badge, generic to every task.
export 'src/common/application/sync/task_sync_state.dart';
export 'src/common/presentation/tasks/task_reminder_controls.dart';
export 'src/common/presentation/tasks/task_sync_notice.dart';

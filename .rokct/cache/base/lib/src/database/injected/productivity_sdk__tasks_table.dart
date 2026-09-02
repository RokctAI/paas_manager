// Copied at compose time from package:productivity_sdk/src/common/infrastructure/database/tasks_table.dart by sdk_installer_base.py's update_database_registration() -
// drift only understands table classes inside its own package.
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

import 'package:drift/drift.dart';

@DataClassName('TaskEntity')
class TasksTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  // currentDateAndTime is evaluated by SQLite at INSERT time; a
  // Constant(DateTime.now()) default freezes whatever timestamp the build
  // captured, stamping every later row with stale build-time data.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get createdBy => text().nullable()();
  TextColumn get data => text().nullable()(); // JSON blob fallback

  /// The device-minted id the server upserts on
  /// (`projects/frappe/src/task_sync.py`'s `client_id`).
  ///
  /// Separate from [id] on purpose. [id] is whatever the writing surface
  /// chose — the tasks page mints a uuid, another writer may not — whereas
  /// `client_id` is unique on the Task doctype and is the ONLY key the
  /// server has to recognise a task it has seen before. Minting it here,
  /// once, is what makes the push idempotent: a create retried after a
  /// dropped connection updates the same Task instead of making a second
  /// one.
  ///
  /// Nullable because rows written before this column existed have none;
  /// they gain one the first time they are saved.
  TextColumn get clientId => text().nullable()();

  /// The server's `name` for this task, learned from the handshake.
  ///
  /// Null until the first successful push (or pull) — which is the normal,
  /// permanent state on a device that never reaches a backend. Nothing on
  /// the local read path consults it, so a task with no [remoteId] behaves
  /// exactly like one that has never heard of a server.
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

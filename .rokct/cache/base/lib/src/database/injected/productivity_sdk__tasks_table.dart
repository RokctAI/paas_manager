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

  @override
  Set<Column> get primaryKey => {id};
}

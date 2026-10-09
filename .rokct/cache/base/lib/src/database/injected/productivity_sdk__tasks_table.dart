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

  /// Account this row belongs to, or the empty string for a row that
  /// belongs to nobody in particular - every row written before owner
  /// scoping existed, and every row written by an app nobody has signed
  /// into.
  ///
  /// The empty string is base_sdk's `kUnownedOwner`, written here as a
  /// literal rather than imported. This file is COPIED into base_sdk's own
  /// package at compose time (sdk_installer_base.py
  /// update_database_registration, because drift's modular analysis only
  /// understands table classes defined inside the package being
  /// generated), so a `package:base_sdk/...` import in it would become a
  /// self-import of the package the copy now lives in. The value is the
  /// one thing that has to agree, and a mismatch would show up as rows
  /// nobody can see on the very first read.
  ///
  /// NOT NULL with a default rather than nullable: SQLite - unlike the SQL
  /// standard - permits NULLs inside an ordinary rowid table's composite
  /// PRIMARY KEY, and NULL != NULL in the backing unique index, so a
  /// nullable owner would make `insertOnConflictUpdate` on an unowned row
  /// miss its conflict target and append a second row instead of updating
  /// the first.
  TextColumn get owner => text().withDefault(const Constant(''))();

  /// [owner] is part of the key, so two accounts on one device can hold
  /// rows with the same id side by side instead of one silently replacing
  /// the other's. Every read filters the key down to the rows the current
  /// account may see, with base_sdk's `ownerVisible`.
  @override
  Set<Column> get primaryKey => {id, owner};
}

/// Brings this SDK's owner-scoped tables up to their current definition when
/// the opened file predates owner scoping, and does nothing at all when it
/// does not. Returns the tables it actually rebuilt.
///
/// WHY IT LIVES IN A TABLE SOURCE. The composed `AppDatabase` belongs to
/// base_sdk; this package cannot add a method to it. What it CAN reach is
/// whatever the composer copies into base_sdk's package, and the composer
/// copies exactly the files named by `database.tables` in manifest.json -
/// this one among them (sdk_installer_base.py
/// `update_database_registration`). So the migration step declared in that
/// manifest calls this function, and the copy of this file that travels
/// beside the tables is what defines it. Everything it needs is on
/// [GeneratedDatabase]; it names no table getter, because the getters only
/// exist in the composed database's generated code.
///
/// WHY A REBUILD RATHER THAN `ALTER TABLE ... ADD COLUMN`. `owner` joins the
/// PRIMARY KEY of every table listed, so two accounts can hold the same id,
/// and SQLite cannot alter a primary key in place. Each table is therefore
/// rebuilt the long way round: rename the old one aside, create the new one
/// from its current Dart definition, copy every column the two have in
/// common, drop the old one. `owner` is not among the copied columns, so
/// every row already on the device takes its `''` default and comes out
/// UNOWNED - which is the state the visibility rule treats as the current
/// user's. Nothing is deleted and no owner is guessed.
///
/// Idempotent and self-checking (it reads the columns first), so running it
/// in the migration step, as a floor before the first read, or in both,
/// comes to the same thing.
Future<List<String>> ensureProductivityOwnerColumns(
  GeneratedDatabase db,
  List<TableInfo<Table, dynamic>> tables,
) async {
  final List<String> rebuilt = <String>[];
  // `Migrator(db)` rather than `db.createMigrator()`: the latter is both
  // @protected and @visibleForTesting, so calling it from a free function
  // raises two analyzer warnings in the HOST app that composes this file.
  // The public constructor is the same object.
  final Migrator m = Migrator(db);
  for (final TableInfo<Table, dynamic> table in tables) {
    final String name = table.actualTableName;
    final List<String> before = await _productivityColumnNames(db, name);
    // An absent table has no columns at all. base_sdk's own beforeOpen floor
    // creates whole missing tables, and it creates them from the current
    // definition, so one already has its owner column.
    if (before.isEmpty || before.contains('owner')) continue;
    final String carried = before
        .where(table.columnsByName.containsKey)
        .map((String c) => '"$c"')
        .join(', ');
    final String parked = '${name}_pre_owner_scope';
    await db.customStatement('DROP TABLE IF EXISTS "$parked"');
    await db.customStatement('ALTER TABLE "$name" RENAME TO "$parked"');
    await m.createTable(table);
    if (carried.isNotEmpty) {
      await db.customStatement(
        'INSERT INTO "$name" ($carried) SELECT $carried FROM "$parked"',
      );
    }
    await db.customStatement('DROP TABLE "$parked"');
    rebuilt.add(name);
  }
  return rebuilt;
}

/// Column names [table] has in the opened file, empty when there is no such
/// table. Reads `pragma_table_info` as a table-valued function so the name
/// binds as a parameter instead of being interpolated into SQL.
Future<List<String>> _productivityColumnNames(
  GeneratedDatabase db,
  String table,
) async {
  final rows = await db
      .customSelect(
        'SELECT name FROM pragma_table_info(?1)',
        variables: <Variable<Object>>[Variable<String>(table)],
      )
      .get();
  return rows.map((row) => row.read<String>('name')).toList();
}

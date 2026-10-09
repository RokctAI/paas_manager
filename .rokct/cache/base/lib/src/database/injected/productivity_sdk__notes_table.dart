// Copied at compose time from package:productivity_sdk/src/common/infrastructure/database/notes_table.dart by sdk_installer_base.py's update_database_registration() -
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

/// A plain-text note on the /tasks workspace — Ray, on the launcher's
/// Tasks page: "i cant do notes its only tasks and no seperate notes if
/// need to be".
///
/// NO SYNC COLUMNS, AND THAT IS THE WHOLE POINT. `TasksTable` carries a
/// `client_id` and a `remote_id` because a Task doctype exists to upsert
/// against. Nothing in any backend this app composes holds a note, so a
/// note has no server identity to keep and none is invented here: the
/// columns a row would need to be pushed are absent rather than sitting
/// there unused. Give notes a doctype later and this table gains them in
/// a migration, exactly as tasks did.
///
/// Every field is typed. Unlike a task — whose surface keeps a dozen
/// extras in a `data` JSON blob — a note IS its title, its body and the
/// moment it last changed, so there is nothing left over to encode.
@DataClassName('NoteEntity')
class NotesTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID

  /// The note's heading. May be empty: a note jotted body-first is still
  /// a note, and the list falls back to the body's first line.
  TextColumn get title => text().withDefault(const Constant(''))();

  /// The note itself, plain text. Not markdown, not rich text — nothing
  /// on the surface renders either, and a column that claimed to hold
  /// them would be a promise this SDK does not keep.
  TextColumn get body => text().withDefault(const Constant(''))();

  // currentDateAndTime is evaluated by SQLite at INSERT time; a
  // Constant(DateTime.now()) default freezes whatever timestamp the build
  // captured, stamping every later row with stale build-time data — the
  // same trap tasks_table.dart calls out.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

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

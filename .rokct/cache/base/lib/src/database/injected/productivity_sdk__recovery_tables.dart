// Copied at compose time from package:productivity_sdk/src/common/infrastructure/database/recovery_tables.dart by sdk_installer_base.py's update_database_registration() -
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

@DataClassName('RecoveryProfileEntity')
class RecoveryProfilesTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  DateTimeColumn get startDate => dateTime()();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  TextColumn get primaryTrigger => text().nullable()(); // Boredom, Stress, Loneliness, Fatigue, etc.

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

@DataClassName('AvoidedHabitEntity')
class AvoidedHabitsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get title => text()();
  TextColumn get motivation => text().nullable()(); // Personal reason for stopping
  DateTimeColumn get createdDate => dateTime()();

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

@DataClassName('UrgeLogEntity')
class UrgeLogsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get habitId => text().nullable()(); // References AvoidedHabitsTable id
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get intensity => integer()(); // 1 to 10
  TextColumn get triggerType => text()(); // Hungry, Angry, Lonely, Tired, Bored
  TextColumn get outcome => text()(); // Resisted, Relapsed
  TextColumn get reflectionNotes => text().nullable()(); // "why did I fail, what led to it"

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

@DataClassName('DailyRitualEntity')
class DailyRitualsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get routineType => text()(); // Morning, Afternoon, Evening
  TextColumn get iconEmoji => text().withDefault(const Constant('💧'))();
  IntColumn get targetDurationMinutes => integer().withDefault(const Constant(5))();

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

@DataClassName('ProcrastinationLogEntity')
class ProcrastinationLogsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get ritualId => text().nullable()(); // Reference to DailyRitualsTable id if applicable
  DateTimeColumn get scheduledTime => dateTime()();
  DateTimeColumn get logTime => dateTime()();
  IntColumn get delayCount => integer().withDefault(const Constant(0))(); // Number of times rescheduled/snoozed
  TextColumn get procrastinationReason => text().nullable()(); // Anxiety, Fatigue, Distraction, etc.
  BoolColumn get wasCompletedEventually => boolean().withDefault(const Constant(false))();

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

@DataClassName('RitualLogEntity')
class RitualLogsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get ritualId => text()(); // Reference to DailyRitualsTable id
  DateTimeColumn get completedAt => dateTime()();

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


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
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'tasks_table.dart';

/// This SDK's half of owner scoping: whose rows a write belongs to, which
/// tables carry an owner, and the floor that guarantees the column is there
/// before the first query touches it.
///
/// The rule is base_sdk's, unchanged: VISIBILITY SCOPING, NEVER DELETION. A
/// sign-out does not delete a row; it only stops the next account from
/// seeing the previous account's rows. An existing row with no owner counts
/// as the current account's - `owner = '' OR owner = <me>`, which is what
/// `ownerVisible` writes - because every row on every device in the field
/// has no owner and a strict match would hide all of them.
class ProductivityOwnerScope {
  ProductivityOwnerScope._();

  /// The account rows written now belong to, and whose rows reads return.
  ///
  /// Straight through to base_sdk's [OwnerScope] rather than a second
  /// resolver of this SDK's own: two answers to "who is using this device"
  /// is how a task and the outbox op pushing it end up owned by different
  /// accounts.
  static String get currentOwner => OwnerScope.instance.current;

  /// Every table of this SDK that carries an owner - all of them, because
  /// all of them hold personal user data.
  static List<TableInfo<Table, dynamic>> tablesOf(AppDatabase db) =>
      <TableInfo<Table, dynamic>>[
        db.tasksTable,
        db.notesTable,
        db.recoveryProfilesTable,
        db.avoidedHabitsTable,
        db.urgeLogsTable,
        db.dailyRitualsTable,
        db.ritualLogsTable,
        db.procrastinationLogsTable,
      ];

  static final Expando<Future<void>> _ready = Expando<Future<void>>();

  /// A FLOOR under the migration, awaited by every read and write this SDK
  /// makes, and never a replacement for correct migration numbering.
  ///
  /// base_sdk's `AppDatabase.beforeOpen` has a floor of its own, but it can
  /// only reach base's own tables: it creates any table missing from the
  /// opened file, and calls `ensureOwnerScopeColumns()` for the two tables
  /// base owns. A missing owner COLUMN on one of this SDK's tables has
  /// nothing under it - and that case is real, because the composer folds
  /// every SDK's migration into one shared version namespace: a device
  /// whose stored `user_version` already equals the composed maximum runs
  /// no migration at all, so the step declared in manifest.json never
  /// executes and the first read would throw on `no such column: owner`.
  ///
  /// This SDK cannot add anything to base's `beforeOpen`, so the floor is
  /// awaited at the point of use instead. Memoized per database, so the
  /// cost after the first call is one already-completed future. A failure
  /// is logged and NOT cached, so a transient error does not turn into a
  /// permanently broken store.
  static Future<void> ready(AppDatabase db) {
    final Future<void>? pending = _ready[db];
    if (pending != null) return pending;
    final Future<void> attempt = ensureProductivityOwnerColumns(
      db,
      tablesOf(db),
    ).then<void>((List<String> rebuilt) {
      if (rebuilt.isNotEmpty) {
        debugPrint('productivity_sdk: owner column added to ${rebuilt.join(', ')}');
      }
    }).catchError((Object e) {
      debugPrint('productivity_sdk: owner scope floor failed: $e');
      _ready[db] = null;
    });
    _ready[db] = attempt;
    return attempt;
  }

  /// Test-only: forget that the floor already ran for [db].
  @visibleForTesting
  static void debugForget(AppDatabase db) => _ready[db] = null;
}

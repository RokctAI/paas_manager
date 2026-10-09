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
import 'package:uuid/uuid.dart';

import '../../domain/interface/note_repository_facade.dart';
import '../database/productivity_owner_scope.dart';
import '../services/productivity_backup.dart';

/// The notes surface's store — the tasks store's pattern, minus the half
/// that exists only for the server.
///
/// `TodoRepositoryImpl` writes drift, then drops an op in the SyncEngine
/// outbox without waiting for it. This writes drift and stops, because
/// there is no note endpoint to drain into: notes are local to the device
/// (see `NoteRepositoryFacade`). Everything else is the same shape — one
/// row per note, a debugPrint on a failed read or write rather than a
/// throw that would take the list down with it, and an id minted here
/// when the caller brought none.
class NoteRepositoryImpl implements NoteRepositoryFacade {
  NoteRepositoryImpl(this._database);

  final AppDatabase _database;

  static const Uuid _uuid = Uuid();

  @override
  Future<List<Map<String, dynamic>>> loadNotes() async {
    try {
      await ProductivityOwnerScope.ready(_database);
      final String owner = ProductivityOwnerScope.currentOwner;
      // This account's notes plus every note that belongs to nobody in
      // particular; another account's notes on the same device are not
      // read and not returned.
      final List<NoteEntity> rows = await (_database.select(_database.notesTable)
            ..where((t) => ownerVisible(t.owner, owner)))
          .get();
      // Ordered here rather than in SQL: the list is one device's notes,
      // the ordering is the surface's (newest change first), and sorting
      // in Dart keeps this repository free of drift's generated table
      // types — which is what lets the codec be read on a bare checkout.
      final List<NoteEntity> ordered = List<NoteEntity>.of(rows)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return ordered.map(rowToNote).toList();
    } catch (e) {
      debugPrint('Error loading notes: $e');
      return <Map<String, dynamic>>[];
    }
  }

  @override
  Future<Map<String, dynamic>> saveNote(Map<String, dynamic> note) async {
    final String id = (note['id'] ?? '').toString().isNotEmpty
        ? note['id'].toString()
        : _uuid.v4();
    final String title = (note['title'] ?? '').toString().trim();
    final String body = (note['body'] ?? '').toString();
    // One clock for the write, read back by the caller: the list sorts on
    // updatedAt, so a value invented on the surface and a value stamped
    // here would sort the note into two different places.
    final DateTime now = DateTime.now();
    final DateTime createdAt = _parse(note['createdAt']) ?? now;
    final Map<String, dynamic> stored = <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    };
    // A FAILED WRITE IS NEVER REPORTED AS A SAVE. This used to swallow the
    // exception and return `stored` anyway, which is how a missing
    // notes_table reached the reader as a note that simply vanished - Ray:
    // "notes seem like cant save". The debugPrint stays (it is the only
    // record of what SQLite actually said) and the error is rethrown so the
    // surface can keep the editor open and say so. loadNotes still returns
    // an empty list on a failed READ: a list that cannot be read is empty
    // as far as the page is concerned and has nothing to keep open.
    try {
      await ProductivityOwnerScope.ready(_database);
      final String owner = ProductivityOwnerScope.currentOwner;
      // Claims the pre-scoping row for this id, for the reason the tasks
      // store claims its own: `owner` is in the primary key, so the
      // upsert conflicts on {id, owner} and an unclaimed twin would stay
      // behind, visible beside the note just written.
      if (owner != kUnownedOwner) {
        await (_database.update(_database.notesTable)
              ..where((t) =>
                  t.id.equals(id) & t.owner.equals(kUnownedOwner)))
            .write(NotesTableCompanion(owner: Value(owner)));
      }
      await _database.into(_database.notesTable).insertOnConflictUpdate(
            NotesTableCompanion.insert(
              id: Value(id),
              owner: Value(owner),
              title: Value(title),
              body: Value(body),
              createdAt: Value(createdAt),
              updatedAt: Value(now),
            ),
          );
    } catch (e) {
      debugPrint('Error saving note $id: $e');
      rethrow;
    }
    return stored;
  }

  @override
  Future<void> deleteNote(String id) async {
    if (id.isEmpty) return;
    try {
      await ProductivityOwnerScope.ready(_database);
      final String owner = ProductivityOwnerScope.currentOwner;
      // Deletes only what this account can see.
      await (_database.delete(_database.notesTable)
            ..where((t) =>
                t.id.equals(id) & ownerVisible(t.owner, owner)))
          .go();
    } catch (e) {
      debugPrint('Error deleting note $id: $e');
    }
  }

  @override
  Future<void> exportNotes(List<Map<String, dynamic>> notes) =>
      ProductivityBackup.share(
        notes,
        fileName: ProductivityBackup.notesFileName,
        text: ProductivityBackup.notesShareText,
      );

  @override
  Future<int> importNotes(List<Map<String, dynamic>> notes) async {
    final List<Map<String, dynamic>> fresh =
        ProductivityBackup.newOnly(await loadNotes(), notes);
    if (fresh.isEmpty) return 0;
    int added = 0;
    try {
      await ProductivityOwnerScope.ready(_database);
      final String owner = ProductivityOwnerScope.currentOwner;
      final DateTime now = DateTime.now();
      // One transaction: a backup is restored whole or not at all, never
      // left half-written by a refused row.
      await _database.transaction(() async {
        for (final Map<String, dynamic> note in fresh) {
          final String id = (note['id'] ?? '').toString().trim().isNotEmpty
              ? note['id'].toString().trim()
              : _uuid.v4();
          final DateTime createdAt = _parse(note['createdAt']) ?? now;
          // saveNote stamps "now" because a save IS a change; a restore
          // is not, so the note keeps the moment it last changed.
          final DateTime updatedAt = _parse(note['updatedAt']) ?? createdAt;
          await _database.into(_database.notesTable).insertOnConflictUpdate(
                NotesTableCompanion.insert(
                  id: Value(id),
                  owner: Value(owner),
                  title: Value((note['title'] ?? '').toString().trim()),
                  body: Value((note['body'] ?? '').toString()),
                  createdAt: Value(createdAt),
                  updatedAt: Value(updatedAt),
                ),
              );
        }
      });
      added = fresh.length;
    } catch (e) {
      debugPrint('Error importing notes: $e');
      rethrow;
    }
    return added;
  }

  /// One stored row as the surface's map.
  ///
  /// Package-internal codec for the same reason `TodoRepositoryImpl` keeps
  /// one: a second spelling of this decoding is how two readers drift
  /// apart.
  static Map<String, dynamic> rowToNote(NoteEntity row) => <String, dynamic>{
        'id': row.id,
        'title': row.title,
        'body': row.body,
        'createdAt': row.createdAt.toIso8601String(),
        'updatedAt': row.updatedAt.toIso8601String(),
      };

  static DateTime? _parse(Object? value) {
    if (value is DateTime) return value;
    final String text = (value ?? '').toString().trim();
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}

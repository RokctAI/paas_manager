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

/// The notes store, as the /tasks workspace reads and writes it.
///
/// Maps rather than a typed model for the same reason
/// `TodoRepositoryFacade` uses them: the surface holds a list of maps and
/// hands the same shape back, and the presentation layer reads it through
/// a view model it builds itself.
///
/// LOCAL ONLY, AND SAID SO HERE. There is no `syncNow` on this facade
/// because there is nothing to sync to: no backend this app composes has
/// a note doctype. A device's notes live on that device.
abstract class NoteRepositoryFacade {
  /// Every note, newest change first.
  Future<List<Map<String, dynamic>>> loadNotes();

  /// Inserts or updates one note and returns it as stored — the caller
  /// gets back the `updatedAt` the write actually stamped rather than
  /// guessing at it.
  ///
  /// THROWS WHEN THE WRITE DID NOT HAPPEN. A returned map means the note is
  /// in the store; a store that refused the row (a table the composed app
  /// never migrated in, a disk that is full) raises rather than handing
  /// back a map the reader would take for a saved note.
  Future<Map<String, dynamic>> saveNote(Map<String, dynamic> note);

  /// Removes one note by id. A missing id is a no-op, never an error.
  Future<void> deleteNote(String id);

  /// Writes [notes] to a backup file and opens the share sheet on it - the
  /// tasks Backup's format and road, under the notes file name.
  Future<void> exportNotes(List<Map<String, dynamic>> notes);

  /// Restores notes read from a backup [exportNotes] wrote, and returns how
  /// many were added.
  ///
  /// A note whose id is already held is SKIPPED, never overwritten. A
  /// restored note keeps the `createdAt` and `updatedAt` it was backed up
  /// with, so it sorts where it sorted before rather than to the top.
  Future<int> importNotes(List<Map<String, dynamic>> notes);
}

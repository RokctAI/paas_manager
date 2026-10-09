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

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// The one backup format the /tasks workspace reads and writes, for both
/// of its lists.
///
/// Ray: "only tasks seem to be able to export and notes doesnt", then "i
/// think they also need imprt". The tasks Backup (chip 835) already wrote
/// the list as a bare JSON array of the surface's item maps to a file in
/// the app documents directory and handed it to the share sheet. That path
/// is lifted here UNCHANGED - same file name, same share text, same
/// encoding - so a tasks backup made before this existed is byte-for-byte
/// what one made after it is, and notes take the same road under their own
/// file name. Import reads that same array back.
///
/// NOTHING HERE TOUCHES THE STORE. Writing imported items is the
/// repositories' job (`importTodos`, `importNotes`), through the same save
/// paths a typed item takes, so an imported task syncs exactly as a typed
/// one does and an imported note lands in the same table.
class ProductivityBackup {
  const ProductivityBackup._();

  /// The tasks backup's file name, as chip 835 always wrote it.
  static const String tasksFileName = 'todos_backup.json';

  /// The tasks backup's share-sheet text, as chip 835 always wrote it.
  static const String tasksShareText = 'My Todo Backup';

  /// The notes backup's file name: the tasks name's twin.
  static const String notesFileName = 'notes_backup.json';

  static const String notesShareText = 'My Notes Backup';

  /// The backup's bytes: a JSON array of item maps, nothing around it.
  static String encode(List<Map<String, dynamic>> items) => json.encode(items);

  /// Reads a backup back into item maps.
  ///
  /// Throws [NotABackupException] when [source] is not a JSON array - a file
  /// that is not a backup at all is reported, not silently imported as
  /// nothing. Inside a real array, an entry that is not an object is
  /// skipped rather than failing the whole file.
  static List<Map<String, dynamic>> decode(String source) {
    final Object? decoded;
    try {
      decoded = json.decode(source);
    } catch (_) {
      throw const NotABackupException();
    }
    if (decoded is! List) throw const NotABackupException();
    final List<Map<String, dynamic>> items = <Map<String, dynamic>>[];
    for (final Object? entry in decoded) {
      if (entry is! Map) continue;
      items.add(<String, dynamic>{
        for (final MapEntry<dynamic, dynamic> e in entry.entries)
          e.key.toString(): e.value,
      });
    }
    return items;
  }

  /// The items of [incoming] that are not already held.
  ///
  /// DUPLICATES ARE SKIPPED BY ID, NEVER OVERWRITTEN. An item whose id is
  /// already in [existing] stays exactly as it is on the device - importing
  /// an old backup must not roll a task or a note back to what it said
  /// when the backup was made - and a second copy of one id inside the
  /// same file is taken once. An item with no id is new by definition: the
  /// repository mints it one on save.
  static List<Map<String, dynamic>> newOnly(
    Iterable<Map<String, dynamic>> existing,
    Iterable<Map<String, dynamic>> incoming,
  ) {
    final Set<String> seen = <String>{
      for (final Map<String, dynamic> item in existing) _idOf(item),
    }..remove('');
    final List<Map<String, dynamic>> fresh = <Map<String, dynamic>>[];
    for (final Map<String, dynamic> item in incoming) {
      final String id = _idOf(item);
      if (id.isNotEmpty && !seen.add(id)) continue;
      fresh.add(Map<String, dynamic>.from(item));
    }
    return fresh;
  }

  /// The one line an import answers with: how many items were added and,
  /// when any were not, that they were already here.
  static String importSummary({
    required int added,
    required int read,
    required String noun,
  }) {
    final int skipped = read - added;
    final String head = added == 0
        ? 'Nothing new to import'
        : 'Imported $added ${added == 1 ? noun : '${noun}s'}';
    if (skipped <= 0) return '$head.';
    return '$head. $skipped already here, skipped.';
  }

  static String _idOf(Map<String, dynamic> item) =>
      (item['id'] ?? '').toString().trim();

  /// Writes [items] to [fileName] in the app documents directory and opens
  /// the share sheet on it. Never throws: a failed backup is logged, as the
  /// tasks Backup always did.
  static Future<void> share(
    List<Map<String, dynamic>> items, {
    required String fileName,
    required String text,
  }) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$fileName');
      await file.writeAsString(encode(items));
      await Share.shareXFiles(<XFile>[XFile(file.path)], text: text);
    } catch (e) {
      debugPrint('Error exporting data: $e');
    }
  }

  /// Asks the reader for a backup file and returns its text, or null when
  /// they cancelled or the file could not be read.
  static Future<String?> pickText() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['json'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return null;
      final PlatformFile picked = result.files.single;
      final Uint8List? bytes = picked.bytes;
      if (bytes != null) return utf8.decode(bytes);
      final String? path = picked.path;
      if (path == null) return null;
      return await File(path).readAsString();
    } catch (e) {
      debugPrint('Error reading backup file: $e');
      return null;
    }
  }
}

/// The file handed to an import is not a backup this workspace wrote: not
/// JSON at all, or JSON that is not an array of items.
class NotABackupException implements Exception {
  const NotABackupException();

  @override
  String toString() =>
      'NotABackupException: a backup is a JSON array of items.';
}

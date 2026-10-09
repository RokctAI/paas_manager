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

import 'package:intl/intl.dart';

/// One note, as the notes components read it.
///
/// Built from the store's map by hand, exactly as `TaskViewModel` is, and
/// for the same reason: no generated code, so the components and their
/// tests load on a bare checkout.
class NoteViewModel {
  const NoteViewModel({
    required this.id,
    this.title = '',
    this.body = '',
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  /// The heading as typed. MAY BE EMPTY — see [displayTitle], which is
  /// what the list draws.
  final String title;

  /// The note, plain text.
  final String body;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// What the list draws as the note's name: the title, else the body's
  /// first non-empty line, else a plain word for a note with neither.
  ///
  /// DERIVED, never stored. A note jotted body-first has no title and must
  /// still be findable in the list; writing the first line INTO the title
  /// column instead would make a later edit of the body silently disagree
  /// with the heading.
  String get displayTitle {
    if (title.trim().isNotEmpty) return title.trim();
    for (final String line in body.split('\n')) {
      if (line.trim().isNotEmpty) return line.trim();
    }
    return 'Untitled note';
  }

  /// The body with its first line dropped when that line is standing in
  /// as the title, so the card never prints the same words twice.
  String get preview {
    final String source = title.trim().isNotEmpty
        ? body
        : body.replaceFirst(displayTitle, '');
    return source.trim().replaceAll(RegExp(r'\s*\n\s*'), ' ');
  }

  bool get isEmpty => title.trim().isEmpty && body.trim().isEmpty;

  /// "Updated Sep 14, 08:30 AM" — the moment the note last changed, which
  /// is the only time a note has that the reader cares about.
  String get updatedLabel {
    final DateTime? when = updatedAt ?? createdAt;
    if (when == null) return '';
    return 'Updated ${kNoteUpdatedFormat.format(when)}';
  }

  factory NoteViewModel.fromMap(Map<String, dynamic> map) => NoteViewModel(
        id: '${map['id'] ?? ''}',
        title: '${map['title'] ?? ''}',
        body: '${map['body'] ?? ''}',
        createdAt: _parse(map['createdAt']),
        updatedAt: _parse(map['updatedAt']),
      );

  /// Back to the store's map. The surface hands this straight to
  /// `NoteRepositoryFacade.saveNote`, so the two shapes are one shape.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'body': body,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };

  static DateTime? _parse(Object? value) {
    if (value is DateTime) return value;
    final String text = (value ?? '').toString().trim();
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}

/// The one date format the notes surface uses — the same pattern
/// `kTaskDeadlineFormat` gives a deadline, so a note and a task read
/// alike in the same column.
final DateFormat kNoteUpdatedFormat = DateFormat('MMM dd, hh:mm a');

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

/// Section 47m, second pass — WHAT MAKES A TASK LONG TERM IS ITS END DATE.
///
/// The band shipped with a hand switch on the compose form, and the frame
/// said so out loud: "set by hand ... nothing derives it". Ray, on the
/// launcher's Tasks page: "long term task is selected not automatically
/// detected from end date". So the switch is gone and this is the rule
/// that replaced it.
///
/// THE RULE, IN ONE PLACE. A task is long term when its end date is more
/// than [horizonDays] days past the date it starts from — its start date
/// if it has one, else the date it was created. A task with no end date
/// is NOT long term: there is no horizon to measure, and guessing one
/// from a creation date alone would sweep every undated task into the
/// band.
///
/// The stored `isLongTerm` field stays exactly where it was — the card
/// badge, the band split and the `is_long_term` column on the synced Task
/// doctype all still read it. What changed is who writes it: this rule,
/// on every save, instead of a switch.
abstract final class LongTermRule {
  /// The cut-off. An end date further than this many days from the start
  /// is a long-term commitment rather than part of the day's work.
  ///
  /// ONE NAME, ONE PLACE. Every caller measures against this constant so
  /// the band cannot mean one span on the form and another in the list.
  static const int horizonDays = 30;

  /// Whether a task running [startDate] → [endDate] is long term.
  ///
  /// [startDate] is the task's own start when it has one; [createdAt] is
  /// the fallback, which is what the local task map actually carries (the
  /// surface has no start-date field). With neither, the span cannot be
  /// measured from anything and the answer is false.
  static bool isLongTerm({
    DateTime? endDate,
    DateTime? startDate,
    DateTime? createdAt,
  }) {
    if (endDate == null) return false;
    final DateTime? from = startDate ?? createdAt;
    if (from == null) return false;
    // UTC on both sides: a span measured across a DST boundary in local
    // time is off by an hour, which at exactly 30 days decides the band.
    return endDate.toUtc().difference(from.toUtc()).inDays > horizonDays;
  }

  /// The rule applied to one task map — the shape every writer on the
  /// tasks surface passes around (`deadline` is the end date, `createdAt`
  /// the fallback start).
  ///
  /// Parses defensively for the same reason [isLongTerm] returns false on
  /// a missing date: a hand-edited or pulled row with an unparseable
  /// deadline must not throw on the save path.
  static bool forTodo(Map<String, dynamic> todo) => isLongTerm(
        endDate: _parse(todo['deadline']),
        startDate: _parse(todo['startDate']),
        createdAt: _parse(todo['createdAt']),
      );

  /// The task's own start date off its map, or null.
  ///
  /// The tasks surface has no start-date field, so this is null for every
  /// task it writes and the creation date carries the measurement. It is
  /// read anyway because the synced Task doctype DOES have one
  /// (`exp_start_date`), and a pulled task that brings it should be
  /// measured from it rather than from the day this device first saw it.
  static DateTime? startDateOf(Map<String, dynamic> todo) =>
      _parse(todo['startDate']);

  static DateTime? _parse(Object? value) {
    if (value is DateTime) return value;
    final String text = (value ?? '').toString().trim();
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}

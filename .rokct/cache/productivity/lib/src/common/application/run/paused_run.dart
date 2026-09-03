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

// DESIGN STRIP FRAME 46i — "opening the app days later: the paused run
// announces itself on the door it lives behind" (approved 2026-08-30;
// 2026-08-31: 47j folds into it).
//
// DERIVED, LIKE THE RUN ITSELF. There is no "paused runs" table and no
// flag anybody sets: a paused run IS a task whose steps have been touched
// and not finished (`TaskRun.isInProgress`), read off the same local
// store the /tasks page reads. Progress that survives the app closing is
// worthless if the user has to remember it exists, so this derivation is
// what the hub's Tasks row reads to say so.
//
// GENERIC ON THE TASK. A paused RO plant maintenance run surfaces here on
// identical terms to any other task — same badge, same row, same group
// (the owner's ruling: "it doesnt have any privilege"). Nothing here
// knows what the task is for.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/interface/todo_repository_facade.dart';
import '../../infrastructure/repositories/todo_repository_impl.dart';
import '../app_database_provider.dart';
import 'task_run.dart';

/// One run that stopped mid-way.
class PausedRun {
  const PausedRun({
    required this.taskId,
    required this.taskTitle,
    required this.run,
  });

  final String taskId;
  final String taskTitle;
  final TaskRun run;

  /// "Step 3 of 6" — the words on chip 859, from the run.
  String get positionLabel => run.positionLabel ?? '';

  /// When the run was last touched; null only for a run whose steps carry
  /// no timestamps (ticked by hand, never through the runner).
  DateTime? get lastTouched => run.lastTouched;
}

/// Every paused run on the device, most recently touched first.
class PausedRunSummary {
  const PausedRunSummary(this.runs);

  final List<PausedRun> runs;

  int get count => runs.length;

  bool get isEmpty => runs.isEmpty;

  /// The run the line names: the one touched most recently.
  PausedRun get first => runs.first;

  /// Reads the paused runs off the /tasks surface's task maps, or null
  /// when there is none — null so the line has nothing to draw and draws
  /// nothing, which is the frame's own rule ("the line disappears when no
  /// run is paused").
  static PausedRunSummary? fromTodos(List<Map<String, dynamic>> todos) {
    final List<PausedRun> paused = <PausedRun>[];
    for (final Map<String, dynamic> todo in todos) {
      if (todo['isDone'] == true) continue;
      final TaskRun run = TaskRun.fromTask(todo);
      if (!run.isInProgress) continue;
      paused.add(
        PausedRun(
          taskId: (todo['id'] ?? '').toString(),
          taskTitle: (todo['title'] ?? '').toString(),
          run: run,
        ),
      );
    }
    if (paused.isEmpty) return null;
    paused.sort((PausedRun a, PausedRun b) {
      final DateTime? ta = a.lastTouched;
      final DateTime? tb = b.lastTouched;
      if (ta == null && tb == null) return 0;
      if (ta == null) return 1;
      if (tb == null) return -1;
      return tb.compareTo(ta);
    });
    return PausedRunSummary(paused);
  }
}

/// "kept from Thursday" — when the run was last touched, in the words a
/// person uses for a recent day: today, yesterday, a weekday within the
/// week, else the date. Null when the run carries no timestamp.
String? keptFromLabel(DateTime? touched, {DateTime? now}) {
  if (touched == null) return null;
  final DateTime today = now ?? DateTime.now();
  final DateTime day = DateTime(touched.year, touched.month, touched.day);
  final DateTime thisDay = DateTime(today.year, today.month, today.day);
  final int daysAgo = thisDay.difference(day).inDays;
  if (daysAgo <= 0) return 'kept from earlier today';
  if (daysAgo == 1) return 'kept from yesterday';
  if (daysAgo < 7) return 'kept from ${_weekdays[touched.weekday - 1]}';
  return 'kept from ${touched.day} ${_months[touched.month - 1]}';
}

const List<String> _weekdays = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const List<String> _months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// The tasks store, for readers outside the /tasks page.
final Provider<TodoRepositoryFacade> todoRepositoryProvider =
    Provider<TodoRepositoryFacade>(
      (ref) => TodoRepositoryImpl(ref.watch(appDatabaseProvider)),
    );

/// FRAME 46i — the paused runs, read fresh each time something listens.
///
/// Auto-disposed on purpose: the hub row that watches it is rebuilt on
/// every visit to the hub, and a run that was resumed and finished since
/// the last visit must not be announced again from a cached answer. The
/// read is the local store and nothing else — no network, no wait.
final AutoDisposeFutureProvider<PausedRunSummary?> pausedRunProvider =
    FutureProvider.autoDispose<PausedRunSummary?>((ref) async {
      final List<Map<String, dynamic>> todos = await ref
          .watch(todoRepositoryProvider)
          .loadTodos();
      return PausedRunSummary.fromTodos(todos);
    });

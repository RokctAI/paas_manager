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
import 'package:uuid/uuid.dart';
import '../../domain/interface/recovery_repository_facade.dart';
import '../database/productivity_owner_scope.dart';

class RecoveryRepositoryImpl implements RecoveryRepositoryFacade {
  final AppDatabase _database;

  RecoveryRepositoryImpl(this._database);

  /// Trigger types a consumer logs as CHECK-INS rather than urges: a
  /// resisted log that extends the streak (lms's attended lesson is
  /// `attended-session`), not a moment the user wanted to give in. The
  /// weekly summary counts them as `checkIns`, never as `urgeEvents`.
  static const Set<String> checkInTriggerTypes = <String>{'attended-session'};

  @override
  Future<Map<String, int>> getStreakStats() async {
    try {
      final profiles = await _visibleProfiles();
      if (profiles.isNotEmpty) {
        final profile = profiles.first;
        return {
          'currentStreak': profile.currentStreak,
          'longestStreak': profile.longestStreak,
        };
      }
    } catch (e) {
      // Logging omitted for absolute safety / privacy policy compliance
    }
    return {
      'currentStreak': 0,
      'longestStreak': 0,
    };
  }

  @override
  Future<Map<String, int>> getWeeklySummary(DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    bool inWindow(DateTime t) => !t.isBefore(weekStart) && t.isBefore(weekEnd);
    var urgeEvents = 0;
    var checkIns = 0;
    var procrastinations = 0;
    var ritualsCompleted = 0;
    var currentStreak = 0;
    try {
      await ProductivityOwnerScope.ready(_database);
      final String owner = ProductivityOwnerScope.currentOwner;
      final urges = await (_database.select(_database.urgeLogsTable)
            ..where((t) => ownerVisible(t.owner, owner)))
          .get();
      for (final u in urges.where((u) => inWindow(u.timestamp))) {
        if (checkInTriggerTypes.contains(u.triggerType)) {
          checkIns++;
        } else {
          urgeEvents++;
        }
      }

      final procs =
          await (_database.select(_database.procrastinationLogsTable)
                ..where((t) => ownerVisible(t.owner, owner)))
              .get();
      procrastinations = procs.where((p) => inWindow(p.logTime)).length;

      final rituals = await (_database.select(_database.ritualLogsTable)
            ..where((t) => ownerVisible(t.owner, owner)))
          .get();
      ritualsCompleted =
          rituals.where((r) => inWindow(r.completedAt)).length;

      final profiles = await _visibleProfiles();
      if (profiles.isNotEmpty) currentStreak = profiles.first.currentStreak;
    } catch (e) {
      // Fail soft: a partial/empty summary beats crashing the report.
    }
    return {
      'urgeEvents': urgeEvents,
      'checkIns': checkIns,
      'procrastinations': procrastinations,
      'ritualsCompleted': ritualsCompleted,
      'currentStreak': currentStreak,
    };
  }

  @override
  Future<void> logUrge({
    required int intensity,
    required String triggerType,
    required String outcome,
    String? reflectionNotes,
    String? habitId,
  }) async {
    try {
      await ProductivityOwnerScope.ready(_database);
      // Read BEFORE this log is written: whether today already extended
      // the streak.
      final bool countedToday = await _streakCountedToday();
      final uuid = const Uuid().v4();
      await _database.into(_database.urgeLogsTable).insert(
        UrgeLogsTableCompanion.insert(
          id: Value(uuid),
          owner: Value(ProductivityOwnerScope.currentOwner),
          habitId: Value(habitId),
          timestamp: DateTime.now(),
          intensity: intensity,
          triggerType: triggerType,
          outcome: outcome,
          reflectionNotes: Value(reflectionNotes),
        ),
      );

      // If relapse occurs, reset current streak to 0. Otherwise the streak
      // grows by one DAY: a second resisted log on the same calendar day
      // (two lessons attended, say) does not count twice.
      if (outcome == 'Relapsed') {
        await _updateStreak(0);
      } else if (!countedToday) {
        await _incrementStreak();
      }
    } catch (e) {
      // Ignored for privacy
    }
  }

  @override
  Future<void> completeRitual(String ritualId) async {
    try {
      await ProductivityOwnerScope.ready(_database);
      final uuid = const Uuid().v4();
      await _database.into(_database.ritualLogsTable).insert(
        RitualLogsTableCompanion.insert(
          id: Value(uuid),
          owner: Value(ProductivityOwnerScope.currentOwner),
          ritualId: ritualId,
          completedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      // Ignored for privacy
    }
  }

  @override
  Future<void> logProcrastination({
    required String? ritualId,
    required DateTime scheduledTime,
    required int delayCount,
    String? reason,
  }) async {
    try {
      await ProductivityOwnerScope.ready(_database);
      final uuid = const Uuid().v4();
      await _database.into(_database.procrastinationLogsTable).insert(
        ProcrastinationLogsTableCompanion.insert(
          id: Value(uuid),
          owner: Value(ProductivityOwnerScope.currentOwner),
          ritualId: Value(ritualId),
          scheduledTime: scheduledTime,
          logTime: DateTime.now(),
          delayCount: Value(delayCount),
          procrastinationReason: Value(reason),
          wasCompletedEventually: const Value(false),
        ),
      );
    } catch (e) {
      // Ignored for privacy
    }
  }

  // --- Helper Methods ---

  /// The recovery profiles this account may see: its own, plus every
  /// profile that belongs to nobody in particular. A second account on the
  /// device gets its own profile rather than inheriting the first
  /// account's streak - and the first account's profile stays on disk.
  Future<List<RecoveryProfileEntity>> _visibleProfiles() async {
    await ProductivityOwnerScope.ready(_database);
    final String owner = ProductivityOwnerScope.currentOwner;
    return (_database.select(_database.recoveryProfilesTable)
          ..where((t) => ownerVisible(t.owner, owner))
          ..orderBy([(t) => OrderingTerm.desc(t.owner)]))
        .get();
  }

  /// Whether a resisted log already extended the streak today: the latest
  /// of today's logs before this one is a resisted one. A relapse later in
  /// the day reset the streak, so a resisted log after it counts again.
  Future<bool> _streakCountedToday() async {
    final String owner = ProductivityOwnerScope.currentOwner;
    final DateTime now = DateTime.now();
    final DateTime dayStart = DateTime(now.year, now.month, now.day);
    final today = await (_database.select(_database.urgeLogsTable)
          ..where((t) =>
              t.owner.equals(owner) &
              t.timestamp.isBiggerOrEqualValue(dayStart))
          // Timestamps are stored to the second, so two logs in the same
          // second tie; the rowid breaks the tie in write order.
          ..orderBy([
            (t) => OrderingTerm.desc(t.timestamp),
            (t) => OrderingTerm.desc(t.rowId),
          ])
          ..limit(1))
        .get();
    return today.isNotEmpty && today.first.outcome != 'Relapsed';
  }

  /// The profiles a streak WRITE may touch: only the signed-in account's
  /// own. Reads still see the unowned profile (legacy rows stay visible),
  /// but writing to it would carry one account's streak into the next
  /// account's view, so an account without a profile of its own gets one.
  /// With nobody signed in the unowned profile is the account's own.
  Future<List<RecoveryProfileEntity>> _ownProfiles() async {
    await ProductivityOwnerScope.ready(_database);
    final String owner = ProductivityOwnerScope.currentOwner;
    return (_database.select(_database.recoveryProfilesTable)
          ..where((t) => t.owner.equals(owner)))
        .get();
  }

  Future<void> _updateStreak(int newStreak) async {
    final profiles = await _ownProfiles();
    if (profiles.isEmpty) {
      await _database.into(_database.recoveryProfilesTable).insert(
        RecoveryProfilesTableCompanion.insert(
          id: Value(const Uuid().v4()),
          owner: Value(ProductivityOwnerScope.currentOwner),
          startDate: DateTime.now(),
          currentStreak: Value(newStreak),
          longestStreak: Value(newStreak),
        ),
      );
    } else {
      final profile = profiles.first;
      int longest = profile.longestStreak;
      if (newStreak > longest) {
        longest = newStreak;
      }
      await (_database.update(_database.recoveryProfilesTable)
            ..where((t) =>
                t.id.equals(profile.id) & t.owner.equals(profile.owner)))
          .write(
        RecoveryProfilesTableCompanion(
          currentStreak: Value(newStreak),
          longestStreak: Value(longest),
        ),
      );
    }
  }

  Future<void> _incrementStreak() async {
    final profiles = await _ownProfiles();
    if (profiles.isEmpty) {
      await _updateStreak(1);
    } else {
      final profile = profiles.first;
      final newStreak = profile.currentStreak + 1;
      await _updateStreak(newStreak);
    }
  }
}

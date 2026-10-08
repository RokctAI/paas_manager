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
    var procrastinations = 0;
    var ritualsCompleted = 0;
    var currentStreak = 0;
    try {
      await ProductivityOwnerScope.ready(_database);
      final String owner = ProductivityOwnerScope.currentOwner;
      final urges = await (_database.select(_database.urgeLogsTable)
            ..where((t) => ownerVisible(t.owner, owner)))
          .get();
      urgeEvents = urges.where((u) => inWindow(u.timestamp)).length;

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

      // If relapse occurs, reset current streak to 0. Otherwise, evaluate streak increment.
      if (outcome == 'Relapsed') {
        await _updateStreak(0);
      } else {
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

  Future<void> _updateStreak(int newStreak) async {
    final profiles = await _visibleProfiles();
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
    final profiles = await _visibleProfiles();
    if (profiles.isEmpty) {
      await _updateStreak(1);
    } else {
      final profile = profiles.first;
      final newStreak = profile.currentStreak + 1;
      await _updateStreak(newStreak);
    }
  }
}

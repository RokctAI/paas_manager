// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:base_sdk/base_sdk.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../domain/interface/recovery_repository_facade.dart';

class RecoveryRepositoryImpl implements RecoveryRepositoryFacade {
  final AppDatabase _database;

  RecoveryRepositoryImpl(this._database);

  @override
  Future<Map<String, int>> getStreakStats() async {
    try {
      final profiles = await _database.select(_database.recoveryProfilesTable).get();
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
      final urges = await _database.select(_database.urgeLogsTable).get();
      urgeEvents = urges.where((u) => inWindow(u.timestamp)).length;

      final procs =
          await _database.select(_database.procrastinationLogsTable).get();
      procrastinations = procs.where((p) => inWindow(p.logTime)).length;

      final rituals = await _database.select(_database.ritualLogsTable).get();
      ritualsCompleted =
          rituals.where((r) => inWindow(r.completedAt)).length;

      final profiles =
          await _database.select(_database.recoveryProfilesTable).get();
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
      final uuid = const Uuid().v4();
      await _database.into(_database.urgeLogsTable).insert(
        UrgeLogsTableCompanion.insert(
          id: Value(uuid),
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
      final uuid = const Uuid().v4();
      await _database.into(_database.ritualLogsTable).insert(
        RitualLogsTableCompanion.insert(
          id: Value(uuid),
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
      final uuid = const Uuid().v4();
      await _database.into(_database.procrastinationLogsTable).insert(
        ProcrastinationLogsTableCompanion.insert(
          id: Value(uuid),
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

  Future<void> _updateStreak(int newStreak) async {
    final profiles = await _database.select(_database.recoveryProfilesTable).get();
    if (profiles.isEmpty) {
      await _database.into(_database.recoveryProfilesTable).insert(
        RecoveryProfilesTableCompanion.insert(
          id: Value(const Uuid().v4()),
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
            ..where((t) => t.id.equals(profile.id)))
          .write(
        RecoveryProfilesTableCompanion(
          currentStreak: Value(newStreak),
          longestStreak: Value(longest),
        ),
      );
    }
  }

  Future<void> _incrementStreak() async {
    final profiles = await _database.select(_database.recoveryProfilesTable).get();
    if (profiles.isEmpty) {
      await _updateStreak(1);
    } else {
      final profile = profiles.first;
      final newStreak = profile.currentStreak + 1;
      await _updateStreak(newStreak);
    }
  }
}

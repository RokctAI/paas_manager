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
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_sdk/productivity_sdk.dart';
import '../../domain/interface/recovery_repository_facade.dart';
import 'recovery_state.dart';

class RecoveryNotifier extends StateNotifier<RecoveryState> {
  final RecoveryRepositoryFacade _repository;
  final AppDatabase _database;

  RecoveryNotifier(this._repository, this._database) : super(RecoveryState()) {
    loadRecoveryData();
  }

  Future<void> loadRecoveryData() async {
    state = state.copyWith(isLoading: true);
    try {
      final stats = await _repository.getStreakStats();
      
      // Check if there is an active urge logged within the last 2 hours
      final recentUrges = await (_database.select(_database.urgeLogsTable)
            ..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)])
            ..limit(1))
          .get();
      
      bool hasActiveUrge = false;
      if (recentUrges.isNotEmpty) {
        final lastUrge = recentUrges.first;
        final difference = DateTime.now().difference(lastUrge.timestamp);
        if (difference.inHours < 2 && lastUrge.outcome == 'Resisted') {
          hasActiveUrge = true;
        }
      }

      // Query the next uncompleted ritual for the current time of day
      final rituals = await _database.select(_database.dailyRitualsTable).get();
      DailyRitualEntity? nextRitual;
      if (rituals.isNotEmpty) {
        nextRitual = rituals.first; // Simply display the first available ritual for preview
      }

      // Check if any task has been delayed >= 2 times
      final delayedLogs = await (_database.select(_database.procrastinationLogsTable)
            ..where((t) => t.delayCount.isBiggerOrEqualValue(2))
            ..limit(1))
          .get();

      state = state.copyWith(
        currentStreak: stats['currentStreak'] ?? 0,
        longestStreak: stats['longestStreak'] ?? 0,
        hasActiveUrge: hasActiveUrge,
        nextRitual: nextRitual,
        hasDelayedTasks: delayedLogs.isNotEmpty,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logUrge({
    required int intensity,
    required String triggerType,
    required String outcome,
    String? reflectionNotes,
    String? habitId,
  }) async {
    try {
      await _repository.logUrge(
        intensity: intensity,
        triggerType: triggerType,
        outcome: outcome,
        reflectionNotes: reflectionNotes,
        habitId: habitId,
      );
      await loadRecoveryData();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> completeRitual(String ritualId) async {
    try {
      await _repository.completeRitual(ritualId);
      await loadRecoveryData();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> logProcrastination({
    required String? ritualId,
    required DateTime scheduledTime,
    required int delayCount,
    String? reason,
  }) async {
    try {
      await _repository.logProcrastination(
        ritualId: ritualId,
        scheduledTime: scheduledTime,
        delayCount: delayCount,
        reason: reason,
      );
      await loadRecoveryData();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

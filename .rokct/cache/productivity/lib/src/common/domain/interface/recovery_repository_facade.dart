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

// compliance-ignore-file: obs-flutter-trace (abstract facade interface; no HTTP calls in this file — flagged only by the repository/service filename heuristic)

abstract class RecoveryRepositoryFacade {
  /// Retrieves the current user streak and longest streak records
  Future<Map<String, int>> getStreakStats();

  /// Aggregates the behavior logs over the 7-day window starting at
  /// [weekStart] (added for the accountability-partner weekly report — the
  /// log tables already hold everything; see
  /// agent/lms/docs/adr-recovery-reuse-for-accountability.md). Keys:
  /// `urgeEvents`, `procrastinations`, `ritualsCompleted`, `currentStreak`.
  /// This module stays domain-neutral — the recovery vocabulary is
  /// translated by the consumer's host adapter, never surfaced raw.
  Future<Map<String, int>> getWeeklySummary(DateTime weekStart);

  /// Logs a new urge event, capturing trigger level and emotional blockers
  Future<void> logUrge({
    required int intensity,
    required String triggerType,
    required String outcome,
    String? reflectionNotes,
    String? habitId,
  });

  /// Tracks a completed daily ritual task
  Future<void> completeRitual(String ritualId);

  /// Registers a delayed or snoozed task for procrastination analysis
  Future<void> logProcrastination({
    required String? ritualId,
    required DateTime scheduledTime,
    required int delayCount,
    String? reason,
  });
}

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

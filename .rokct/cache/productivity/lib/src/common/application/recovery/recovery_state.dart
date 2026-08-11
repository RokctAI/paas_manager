import 'package:base_sdk/base_sdk.dart';
import 'package:productivity_sdk/productivity_sdk.dart';

class RecoveryState {
  final int currentStreak;
  final int longestStreak;
  final bool hasActiveUrge;
  final DailyRitualEntity? nextRitual;
  final bool hasDelayedTasks;
  final bool isLoading;
  final String? errorMessage;

  RecoveryState({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.hasActiveUrge = false,
    this.nextRitual,
    this.hasDelayedTasks = false,
    this.isLoading = false,
    this.errorMessage,
  });

  RecoveryState copyWith({
    int? currentStreak,
    int? longestStreak,
    bool? hasActiveUrge,
    DailyRitualEntity? nextRitual,
    bool? hasDelayedTasks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RecoveryState(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      hasActiveUrge: hasActiveUrge ?? this.hasActiveUrge,
      nextRitual: nextRitual ?? this.nextRitual,
      hasDelayedTasks: hasDelayedTasks ?? this.hasDelayedTasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

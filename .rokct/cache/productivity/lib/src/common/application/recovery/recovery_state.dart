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

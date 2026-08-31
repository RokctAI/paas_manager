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

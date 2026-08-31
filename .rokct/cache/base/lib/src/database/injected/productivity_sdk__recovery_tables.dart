// Copied at compose time from package:productivity_sdk/src/common/infrastructure/database/recovery_tables.dart by sdk_installer_base.py's update_database_registration() -
// drift only understands table classes inside its own package.
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

import 'package:drift/drift.dart';

@DataClassName('RecoveryProfileEntity')
class RecoveryProfilesTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  DateTimeColumn get startDate => dateTime()();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  TextColumn get primaryTrigger => text().nullable()(); // Boredom, Stress, Loneliness, Fatigue, etc.

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AvoidedHabitEntity')
class AvoidedHabitsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get title => text()();
  TextColumn get motivation => text().nullable()(); // Personal reason for stopping
  DateTimeColumn get createdDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UrgeLogEntity')
class UrgeLogsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get habitId => text().nullable()(); // References AvoidedHabitsTable id
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get intensity => integer()(); // 1 to 10
  TextColumn get triggerType => text()(); // Hungry, Angry, Lonely, Tired, Bored
  TextColumn get outcome => text()(); // Resisted, Relapsed
  TextColumn get reflectionNotes => text().nullable()(); // "why did I fail, what led to it"

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DailyRitualEntity')
class DailyRitualsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get routineType => text()(); // Morning, Afternoon, Evening
  TextColumn get iconEmoji => text().withDefault(const Constant('💧'))();
  IntColumn get targetDurationMinutes => integer().withDefault(const Constant(5))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProcrastinationLogEntity')
class ProcrastinationLogsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get ritualId => text().nullable()(); // Reference to DailyRitualsTable id if applicable
  DateTimeColumn get scheduledTime => dateTime()();
  DateTimeColumn get logTime => dateTime()();
  IntColumn get delayCount => integer().withDefault(const Constant(0))(); // Number of times rescheduled/snoozed
  TextColumn get procrastinationReason => text().nullable()(); // Anxiety, Fatigue, Distraction, etc.
  BoolColumn get wasCompletedEventually => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RitualLogEntity')
class RitualLogsTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get ritualId => text()(); // Reference to DailyRitualsTable id
  DateTimeColumn get completedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}


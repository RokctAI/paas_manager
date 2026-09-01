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


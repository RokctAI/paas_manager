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

import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/productivity_sdk.dart';

void main() {
  Map<String, dynamic> weekly() => <String, dynamic>{
    'id': 't1',
    'title': 'Water the plants',
    'isDone': true,
    'deadline': DateTime(2026, 10, 1, 9).toIso8601String(),
    'recurrence': 'Weekly',
    'reminder': true,
    'subtasks': <Map<String, dynamic>>[
      <String, dynamic>{'title': 'Front', 'isDone': true},
    ],
  };

  test('a tick spawns the next occurrence and records it', () {
    final Map<String, dynamic> task = weekly();
    final Map<String, dynamic>? next = TaskRecurrence.spawnNext(
      task,
      newId: 'n1',
      notifId: 7,
      now: DateTime(2026, 10, 1),
    );
    expect(next, isNotNull);
    expect(next!['id'], 'n1');
    expect(next['isDone'], isFalse);
    expect(next['deadline'], DateTime(2026, 10, 8, 9).toIso8601String());
    expect((next['subtasks'] as List).single['isDone'], isFalse);
    expect(task[TaskRecurrence.spawnedNextIdKey], 'n1');
  });

  test('ticking again after an untick spawns nothing more', () {
    final Map<String, dynamic> task = weekly();
    TaskRecurrence.spawnNext(task, newId: 'n1', notifId: 7);
    task['isDone'] = false; // untick
    task['isDone'] = true; // tick again
    expect(TaskRecurrence.spawnNext(task, newId: 'n2', notifId: 8), isNull);
    expect(task[TaskRecurrence.spawnedNextIdKey], 'n1');
  });

  test('no recurrence or no deadline means no next occurrence', () {
    expect(
      TaskRecurrence.spawnNext(
        weekly()..['recurrence'] = 'None',
        newId: 'x',
        notifId: 1,
      ),
      isNull,
    );
    expect(
      TaskRecurrence.spawnNext(
        weekly()..remove('deadline'),
        newId: 'x',
        notifId: 1,
      ),
      isNull,
    );
  });

  test('monthly keeps the day and time', () {
    final Map<String, dynamic>? next = TaskRecurrence.spawnNext(
      weekly()..['recurrence'] = 'Monthly',
      newId: 'm',
      notifId: 1,
    );
    expect(next!['deadline'], DateTime(2026, 11, 1, 9).toIso8601String());
  });
}

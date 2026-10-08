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

// The RO plant, SEEDED (maintenance_seed.dart): a seeded account starts
// with the plant described and its runs and replacements as real tasks,
// never depending on the "From template" chooser.

import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/src/common/application/run/maintenance_plant.dart';
import 'package:productivity_sdk/src/common/application/run/maintenance_seed.dart';
import 'package:productivity_sdk/src/common/application/run/maintenance_templates.dart';

final DateTime now = DateTime(2026, 9, 24, 8);

MaintenancePlantStore memoryStore(Map<String, Map<String, dynamic>?> box) =>
    MaintenancePlantStore(
      read: () => box['plant'],
      write: (v) async => box['plant'] = v,
    );

void main() {
  test('the finished setup run reads back as the seeded plant', () {
    final PlantRecord record = MaintenanceSeed.plant(now);
    final PlantRecord? back = MaintenanceSetup.recordFrom(
      MaintenanceSeed.finishedSetup(record, now),
    );
    expect(back, isNotNull);
    expect(
      back!.toMap()..remove('recordedAt'),
      record.toMap()..remove('recordedAt'),
    );
  });

  test('six live tasks with recurrence and due dates, plus done setup', () {
    final List<Map<String, dynamic>> tasks = MaintenanceSeed.tasks(
      MaintenanceSeed.plant(now),
      now: now,
    );
    Map<String, dynamic> of(MaintenanceTemplate t) =>
        tasks.firstWhere((m) => m['template'] == t.key);
    expect(tasks, hasLength(7));
    expect(of(MaintenanceTemplate.plantSetup)['isDone'], isTrue);
    expect(of(MaintenanceTemplate.softenerMaintenance)['recurrence'], 'Weekly');
    expect(of(MaintenanceTemplate.megaCharMaintenance)['recurrence'], 'Weekly');
    expect(
      of(MaintenanceTemplate.preFilterReplacement)['recurrence'],
      'Monthly',
    );
    expect(
      of(MaintenanceTemplate.softenerMaintenance)['subtasks'],
      hasLength(kSoftenerStages.length + 2),
    );
    expect(
      of(MaintenanceTemplate.roFilterReplacement)['deadline'],
      DateTime(
        2026,
        9,
        24,
      ).add(const Duration(days: kRoFilterDays)).toIso8601String(),
    );
    expect(
      of(MaintenanceTemplate.membraneReplacement)['deadline'],
      DateTime(
        2026,
        9,
        24,
      ).add(const Duration(days: kMembraneDays)).toIso8601String(),
    );
    for (final Map<String, dynamic> t in tasks) {
      expect(
        MaintenanceSeed.templateOfClientId('${t['clientId']}')?.key,
        t['template'],
      );
    }
  });

  test('the pH fix vessel is a manual cap run shaped like the megaChar', () {
    final List<Map<String, dynamic>> tasks = MaintenanceSeed.tasks(
      MaintenanceSeed.plant(now),
      now: now,
    );
    Map<String, dynamic> of(MaintenanceTemplate t) =>
        tasks.firstWhere((m) => m['template'] == t.key);
    final Map<String, dynamic> ph = of(MaintenanceTemplate.phFixMaintenance);
    final Map<String, dynamic> mc = of(MaintenanceTemplate.megaCharMaintenance);
    expect(ph['title'], 'Phfix vessel maintenance');
    expect(ph['id'], 'ro-seed-phfix_maintenance-demo');
    for (final String k in <String>[
      'recurrence',
      'stepsAreSequential',
      'reminder',
      'deadline',
      'priority',
    ]) {
      expect(ph[k], mc[k], reason: k);
    }
    expect(ph['subtasks'], mc['subtasks']);
    expect(
      MaintenanceSeed.templateOfClientId(ph['clientId'] as String),
      MaintenanceTemplate.phFixMaintenance,
    );
  });

  test('an owner seeded at version 1 gets only the pH fix run', () async {
    final Map<String, Map<String, dynamic>?> box = {};
    final PlantRecord plant = MaintenanceSeed.plant(now);
    await memoryStore(box).save(plant);
    // Version 1's tasks, minus one the owner deleted.
    List<Map<String, dynamic>> stored = [
      for (final t in MaintenanceSeed.tasks(plant, now: now))
        if (t['template'] != MaintenanceTemplate.phFixMaintenance.key &&
            t['template'] != MaintenanceTemplate.membraneReplacement.key)
          t,
    ];
    int version = 1;
    Future<bool> run() => MaintenanceSeed.seedDemo(
      load: () async => [for (final t in stored) Map.of(t)],
      save: (l) async => stored = l,
      store: memoryStore(box),
      seededVersion: () => version,
      markSeeded: () async => version = MaintenanceSeed.seedVersion,
      now: now,
    );
    expect(await run(), isTrue);
    expect(stored, hasLength(6));
    expect(
      stored.where(
        (t) => t['template'] == MaintenanceTemplate.phFixMaintenance.key,
      ),
      hasLength(1),
    );
    expect(
      stored.where(
        (t) => t['template'] == MaintenanceTemplate.membraneReplacement.key,
      ),
      isEmpty,
    );
    expect(await run(), isFalse);
  });

  test('no template is surfaced unless the backend offers it', () {
    expect(MaintenanceTemplates.surfaced, isEmpty);
    MaintenanceTemplates.backendKeys = <String>{'phfix_maintenance'};
    addTearDown(() => MaintenanceTemplates.backendKeys = const <String>{});
    expect(MaintenanceTemplates.surfaced, <MaintenanceTemplate>[
      MaintenanceTemplate.phFixMaintenance,
    ]);
  });

  test('demo seed writes once and is idempotent', () async {
    final Map<String, Map<String, dynamic>?> box = {};
    List<Map<String, dynamic>> stored = [];
    bool flag = false;
    Future<bool> run() => MaintenanceSeed.seedDemo(
      load: () async => [for (final t in stored) Map.of(t)],
      save: (l) async => stored = l,
      store: memoryStore(box),
      isSeeded: () => flag,
      markSeeded: () async => flag = true,
      now: now,
    );
    expect(await run(), isTrue);
    expect(stored, hasLength(7));
    expect(memoryStore(box).current(), isNotNull);
    expect(await run(), isFalse);
    flag = false; // even without the flag, ids are not duplicated
    await run();
    expect(stored, hasLength(7));
  });

  test('a pulled seeded task is made whole and the plant recorded', () async {
    final Map<String, Map<String, dynamic>?> box = {};
    final List<Map<String, dynamic>> todos = [
      {
        'id': 'x',
        'clientId': 'ro-seed-softener_maintenance-abc',
        'subtasks': [
          {'title': 'Initial Check', 'isDone': false},
        ],
      },
      {'id': 'y', 'clientId': 'plain'},
    ];
    final changed = await MaintenanceSeed.adoptPulled(
      todos,
      store: memoryStore(box),
      now: now,
    );
    expect(changed, hasLength(1));
    expect(todos.first['template'], 'softener_maintenance');
    expect(todos.first['subtasks'], hasLength(kSoftenerStages.length + 2));
    expect(memoryStore(box).current(), isNotNull);
    expect(
      await MaintenanceSeed.adoptPulled(todos, store: memoryStore(box)),
      isEmpty,
    );
  });

  group('account seed (email-gated)', () {
    late Map<String, Map<String, dynamic>?> box;
    late List<Map<String, dynamic>> stored;
    late Set<String> flags;
    setUp(() {
      box = {};
      stored = [];
      flags = {};
    });
    Future<bool> run(String? email, {String owner = 'USR-42'}) =>
        MaintenanceSeed.seedAccount(
          load: () async => [for (final t in stored) Map.of(t)],
          save: (l) async => stored = l,
          email: () => email,
          owner: () => owner,
          store: memoryStore(box),
          isSeeded: () => flags.contains(owner),
          markSeeded: () async => flags.add(owner),
          now: now,
        );

    test('other accounts get nothing', () async {
      expect(await run('someone@example.com'), isFalse);
      expect(await run(null), isFalse);
      expect(await run('sinyage@gmail.com', owner: ''), isFalse);
      expect(stored, isEmpty);
      expect(memoryStore(box).current(), isNull);
    });

    test('the plant owner is seeded once, with ids stable per owner', () async {
      expect(await run(' Sinyage@Gmail.com '), isTrue);
      expect(stored, hasLength(7));
      expect(memoryStore(box).current(), isNotNull);
      for (final t in stored) {
        expect('${t['id']}', startsWith(MaintenanceSeed.clientIdPrefix));
        expect('${t['id']}', endsWith('-usr_42'));
        expect(t['clientId'], t['id']);
        expect(
          MaintenanceSeed.templateOfClientId('${t['clientId']}')?.key,
          t['template'],
        );
      }
      final ids = [for (final t in stored) t['id']];
      expect(await run('sinyage@gmail.com'), isFalse);
      flags.clear(); // a fresh device of the same account: no duplicates
      expect(await run('sinyage@gmail.com'), isTrue);
      expect([for (final t in stored) t['id']], ids);
    });

    test('tasks pulled first are not duplicated and still adopt', () async {
      final seeded = MaintenanceSeed.tasks(
        MaintenanceSeed.plant(now),
        now: now,
        idSuffix: MaintenanceSeed.idSuffixFor('USR-42'),
      );
      stored = [
        for (final t in seeded)
          {'id': t['id'], 'clientId': t['clientId'], 'title': t['title']},
      ];
      await run('sinyage@gmail.com');
      expect(stored, hasLength(7));
      final changed = await MaintenanceSeed.adoptPulled(
        stored,
        store: memoryStore(box),
        now: now,
      );
      expect(changed, hasLength(7));
    });
  });
}

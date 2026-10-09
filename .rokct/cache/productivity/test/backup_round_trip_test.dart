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

// EXPORT, THEN IMPORT, AGAINST A REAL DATABASE — Ray: "only tasks seem to
// be able to export and notes doesnt", then "i think they also need imprt".
//
// The export writes ProductivityBackup.encode(list) to the share sheet; the
// import reads ProductivityBackup.decode(file) back through the
// repositories' own save paths. These drive both halves end to end with the
// real repositories on a real drift/SQLite store, and pin:
//
//   * a tasks backup and a notes backup each restore what they held;
//   * an item already held (same id) is SKIPPED, never overwritten - an old
//     backup cannot roll an edited item back;
//   * a restored note keeps the moment it last changed;
//   * a file that is not a backup is refused, not imported as nothing.

import 'dart:io';

import 'package:base_sdk/base_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/productivity_sdk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late AppDatabase database;
  late TodoRepositoryImpl tasks;
  late NoteRepositoryImpl notes;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('productivity_backup');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall call) async => tempDir.path,
        );
    database = AppDatabase();
    tasks = TodoRepositoryImpl(database);
    notes = NoteRepositoryImpl(database);
  });

  tearDownAll(() async {
    OwnerScope.instance.debugReset();
    await database.close();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  setUp(() async {
    OwnerScope.instance.debugReset(withResolver: () => null);
    await database.delete(database.tasksTable).go();
    await database.delete(database.notesTable).go();
    await database.delete(database.outboxTable).go();
  });

  Map<String, dynamic> task(String id, String title) => <String, dynamic>{
    'id': id,
    'title': title,
    'isDone': false,
    'priority': 'High',
    'category': 'Plant',
    'subtasks': <Map<String, dynamic>>[
      <String, dynamic>{'title': 'Step one', 'isDone': true},
    ],
  };

  group('tasks', () {
    test('export then import restores every task', () async {
      await tasks.saveTodos(<Map<String, dynamic>>[
        task('t1', 'Backwash softener'),
        task('t2', 'Order resin'),
      ]);
      final String backup = ProductivityBackup.encode(await tasks.loadTodos());

      for (final String id in <String>['t1', 't2']) {
        await tasks.deleteTodo(id);
      }
      expect(await tasks.loadTodos(), isEmpty);

      final int added = await tasks.importTodos(
        ProductivityBackup.decode(backup),
      );

      expect(added, 2);
      final List<Map<String, dynamic>> restored = await tasks.loadTodos();
      final Map<String, Map<String, dynamic>> byId =
          <String, Map<String, dynamic>>{
            for (final Map<String, dynamic> t in restored) '${t['id']}': t,
          };
      expect(byId.keys, unorderedEquals(<String>['t1', 't2']));
      expect(byId['t1']!['title'], 'Backwash softener');
      expect(byId['t1']!['priority'], 'High');
      expect(byId['t1']!['category'], 'Plant');
      expect((byId['t1']!['subtasks'] as List).single['title'], 'Step one');
    });

    test('a task already held is skipped, never rolled back', () async {
      await tasks.saveTodos(<Map<String, dynamic>>[task('t1', 'Old title')]);
      final String backup = ProductivityBackup.encode(await tasks.loadTodos());

      final Map<String, dynamic> edited = (await tasks.loadTodos()).single
        ..['title'] = 'Edited since';
      await tasks.saveTodos(<Map<String, dynamic>>[edited]);

      final int added = await tasks.importTodos(<Map<String, dynamic>>[
        ...ProductivityBackup.decode(backup),
        task('t9', 'Only in the file'),
      ]);

      expect(added, 1);
      final List<Map<String, dynamic>> now = await tasks.loadTodos();
      expect(now, hasLength(2));
      expect(now.firstWhere((t) => t['id'] == 't1')['title'], 'Edited since');
    });
  });

  test('a task with no id is given one', () async {
    final int added = await tasks.importTodos(<Map<String, dynamic>>[
      <String, dynamic>{'title': 'No id', 'isDone': false},
    ]);

    expect(added, 1);
    final Map<String, dynamic> stored = (await tasks.loadTodos()).single;
    expect('${stored['id']}', isNotEmpty);
    expect(stored['title'], 'No id');
  });

  group('notes', () {
    test('export then import restores every note, times kept', () async {
      await notes.saveNote(<String, dynamic>{
        'id': 'n1',
        'title': 'Resin',
        'body': 'Two weeks on the 25 L bag.',
      });
      await notes.saveNote(<String, dynamic>{
        'id': 'n2',
        'title': '',
        'body': 'Call the lab back',
      });
      final List<Map<String, dynamic>> before = await notes.loadNotes();
      final String backup = ProductivityBackup.encode(before);

      await notes.deleteNote('n1');
      await notes.deleteNote('n2');
      expect(await notes.loadNotes(), isEmpty);

      final int added = await notes.importNotes(
        ProductivityBackup.decode(backup),
      );

      expect(added, 2);
      // Same notes, same order, same timestamps: the restore is not a
      // fresh save.
      expect(await notes.loadNotes(), before);
    });

    test('a note already held is skipped, never rolled back', () async {
      await notes.saveNote(<String, dynamic>{'id': 'n1', 'title': 'Old'});
      final String backup = ProductivityBackup.encode(await notes.loadNotes());
      await notes.saveNote(<String, dynamic>{'id': 'n1', 'title': 'Newer'});

      final int added = await notes.importNotes(<Map<String, dynamic>>[
        ...ProductivityBackup.decode(backup),
        <String, dynamic>{'id': 'n2', 'title': 'From the file'},
      ]);

      expect(added, 1);
      final List<Map<String, dynamic>> now = await notes.loadNotes();
      expect(now, hasLength(2));
      expect(now.firstWhere((n) => n['id'] == 'n1')['title'], 'Newer');
    });

    test('a note with no id is given one', () async {
      final int added = await notes.importNotes(<Map<String, dynamic>>[
        <String, dynamic>{'title': 'No id', 'body': 'still a note'},
      ]);

      expect(added, 1);
      final Map<String, dynamic> stored = (await notes.loadNotes()).single;
      expect('${stored['id']}', isNotEmpty);
      expect(stored['title'], 'No id');
    });
  });

  group('the backup format', () {
    test('is a bare JSON array, as the tasks Backup always wrote', () {
      final String bytes = ProductivityBackup.encode(<Map<String, dynamic>>[
        <String, dynamic>{'id': 'a', 'title': 'A'},
      ]);
      expect(bytes, '[{"id":"a","title":"A"}]');
      expect(ProductivityBackup.tasksFileName, 'todos_backup.json');
      expect(ProductivityBackup.tasksShareText, 'My Todo Backup');
      expect(ProductivityBackup.notesFileName, 'notes_backup.json');
    });

    test('a file that is not an array is refused', () {
      expect(
        () => ProductivityBackup.decode('{"id":"a"}'),
        throwsA(isA<NotABackupException>()),
      );
      expect(
        () => ProductivityBackup.decode('not json'),
        throwsA(isA<NotABackupException>()),
      );
    });

    test('entries that are not objects are dropped, the rest kept', () {
      expect(
        ProductivityBackup.decode('[1, "x", {"id":"a"}]'),
        <Map<String, dynamic>>[
          <String, dynamic>{'id': 'a'},
        ],
      );
    });

    test('a duplicate id inside one file is taken once', () {
      final List<Map<String, dynamic>> fresh = ProductivityBackup.newOnly(
        const <Map<String, dynamic>>[],
        <Map<String, dynamic>>[
          <String, dynamic>{'id': 'a', 'title': 'first'},
          <String, dynamic>{'id': 'a', 'title': 'second'},
          <String, dynamic>{'title': 'no id'},
        ],
      );
      expect(fresh.map((m) => m['title']), <String>['first', 'no id']);
    });

    test('the import line says what was added and what was skipped', () {
      expect(
        ProductivityBackup.importSummary(added: 3, read: 3, noun: 'note'),
        'Imported 3 notes.',
      );
      expect(
        ProductivityBackup.importSummary(added: 1, read: 3, noun: 'task'),
        'Imported 1 task. 2 already here, skipped.',
      );
      expect(
        ProductivityBackup.importSummary(added: 0, read: 2, noun: 'task'),
        'Nothing new to import. 2 already here, skipped.',
      );
    });
  });
}

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

// THE LIST PLANE'S TOP LINE — Ray: "calendar and export should be n the top
// line where task and notes rectangle", and "only tasks seem to be able to
// export and notes doesnt".
//
// The bar is pumped here at a 360dp phone in both modes. The installed page
// cannot be compiled by this package (see template_page_theme_mode_test.dart
// for why), so what the page does with the bar is pinned on its SOURCE:
//   * calendar, export and import ride the segment's line, not the tasks
//     header's;
//   * calendar stays tasks-only (a note has no date to fall on);
//   * export and import act on the lit list, notes included.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/src/common/presentation/notes/notes_list_controls.dart';

Widget _action(String key) => IconButton(
  key: Key(key),
  onPressed: () {},
  iconSize: 20,
  icon: const Icon(Icons.circle),
);

Future<void> _pump(
  WidgetTester tester, {
  required double width,
  required Brightness brightness,
  required List<Widget> actions,
}) async {
  tester.view.physicalSize = Size(width, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 900),
      builder: (context, _) => MaterialApp(
        theme: ThemeData(brightness: brightness),
        home: Scaffold(
          body: Padding(
            // The page's own 16dp gutter.
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: WorkspaceListBar(
              segment: WorkspaceListSegment(
                active: WorkspaceList.tasks,
                counts: const <WorkspaceList, int>{
                  WorkspaceList.tasks: 128,
                  WorkspaceList.notes: 64,
                },
                onChanged: (_) {},
              ),
              actions: actions,
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  for (final Brightness brightness in Brightness.values) {
    testWidgets('segment, calendar, export and import share one line at 360dp '
        '(${brightness.name})', (tester) async {
      await _pump(
        tester,
        width: 360,
        brightness: brightness,
        actions: <Widget>[_action('cal'), _action('export'), _action('import')],
      );

      expect(tester.takeException(), isNull);
      final double segmentY = tester
          .getCenter(find.byType(WorkspaceListSegment))
          .dy;
      for (final String key in <String>['cal', 'export', 'import']) {
        expect(find.byKey(Key(key)), findsOneWidget);
        expect(tester.getCenter(find.byKey(Key(key))).dy, segmentY);
        // Inside the screen, right of the segment.
        expect(
          tester.getRect(find.byKey(Key(key))).right,
          lessThanOrEqualTo(360),
        );
        expect(
          tester.getRect(find.byKey(Key(key))).left,
          greaterThanOrEqualTo(
            tester.getRect(find.byType(WorkspaceListSegment)).right - 0.5,
          ),
        );
      }
      // Both list choices are still there and tappable.
      expect(
        find.byKey(const ValueKey<String>('workspace-list-tasks')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('workspace-list-notes')),
        findsOneWidget,
      );
    });
  }

  testWidgets('the notes line (no calendar) fits too', (tester) async {
    await _pump(
      tester,
      width: 360,
      brightness: Brightness.light,
      actions: <Widget>[_action('export'), _action('import')],
    );
    expect(tester.takeException(), isNull);
    expect(find.byKey(const Key('cal')), findsNothing);
    expect(find.byKey(const Key('export')), findsOneWidget);
  });

  testWidgets('a line narrower than a phone scales the segment, never '
      'overflows', (tester) async {
    await _pump(
      tester,
      width: 280,
      brightness: Brightness.dark,
      actions: <Widget>[_action('cal'), _action('export'), _action('import')],
    );
    expect(tester.takeException(), isNull);
    expect(
      tester.getRect(find.byKey(const Key('import'))).right,
      lessThanOrEqualTo(280),
    );
  });

  group('the installed page wires the line', () {
    late String page;

    setUpAll(() {
      page = File('templates/pages/tasks/tasks_page.dart')
          .readAsLinesSync()
          .where((String line) => !line.trimLeft().startsWith('//'))
          .join('\n');
    });

    test('the utilities ride the segment\'s line', () {
      final int bar = page.indexOf('WorkspaceListBar(');
      expect(bar, greaterThan(-1));
      final int end = page.indexOf('...notes ? _noteListRows()', bar);
      final String line = page.substring(bar, end);
      expect(line, contains('WorkspaceListSegment('));
      expect(line, contains("tooltip: 'Calendar mode'"));
      expect(line, contains('onTap: _exportData'));
      expect(line, contains('onTap: _importData'));
      // Calendar mode stays a tasks-only utility.
      expect(
        line,
        matches(
          RegExp(r'if \(!notes\)\s*_headerAction\(\s*icon: _showCalendar'),
        ),
      );
    });

    test('the tasks header no longer carries them', () {
      expect(
        page,
        contains(
          "TaskListHeader(title: 'Tasks', count: displayedTodos.length)",
        ),
      );
    });

    test('export and import act on the lit list', () {
      expect(page, contains('_noteRepository.exportNotes(_notes)'));
      expect(page, contains('_repository.exportTodos(_todos)'));
      expect(page, contains('_noteRepository.importNotes(items)'));
      expect(page, contains('_repository.importTodos(items)'));
    });
  });
}

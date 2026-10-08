// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.

import 'package:flutter_test/flutter_test.dart';
import 'package:productivity_sdk/src/common/application/run/recipe_seed.dart';

void main() {
  Future<List<Map<String, dynamic>>> run(String mail) async {
    List<Map<String, dynamic>> store = <Map<String, dynamic>>[];
    await RecipeSeed.seedAccount(
      load: () async => store,
      save: (v) async => store = v,
      email: () => mail,
      owner: () => 'u1',
      isSeeded: () => false,
      markSeeded: () async {},
    );
    return store;
  }

  test('seeds six recipe tasks for sinyage only', () async {
    final seeded = await run('Sinyage@gmail.com');
    expect(seeded, hasLength(6));
    expect(seeded.every((t) => (t['subtasks'] as List).length >= 3), isTrue);
    expect(await run('thandi.mokoena@outlook.com'), isEmpty);
    expect(await run(''), isEmpty);
  });

  test('atchar cups: weigh atchar, oil into cup, then transfer', () async {
    final all = await run('sinyage@gmail.com');
    Map pick(String key) =>
        all.firstWhere((t) => '${t['id']}'.startsWith('recipe-seed-$key-'));
    final batch = [
      for (final s in pick('mango_atchar')['subtasks'] as List)
        '${(s as Map)['title']}',
    ];
    expect(batch.last, 'Vegetable oil 1840 g');
    final cups = pick('mango_atchar_cups');
    expect(cups['title'], 'Mango atchar: fill 90 g cups');
    final steps = [for (final s in cups['subtasks'] as List) s as Map];
    final titles = [for (final s in steps) '${s['title']}'];
    final weigh = titles.indexOf('Cup: weigh atchar 81-85 g');
    final oil = titles.indexOf('Cup: seal oil 4.6-9.2 g into the cup');
    final move = titles.indexOf('Cup: transfer atchar into the cup');
    expect(weigh, greaterThanOrEqualTo(0));
    expect(oil, greaterThan(weigh));
    expect(move, greaterThan(oil));
    expect(steps.any((s) => s['optional'] == true), isFalse);
  });
}

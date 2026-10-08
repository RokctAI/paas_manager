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

// R&D RECIPE TEST BATCHES, SEEDED FOR ONE ACCOUNT. Ray, 2026-10-05: one
// multi-step task per recipe in RokctAI/occultation RnD/, for
// sinyage@gmail.com ONLY (no demo, no other account). He WEIGHS every
// ingredient on a precision scale and never measures by volume, so each
// step gives grams for a 10 L test batch in a 10 L bucket (scale-up comes
// later). Atchar cups: atchar weighed in a small container, seal oil
// weighed into the empty 90 g cup, then the atchar moved into the cup. Liquids given in ml/L in the recipe are converted by density,
// and the step states the density used. Quantities the recipe does not
// give are written as "quantity missing in recipe", never invented.
//
// Seeded through the ordinary tasks save exactly like MaintenanceSeed's
// account path: stable ids per owner, written once (a deleted task stays
// deleted), pushed to the server by the SyncEngine. The ids do not carry
// MaintenanceSeed.clientIdPrefix, so adoptPulled leaves them alone.

import 'package:base_sdk/base_sdk.dart';

import 'task_run.dart';

/// One R&D recipe, as a run of weighed steps.
class RecipeSeedTask {
  const RecipeSeedTask(this.key, this.title, this.source, this.steps);

  final String key;
  final String title;

  /// The recipe file in RokctAI/occultation.
  final String source;
  final List<TaskRunStep> steps;
}

TaskRunStep _w(String title, String instruction, [int minutes = 0]) =>
    TaskRunStep(
      title: title,
      instruction: instruction,
      durationSeconds: minutes * 60,
    );

const String _water = 'Water at 1 g/ml.';
const String _flav =
    'Density assumed 1.0 g/ml (check the supplier sheet; most flavourings '
    'are 1.0-1.05).';
const String _ph =
    'Calcite (pH 8) process water buffers: treat the acid grams as a '
    'starting point and add acid until the meter confirms target pH.';

class RecipeSeed {
  RecipeSeed._();

  /// The ONLY account seeded. Matched case-insensitively.
  static const Set<String> ownerEmails = <String>{'sinyage@gmail.com'};

  static const String clientIdPrefix = 'recipe-seed-';
  static const String seededKeyPrefix = 'productivity.recipes.seeded.';

  static final List<RecipeSeedTask> recipes = <RecipeSeedTask>[
    RecipeSeedTask(
      'orange_freezit',
      'Test batch 10 L: JuvoPops Orange',
      'RnD/sachet/freezit-branded/orange/orange_freezit.md',
      <TaskRunStep>[
        _w(
          'Purified water 9000 g',
          'Weigh 9000 g purified water into the 10 L bucket (~90% of batch). $_water',
        ),
        _w('Sodium benzoate 1 g', 'Weigh 1 g.'),
        _w('Potassium sorbate 1 g', 'Weigh 1 g.'),
        _w(
          'Dissolve preservatives',
          'Dissolve both in warm water (quantity missing in recipe), stir into the bucket 2 min.',
          2,
        ),
        _w(
          'White sugar 950 g',
          'Weigh 950 g; add slowly while stirring, 10 min until dissolved.',
          10,
        ),
        _w('Citric acid anhydrous 18 g', 'Weigh 18 g. $_ph'),
        _w('Malic acid 4 g', 'Weigh 4 g.'),
        _w(
          'Dissolve and add acids',
          'Dissolve both acids in water (quantity missing in recipe), pour in, stir 5 min.',
          5,
        ),
        _w('Orange flavouring 10 g', 'Recipe gives 10 ml. $_flav'),
        _w(
          'Sunset Yellow colouring 0.5-1.0 g',
          'Weigh 0.5-1.0 g (recipe range). Mix flavour and colour 10 min until uniform.',
          10,
        ),
        _w(
          'Top up to 10 L by weight',
          'Add purified water until the net batch weighs ~10 375 g (10 L at ~1.0375 g/ml for 9.5 Brix). Blend 2 min.',
          2,
        ),
        _w(
          'QC: Brix and pH',
          'Brix target 9.5% (9.0-10.0). pH target 3.6 (3.5-3.7) on a calibrated meter.',
        ),
        _w(
          'Filter',
          'Pump through a 5-micron inline bag filter into the SJ-1000 hopper.',
        ),
      ],
    ),
    RecipeSeedTask(
      'strawberry_freezit',
      'Test batch 10 L: JuvoPops Strawberry',
      'RnD/sachet/freezit-branded/strawberry/strawberry_freezit.md',
      <TaskRunStep>[
        _w(
          'Purified water 9000 g',
          'Weigh 9000 g purified water into the 10 L bucket (~90% of batch). $_water',
        ),
        _w('Sodium benzoate 1 g', 'Weigh 1 g.'),
        _w('Potassium sorbate 1 g', 'Weigh 1 g.'),
        _w(
          'Dissolve preservatives',
          'Dissolve both in warm water (quantity missing in recipe), stir into the bucket 2 min.',
          2,
        ),
        _w(
          'White sugar 950 g',
          'Weigh 950 g; stir 10 min until dissolved.',
          10,
        ),
        _w('Citric acid anhydrous 17 g', 'Weigh 17 g. $_ph'),
        _w('Malic acid 5 g', 'Weigh 5 g.'),
        _w(
          'Dissolve and add acids',
          'Dissolve both acids in water (quantity missing in recipe), add, mix 5 min.',
          5,
        ),
        _w('Strawberry flavouring 10 g', 'Recipe gives 10 ml. $_flav'),
        _w(
          'Red colouring 0.3-0.5 g',
          'Allura Red/Carmoisine, 0.3-0.5 g (recipe range). Stir flavour and colour 10 min until uniform.',
          10,
        ),
        _w(
          'Top up to 10 L by weight',
          'Add purified water until the net batch weighs ~10 375 g (10 L at ~1.0375 g/ml for 9.5 Brix). Blend 2 min.',
          2,
        ),
        _w(
          'QC: Brix and pH',
          'Brix target 9.5% (9.0-10.0). pH target 3.6 (3.5-3.7).',
        ),
        _w(
          'Filter',
          'Pass through a 5-micron inline bag filter into the SJ-1000.',
        ),
      ],
    ),
    RecipeSeedTask(
      'rooibos_icetea',
      'Test batch 10 L: Rooibos Iced Tea',
      'RnD/sachet/ice_tea/rooibos/rooibos_icetea.md',
      <TaskRunStep>[
        _w(
          'Purified water 9000 g',
          'Weigh 9000 g purified water (~90% of batch; the ingredient table gives ~9.2 L = 9200 g total). $_water',
        ),
        _w('Sodium benzoate 1 g', 'Weigh 1 g.'),
        _w('Potassium sorbate 1 g', 'Weigh 1 g.'),
        _w(
          'Dissolve preservatives',
          'Pre-dissolve both in warm water (quantity missing in recipe), stir in 2 min.',
          2,
        ),
        _w('Sugar 850 g', 'Weigh 850 g.'),
        _w(
          'Rooibos extract powder 25 g',
          'Weigh 25 g. Mix dry with the sugar, add slowly while stirring, 10 min until dissolved.',
          10,
        ),
        _w(
          'Citric acid anhydrous 14 g',
          'Weigh 14 g; dissolve in water (quantity missing in recipe) and pour in. $_ph',
        ),
        _w(
          'Lemon or peach flavouring 8 g',
          'Recipe gives 8 ml. $_flav Stir 10-15 min until uniform.',
          15,
        ),
        _w(
          'Water to 9200 g total',
          'Recipe gives ~9.2 L water in all: add purified water until 9200 g has gone in (net batch ~10 140 g). Recipe has no separate top-up step.',
        ),
        _w('QC: Brix and pH', 'Brix target 8.0-9.0%. pH target 3.7-3.9.'),
        _w(
          'Filter',
          'Pump through a 5-micron inline bag filter to the SJ-1000.',
        ),
      ],
    ),
    RecipeSeedTask(
      'flavored_water',
      'Test batch 10 L: South River Flavoured Water',
      'RnD/sachet/water-branded/flavored_clear/flavored_water.md',
      <TaskRunStep>[
        _w(
          'Purified water 9500 g',
          'Weigh 9500 g purified water (~95% of batch). $_water',
        ),
        _w('Sodium benzoate 0.8 g', 'Weigh 0.8 g.'),
        _w('Potassium sorbate 0.8 g', 'Weigh 0.8 g.'),
        _w(
          'Dissolve preservatives',
          'Pre-dissolve both in warm water (quantity missing in recipe), add, mix 2 min.',
          2,
        ),
        _w('Sucralose 0.8-1.0 g', 'Weigh 0.8-1.0 g (recipe range).'),
        _w(
          'Citric acid anhydrous 4 g',
          'Weigh 4 g. Stir with the sucralose 5 min until clear. $_ph',
          5,
        ),
        _w(
          'Clear fruit essence 4-6 g',
          'Recipe gives 4-6 ml. $_flav Stir 10 min.',
          10,
        ),
        _w(
          'Top up to 10 L by weight',
          'Add purified water until the net batch weighs 10 000 g (sugar-free, ~1.0 g/ml). Stir 2 min.',
          2,
        ),
        _w('QC: clarity and pH', 'Liquid must be 100% clear. pH 4.2-4.5.'),
        _w(
          'UV and pack',
          'Route through the inline UV sterilizer into the packaging machine.',
        ),
      ],
    ),
    RecipeSeedTask(
      'mango_atchar',
      'Test batch 10 L: South River Mango Atchar',
      'RnD/container/atchar-branded/mango/mango_atchar.md',
      <TaskRunStep>[
        TaskRunStep(
          title: 'Drain cured mango',
          instruction:
              'Scoop cured mango from the 50 kg bulk container into a strainer; drain off all brine and old spices.',
        ),
        TaskRunStep(
          title: 'Drained cured mango 8000 g',
          instruction:
              'Place the 10 L bucket on the scale, zero it, weigh in 8000 g drained mango.',
        ),
        TaskRunStep(title: 'Sodium benzoate 10 g', instruction: 'Weigh 10 g.'),
        TaskRunStep(
          title: 'Potassium sorbate 10 g',
          instruction: 'Weigh 10 g.',
        ),
        TaskRunStep(
          title: 'Warm water 50 g',
          instruction:
              'Weigh 50 g warm water (1 g/ml), dissolve both preservatives in it, pour over the mango and stir.',
        ),
        TaskRunStep(
          title: 'Paprika powder 100 g',
          instruction: 'Weigh 100 g into the bucket.',
        ),
        TaskRunStep(
          title: 'Atchar masala blend 800 g',
          instruction: 'Weigh 800 g into the bucket.',
        ),
        TaskRunStep(
          title: 'Garlic 200 g (Garlic / Mix only)',
          instruction: 'Crushed/minced garlic, 200 g. Skip for Hot.',
        ),
        TaskRunStep(
          title: 'Chili flakes 150 g (Hot / Mix only)',
          instruction: 'Crushed dried chili flakes, 150 g. Skip for Garlic.',
        ),
        TaskRunStep(
          title: 'Vegetable oil 1840 g',
          instruction:
              'Zero the scale with the bucket on it and pour vegetable oil to 1840 g (recipe 2.0 L x 0.92 g/ml sunflower/canola). Stir with a clean paddle until every piece is coated and submerged.',
        ),
      ],
    ),
    RecipeSeedTask(
      'mango_atchar_cups',
      'Mango atchar: fill 90 g cups',
      'RnD/container/atchar-branded/mango/mango_atchar.md',
      <TaskRunStep>[
        TaskRunStep(
          title: 'Cup: weigh atchar 81-85 g',
          instruction:
              'Per 90 g cup: zero a small weighing container on the scale and weigh 81-85 g atchar into it (90 g cup minus the seal oil).',
        ),
        TaskRunStep(
          title: 'Cup: seal oil 4.6-9.2 g into the cup',
          instruction:
              'Zero the empty 90 g cup on the scale and pour 4.6-9.2 g fresh vegetable oil into it (recipe 5-10 ml x 0.92 g/ml).',
        ),
        TaskRunStep(
          title: 'Cup: transfer atchar into the cup',
          instruction:
              'Move the weighed atchar from the small container into the oiled cup so the oil submerges it. Snap the lid on. Repeat per cup.',
        ),
      ],
    ),
  ];

  static String idSuffixFor(String owner) =>
      owner.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');

  /// The task maps, with ids stable per [idSuffix].
  static List<Map<String, dynamic>> tasks({
    required DateTime now,
    required String idSuffix,
  }) => <Map<String, dynamic>>[
    for (final RecipeSeedTask r in recipes)
      () {
        final String id = '$clientIdPrefix${r.key}-$idSuffix';
        return <String, dynamic>{
          'id': id,
          'clientId': id,
          'notifId': id.hashCode & 0x7fffffff,
          'createdAt': now.toIso8601String(),
          'title': r.title,
          'description': 'Source: occultation ${r.source}. Weigh everything.',
          'isDone': false,
          'priority': 'Medium',
          'stepsAreSequential': true,
          'recurrence': 'None',
          'reminder': false,
          'deadline': null,
          'subtasks': <Map<String, dynamic>>[
            for (final TaskRunStep s in r.steps) s.toMap(),
          ],
        };
      }(),
  ];

  /// Seed the recipe tasks once per owner when the signed-in email is in
  /// [ownerEmails]. Returns whether anything was attempted.
  static Future<bool> seedAccount({
    required Future<List<Map<String, dynamic>>> Function() load,
    required Future<void> Function(List<Map<String, dynamic>>) save,
    String? Function()? email,
    String Function()? owner,
    bool Function()? isSeeded,
    Future<void> Function()? markSeeded,
    DateTime? now,
  }) async {
    final String mail = ((email ?? () => LocalStorage.getUser()?.email)() ?? '')
        .trim()
        .toLowerCase();
    if (!ownerEmails.contains(mail)) return false;
    final String who = (owner ?? () => OwnerScope.instance.current)();
    if (who.isEmpty || who == kUnownedOwner) return false;
    final String suffix = idSuffixFor(who);
    final String flag = '$seededKeyPrefix$suffix';
    final bool done = isSeeded != null
        ? isSeeded()
        : LocalStorage.getJson(flag) != null;
    if (done) return false;
    final DateTime at = now ?? DateTime.now();
    final List<Map<String, dynamic>> todos = await load();
    final Set<String> have = <String>{
      for (final Map<String, dynamic> t in todos) ...<String>{
        '${t['id'] ?? ''}',
        '${t['clientId'] ?? ''}',
      },
    };
    final List<Map<String, dynamic>> fresh = <Map<String, dynamic>>[
      for (final Map<String, dynamic> t in tasks(now: at, idSuffix: suffix))
        if (!have.contains(t['id'])) t,
    ];
    if (fresh.isNotEmpty) {
      await save(<Map<String, dynamic>>[...todos, ...fresh]);
    }
    await (markSeeded ??
        () => LocalStorage.setJson(flag, <String, dynamic>{
          'at': at.toIso8601String(),
        }))();
    return true;
  }
}

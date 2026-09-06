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

import 'package:productivity_sdk/src/common/models/data/objective_data.dart';

/// The plan objects design strip section 41 (the M2 vision cluster) reads.
///
/// Shaped against the productivity module's own read endpoints, which are
/// the ONLY source of these rows and return exactly these fields:
///
///     get_plan_on_a_page          -> {vision}                 (the single doc)
///     get_visions                 -> [{name, title, description}]
///     get_pillars                 -> [{name, title, description, vision}]
///     get_strategic_objectives    -> [{name, title, description, pillar}]
///     get_kpis                    -> [{name, title, description, strategic_objective}]
///     get_personal_mastery_goals  -> [{name, title, description}]
///
/// Title, description and the parent link are the ONLY fields that exist
/// (flag (b) of the section: the doctypes are skeletal — no KPI
/// metric/target/current/unit, no objective status or dates, no vision
/// dates). Nothing here is invented beyond them. [Pillar] and
/// [StrategicObjective] are the frame-44c models, reused as they are so
/// the two screens agree on what a pillar and an objective hold.
///
/// Descriptions are Text Editor fields on the doctypes, so they arrive as
/// HTML; [planText] flattens them to the one line the cards draw.

/// The Vision doctype: `title` + `description`, nothing else exists.
class Vision {
  const Vision({required this.name, required this.title, this.description});

  /// The doctype `name` — what a pillar's `vision` link and the single
  /// Plan On A Page doc's `vision` link hold.
  final String name;
  final String title;
  final String? description;

  factory Vision.fromMap(Map<String, dynamic> map) => Vision(
    name: (map['name'] ?? '').toString(),
    title: (map['title'] ?? map['name'] ?? '').toString(),
    description: planText(map['description']),
  );
}

/// The KPI doctype: `title` + `description` + the objective link. There is
/// no metric, target, current value or unit — a target lives only as free
/// text inside the description, which is why chip 791 draws no gauge.
class Kpi {
  const Kpi({
    required this.name,
    required this.title,
    this.description,
    this.strategicObjective,
  });

  final String name;
  final String title;
  final String? description;

  /// The `StrategicObjective.name` this KPI measures, or null when unset.
  final String? strategicObjective;

  factory Kpi.fromMap(Map<String, dynamic> map) => Kpi(
    name: (map['name'] ?? '').toString(),
    title: (map['title'] ?? map['name'] ?? '').toString(),
    description: planText(map['description']),
    strategicObjective: planText(map['strategic_objective']),
  );
}

/// Everything the plan board (frames 41a / 41b / 41d) draws, read in one
/// go: the Plan On A Page doc's linked vision as the masthead (785), its
/// pillars as columns (786), their objectives as cards (787) and the KPIs
/// the drill (789 / 791) lists under a tapped objective.
class PlanBoard {
  const PlanBoard({
    this.vision,
    this.pillars = const <Pillar>[],
    this.objectives = const <StrategicObjective>[],
    this.kpis = const <Kpi>[],
    this.kpisRead = true,
  });

  static const PlanBoard empty = PlanBoard();

  /// The masthead's vision: the single Plan On A Page doc's link, or
  /// null when the plan has none (the board then has no masthead).
  final Vision? vision;

  /// The pillars under [vision], in the order the endpoint returned
  /// them — that order IS the accent order (a pillar has no colour or
  /// display_order column; the accent is positional, flag (b)).
  final List<Pillar> pillars;
  final List<StrategicObjective> objectives;
  final List<Kpi> kpis;

  /// False when `get_kpis` failed: the objective cards then draw NO KPI
  /// pill rather than "0 KPIs", because an unreadable count is not zero.
  final bool kpisRead;

  bool get isEmpty => vision == null && pillars.isEmpty && objectives.isEmpty;

  Pillar? pillarNamed(String? name) {
    if (name == null || name.isEmpty) return null;
    for (final Pillar pillar in pillars) {
      if (pillar.name == name) return pillar;
    }
    return null;
  }

  StrategicObjective? objectiveNamed(String? name) {
    if (name == null || name.isEmpty) return null;
    for (final StrategicObjective objective in objectives) {
      if (objective.name == name) return objective;
    }
    return null;
  }

  /// The objectives under a pillar, in endpoint order.
  List<StrategicObjective> objectivesIn(String pillarName) =>
      objectives.where((o) => o.pillar == pillarName).toList();

  /// The KPIs under an objective, in endpoint order.
  List<Kpi> kpisOf(String objectiveName) =>
      kpis.where((k) => k.strategicObjective == objectiveName).toList();

  /// How many KPIs link to an objective — DERIVED by counting, there is
  /// no count field. Null when the KPIs were not readable.
  int? kpiCountFor(String objectiveName) =>
      kpisRead ? kpisOf(objectiveName).length : null;

  /// The accent index of a pillar: its position in [pillars], the same
  /// derivation frame 44c's picker uses, so the two screens agree on a
  /// pillar's colour.
  int accentIndexOf(String? pillarName) {
    final int index = pillars.indexWhere((p) => p.name == pillarName);
    return index < 0 ? 0 : index;
  }

  /// The words in the count pill (canonical 700): "3 pillars · 6
  /// objectives" on the board, "3 pillars" on the phone fold (41d).
  String countLabel({bool withObjectives = true}) {
    final String p = pillars.length == 1
        ? '1 pillar'
        : '${pillars.length} pillars';
    if (!withObjectives) return p;
    final String o = objectives.length == 1
        ? '1 objective'
        : '${objectives.length} objectives';
    return '$p · $o';
  }
}

/// One row of a Personal Mastery Goal's `todos` table — a frappe `ToDo`:
/// `status` (Open / Closed / Cancelled), `description` and `date` are the
/// fields chip 793 draws, and the only ones it reads.
class MasteryTodo {
  const MasteryTodo({
    this.name,
    required this.description,
    this.status = 'Open',
    this.date,
  });

  final String? name;
  final String description;

  /// `ToDo.status` as the server spells it.
  final String status;

  /// `ToDo.date`, when set.
  final DateTime? date;

  bool get isClosed => status.toLowerCase() == 'closed';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  factory MasteryTodo.fromMap(Map<String, dynamic> map) => MasteryTodo(
    name: planText(map['name']),
    description: planText(map['description']) ?? '',
    status: (map['status'] ?? 'Open').toString(),
    date: _date(map['date']),
  );

  static DateTime? _date(Object? value) {
    final String text = (value ?? '').toString().trim();
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}

/// The Personal Mastery Goal doctype: `title`, `description` and the
/// `todos` child table. THE GOAL HAS NO STATUS FIELD — progress is DERIVED
/// from the child table (chip 792), and that derivation is the only
/// measure the card shows.
class MasteryGoal {
  const MasteryGoal({
    required this.name,
    required this.title,
    this.description,
    this.todos,
  });

  final String name;
  final String title;
  final String? description;

  /// The child rows, or NULL when the read did not carry them.
  /// `get_personal_mastery_goals` is a `frappe.get_all`, which returns
  /// the parent's own columns only; a goal whose rows were not sent draws
  /// no progress at all — not "0 of 0", which would claim a count.
  final List<MasteryTodo>? todos;

  bool get hasTodos => todos != null && todos!.isNotEmpty;

  int get todosDone => todos?.where((t) => t.isClosed).length ?? 0;

  int get todosTotal => todos?.length ?? 0;

  /// DERIVED: closed rows over all rows; null with no rows to count.
  double? get progress => hasTodos ? todosDone / todosTotal : null;

  bool get isComplete => hasTodos && todosDone == todosTotal;

  factory MasteryGoal.fromMap(Map<String, dynamic> map) {
    final Object? rows = map['todos'];
    return MasteryGoal(
      name: (map['name'] ?? '').toString(),
      title: (map['title'] ?? map['name'] ?? '').toString(),
      description: planText(map['description']),
      todos: rows is List
          ? <MasteryTodo>[
              for (final Object? row in rows)
                if (row is Map)
                  MasteryTodo.fromMap(row.cast<String, dynamic>()),
            ]
          : null,
    );
  }
}

/// A Text Editor field as one line: tags stripped, the common entities
/// decoded, whitespace collapsed. Null for nothing worth drawing.
String? planText(Object? value) {
  if (value == null) return null;
  String text = value.toString();
  text = text
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), ' ')
      .replaceAll(RegExp(r'</(p|div|li|h[1-6])>', caseSensitive: false), ' ')
      .replaceAll(RegExp(r'<[^>]+>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  return text.isEmpty ? null : text;
}

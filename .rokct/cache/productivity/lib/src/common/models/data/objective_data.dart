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

/// The plan objects the M2 bridge (design strip frame 44c) reads.
///
/// Shaped against the productivity module's own read endpoints, which are
/// the ONLY source of these rows and return exactly these fields:
///
///     get_pillars              -> [{name, title, description, vision}]
///     get_strategic_objectives -> [{name, title, description, pillar}]
///     get_kpis                 -> [{name, title, description, strategic_objective}]
///
/// Title, description and the parent link are the only fields that exist;
/// nothing here is invented beyond them. A pillar has no colour column, so
/// its accent is DERIVED from its position in the pillar list (see
/// `pillarAccent`), and an objective's KPI count is DERIVED by counting
/// the KPIs that link to it — there is no count field to read, the same
/// honesty rule section 41 applied to mastery goals.
class Pillar {
  const Pillar({required this.name, required this.title, this.description, this.vision});

  /// The doctype `name` — what an objective's `pillar` link holds.
  final String name;
  final String title;
  final String? description;
  final String? vision;

  factory Pillar.fromMap(Map<String, dynamic> map) => Pillar(
    name: (map['name'] ?? '').toString(),
    title: (map['title'] ?? map['name'] ?? '').toString(),
    description: _text(map['description']),
    vision: _text(map['vision']),
  );
}

class StrategicObjective {
  const StrategicObjective({
    required this.name,
    required this.title,
    this.description,
    this.pillar,
  });

  /// The doctype `name` — what a task's `strategic_objective` link holds.
  final String name;
  final String title;
  final String? description;

  /// The `Pillar.name` this objective belongs to, or null when unset.
  final String? pillar;

  factory StrategicObjective.fromMap(Map<String, dynamic> map) =>
      StrategicObjective(
        name: (map['name'] ?? '').toString(),
        title: (map['title'] ?? map['name'] ?? '').toString(),
        description: _text(map['description']),
        pillar: _text(map['pillar']),
      );
}

/// Everything the objective picker (chip 834) draws, read in one go.
class ObjectiveCatalog {
  const ObjectiveCatalog({
    required this.objectives,
    required this.pillars,
    this.kpiCountByObjective = const <String, int>{},
  });

  static const ObjectiveCatalog empty = ObjectiveCatalog(
    objectives: <StrategicObjective>[],
    pillars: <Pillar>[],
  );

  final List<StrategicObjective> objectives;
  final List<Pillar> pillars;

  /// `StrategicObjective.name` -> how many KPIs link to it. Derived by
  /// counting `get_kpis`; an objective absent here has none known.
  final Map<String, int> kpiCountByObjective;

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

  int kpiCountFor(StrategicObjective objective) =>
      kpiCountByObjective[objective.name] ?? 0;

  /// Objectives under [pillarName], or all of them for null.
  List<StrategicObjective> objectivesIn(String? pillarName) => pillarName == null
      ? objectives
      : objectives.where((o) => o.pillar == pillarName).toList();

  /// The accent index of a pillar: its position in [pillars], so two
  /// screens drawing the same pillar agree on its colour.
  int accentIndexOf(String? pillarName) {
    final int index = pillars.indexWhere((p) => p.name == pillarName);
    return index < 0 ? 0 : index;
  }
}

String? _text(Object? value) {
  final String text = (value ?? '').toString().trim();
  return text.isEmpty ? null : text;
}

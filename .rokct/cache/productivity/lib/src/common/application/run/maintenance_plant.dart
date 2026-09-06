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

// Design strip frame 47d — the plant, described. "The plant has to be
// described before it can be serviced": until a record exists, the only
// maintenance template on offer is the setup run, and the setup run is
// an ordinary guided run (section 46's runner, 47d's double-duty
// argument) whose three required steps — vessels, filters, membranes —
// each carry the numbers and dates the old app's one long setup form
// collected, and whose optional fourth step is the water spec the
// readings step (47h) judges values against.
//
// The record lives on the device, in base_sdk's LocalStorage host-record
// store (`setJson` / `getJson`, the same store first-run setup progress
// uses), under [MaintenancePlantStore.key]. It is per install and it
// syncs nowhere: nothing on the server carries a plant yet, and the
// 2026-08-30 scope note keeps the water dashboard and its records out of
// this section. The maintenance templates read it to compute due dates.

import 'package:base_sdk/base_sdk.dart';

import 'task_run.dart';

/// The thresholds a readings step judges against (47h): the frame's
/// figures unless the plant's optional water-spec step said otherwise.
class WaterSpec {
  const WaterSpec({
    this.feedTdsMax = 400,
    this.permeateTdsMax = 50,
    this.feedPressureMin = 6.0,
    this.feedPressureMax = 10.0,
    this.permeatePressureMin = 1.0,
  });

  final num feedTdsMax;
  final num permeateTdsMax;
  final num feedPressureMin;
  final num feedPressureMax;
  final num permeatePressureMin;

  static const WaterSpec defaults = WaterSpec();

  factory WaterSpec.fromMap(Map<String, dynamic> map) => WaterSpec(
    feedTdsMax: _num(map['feedTdsMax']) ?? defaults.feedTdsMax,
    permeateTdsMax: _num(map['permeateTdsMax']) ?? defaults.permeateTdsMax,
    feedPressureMin: _num(map['feedPressureMin']) ?? defaults.feedPressureMin,
    feedPressureMax: _num(map['feedPressureMax']) ?? defaults.feedPressureMax,
    permeatePressureMin:
        _num(map['permeatePressureMin']) ?? defaults.permeatePressureMin,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'feedTdsMax': feedTdsMax,
    'permeateTdsMax': permeateTdsMax,
    'feedPressureMin': feedPressureMin,
    'feedPressureMax': feedPressureMax,
    'permeatePressureMin': permeatePressureMin,
  };

  static num? _num(Object? value) {
    if (value is num) return value;
    return num.tryParse('${value ?? ''}');
  }
}

/// The plant as the setup run described it. Counts and install dates —
/// the facts the old app's gate demanded (both vessel types, all three
/// filter locations, at least one membrane) — plus the water spec.
class PlantRecord {
  const PlantRecord({
    required this.megaCharVessels,
    required this.softenerVessels,
    this.vesselsInstalledOn,
    this.preFilterInstalledOn,
    this.roFilterInstalledOn,
    this.postFilterInstalledOn,
    required this.membranes,
    this.membranesInstalledOn,
    this.spec = WaterSpec.defaults,
    this.recordedAt,
  });

  static const int version = 1;

  final int megaCharVessels;
  final int softenerVessels;
  final DateTime? vesselsInstalledOn;
  final DateTime? preFilterInstalledOn;
  final DateTime? roFilterInstalledOn;
  final DateTime? postFilterInstalledOn;
  final int membranes;
  final DateTime? membranesInstalledOn;
  final WaterSpec spec;
  final DateTime? recordedAt;

  /// The old gate's own test: a megaChar AND a softener, and a membrane.
  bool get isComplete =>
      megaCharVessels > 0 && softenerVessels > 0 && membranes > 0;

  factory PlantRecord.fromMap(Map<String, dynamic> map) => PlantRecord(
    megaCharVessels: _int(map['megaCharVessels']),
    softenerVessels: _int(map['softenerVessels']),
    vesselsInstalledOn: _date(map['vesselsInstalledOn']),
    preFilterInstalledOn: _date(map['preFilterInstalledOn']),
    roFilterInstalledOn: _date(map['roFilterInstalledOn']),
    postFilterInstalledOn: _date(map['postFilterInstalledOn']),
    membranes: _int(map['membranes']),
    membranesInstalledOn: _date(map['membranesInstalledOn']),
    spec: map['spec'] is Map
        ? WaterSpec.fromMap((map['spec'] as Map).cast<String, dynamic>())
        : WaterSpec.defaults,
    recordedAt: _date(map['recordedAt']),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'version': version,
    'megaCharVessels': megaCharVessels,
    'softenerVessels': softenerVessels,
    if (vesselsInstalledOn != null)
      'vesselsInstalledOn': _day(vesselsInstalledOn!),
    if (preFilterInstalledOn != null)
      'preFilterInstalledOn': _day(preFilterInstalledOn!),
    if (roFilterInstalledOn != null)
      'roFilterInstalledOn': _day(roFilterInstalledOn!),
    if (postFilterInstalledOn != null)
      'postFilterInstalledOn': _day(postFilterInstalledOn!),
    'membranes': membranes,
    if (membranesInstalledOn != null)
      'membranesInstalledOn': _day(membranesInstalledOn!),
    'spec': spec.toMap(),
    if (recordedAt != null) 'recordedAt': recordedAt!.toIso8601String(),
  };

  /// A calendar day as `yyyy-MM-dd` — the form a date reading holds.
  static String _day(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  static int _int(Object? value) {
    if (value is num) return value < 0 ? 0 : value.toInt();
    final double? parsed = double.tryParse('${value ?? ''}');
    return parsed == null || parsed < 0 ? 0 : parsed.toInt();
  }

  static DateTime? _date(Object? value) {
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
    return null;
  }
}

/// The plant record's home on the device. Reads and writes are handed in
/// so the derivation is testable without a preferences store; production
/// uses [local], which is base_sdk's LocalStorage.
class MaintenancePlantStore {
  MaintenancePlantStore({
    Map<String, dynamic>? Function()? read,
    Future<void> Function(Map<String, dynamic>? value)? write,
  }) : _read = read ?? _readLocal,
       _write = write ?? _writeLocal;

  /// The host-record key. LocalStorage prefixes it, so it cannot collide
  /// with a typed key.
  static const String key = 'productivity.plant';

  /// The device's store.
  static final MaintenancePlantStore local = MaintenancePlantStore();

  final Map<String, dynamic>? Function() _read;
  final Future<void> Function(Map<String, dynamic>? value) _write;

  static Map<String, dynamic>? _readLocal() => LocalStorage.getJson(key);

  static Future<void> _writeLocal(Map<String, dynamic>? value) =>
      LocalStorage.setJson(key, value);

  /// The plant as last described, or null when it never was. A record
  /// that fails the old gate's test reads as none: the setup is offered
  /// again rather than a service run against half a plant.
  PlantRecord? current() {
    final Map<String, dynamic>? raw = _read();
    if (raw == null) return null;
    final PlantRecord record = PlantRecord.fromMap(raw);
    return record.isComplete ? record : null;
  }

  Future<void> save(PlantRecord? record) => _write(record?.toMap());

  /// 47d's capture: when [task] is the setup run and its required steps
  /// are done, read the plant off its readings and keep it. Any other
  /// task, or a setup run still in progress, is left alone and returns
  /// null. Hosts call this beside every run save; it is idempotent.
  Future<PlantRecord?> captureFromRun(
    Map<String, dynamic> task, {
    DateTime? now,
  }) async {
    if ('${task[MaintenanceSetup.templateKey] ?? ''}' !=
        MaintenanceSetup.template) {
      return null;
    }
    final PlantRecord? record = MaintenanceSetup.recordFrom(
      task,
      now: now ?? DateTime.now(),
    );
    if (record == null) return null;
    await save(record);
    return record;
  }
}

/// Frame 47d — the setup run's content, and the reverse read that turns
/// a finished one into a [PlantRecord]. The step titles and the reading
/// labels are the join between the two, so they are named once here.
class MaintenanceSetup {
  MaintenanceSetup._();

  /// The task-map key that names which template made a task, and the
  /// value that names the setup run.
  static const String templateKey = 'template';
  static const String template = 'plant_setup';

  static const String title = 'Plant setup';

  static const String vesselsStep = 'Vessels';
  static const String filtersStep = 'Filters';
  static const String membranesStep = 'RO membranes';
  static const String waterSpecStep = 'Water spec';

  static const String megaCharVessels = 'MegaChar vessels';
  static const String softenerVessels = 'Softener vessels';
  static const String installedOn = 'Installed on';
  static const String preFilterInstalledOn = 'Pre-filter installed on';
  static const String roFilterInstalledOn = 'RO filter installed on';
  static const String postFilterInstalledOn = 'Post-filter installed on';
  static const String membranes = 'Membranes';
  static const String feedTdsMax = 'Feed TDS, at most';
  static const String permeateTdsMax = 'Permeate TDS, at most';
  static const String feedPressureMin = 'Feed pressure, at least';
  static const String feedPressureMax = 'Feed pressure, at most';
  static const String permeatePressureMin = 'Permeate pressure, at least';

  /// The four steps of 47d as subtask maps: three required reading
  /// steps and the optional water spec, pre-filled with the frame's
  /// thresholds so skipping it is the same as accepting them.
  static List<Map<String, dynamic>> steps({
    WaterSpec spec = WaterSpec.defaults,
  }) {
    Map<String, dynamic> count(String label) =>
        ReadingSpec(label: label, min: 1).toMap();
    Map<String, dynamic> day(String label) =>
        ReadingSpec(label: label, isDate: true).toMap();
    Map<String, dynamic> limit(String label, String unit, num value) =>
        ReadingSpec(label: label, unit: unit, value: '$value').toMap();
    return <Map<String, dynamic>>[
      TaskRunStep(
        title: vesselsStep,
        instruction: 'How many vessels does this plant run?',
        kind: StepKind.reading,
        readings: <ReadingSpec>[
          ReadingSpec.fromMap(count(megaCharVessels)),
          ReadingSpec.fromMap(count(softenerVessels)),
          ReadingSpec.fromMap(day(installedOn)),
        ],
      ).toMap(),
      TaskRunStep(
        title: filtersStep,
        instruction: 'When was each filter installed?',
        kind: StepKind.reading,
        readings: <ReadingSpec>[
          ReadingSpec.fromMap(day(preFilterInstalledOn)),
          ReadingSpec.fromMap(day(roFilterInstalledOn)),
          ReadingSpec.fromMap(day(postFilterInstalledOn)),
        ],
      ).toMap(),
      TaskRunStep(
        title: membranesStep,
        instruction: 'How many membranes, and when were they installed?',
        kind: StepKind.reading,
        readings: <ReadingSpec>[
          ReadingSpec.fromMap(count(membranes)),
          ReadingSpec.fromMap(day(installedOn)),
        ],
      ).toMap(),
      TaskRunStep(
        title: waterSpecStep,
        instruction:
            'The limits the readings step checks against. Skip to keep these.',
        kind: StepKind.reading,
        optional: true,
        readings: <ReadingSpec>[
          ReadingSpec.fromMap(limit(feedTdsMax, 'ppm', spec.feedTdsMax)),
          ReadingSpec.fromMap(
            limit(permeateTdsMax, 'ppm', spec.permeateTdsMax),
          ),
          ReadingSpec.fromMap(
            limit(feedPressureMin, 'bar', spec.feedPressureMin),
          ),
          ReadingSpec.fromMap(
            limit(feedPressureMax, 'bar', spec.feedPressureMax),
          ),
          ReadingSpec.fromMap(
            limit(permeatePressureMin, 'bar', spec.permeatePressureMin),
          ),
        ],
      ).toMap(),
    ];
  }

  /// The plant a finished setup run describes, or null while any of the
  /// three required steps is open or a required value fails to parse.
  static PlantRecord? recordFrom(Map<String, dynamic> task, {DateTime? now}) {
    final TaskRun run = TaskRun.fromTask(task);
    TaskRunStep? step(String title) {
      for (final TaskRunStep s in run.steps) {
        if (s.title == title) return s;
      }
      return null;
    }

    final TaskRunStep? vessels = step(vesselsStep);
    final TaskRunStep? filters = step(filtersStep);
    final TaskRunStep? membraneStep = step(membranesStep);
    if (vessels == null || filters == null || membraneStep == null) return null;
    for (final TaskRunStep s in <TaskRunStep>[vessels, filters, membraneStep]) {
      if (!s.isDone || s.skipped || !s.isSatisfied) return null;
    }
    final TaskRunStep? water = step(waterSpecStep);
    final bool specGiven =
        water != null && water.isDone && !water.skipped && water.isSatisfied;

    ReadingSpec? reading(TaskRunStep s, String label) {
      for (final ReadingSpec r in s.readings) {
        if (r.label == label) return r;
      }
      return null;
    }

    // A limit typed as a whole number is kept as one, so the spec prints
    // as "≤ 60", not "≤ 60.0"; a typed decimal keeps its decimal.
    num limit(String label, num fallback) {
      final double? typed = specGiven ? reading(water, label)?.number : null;
      if (typed == null) return fallback;
      return typed == typed.roundToDouble() ? typed.toInt() : typed;
    }

    final WaterSpec spec = WaterSpec(
      feedTdsMax: limit(feedTdsMax, WaterSpec.defaults.feedTdsMax),
      permeateTdsMax: limit(permeateTdsMax, WaterSpec.defaults.permeateTdsMax),
      feedPressureMin: limit(
        feedPressureMin,
        WaterSpec.defaults.feedPressureMin,
      ),
      feedPressureMax: limit(
        feedPressureMax,
        WaterSpec.defaults.feedPressureMax,
      ),
      permeatePressureMin: limit(
        permeatePressureMin,
        WaterSpec.defaults.permeatePressureMin,
      ),
    );
    final PlantRecord record = PlantRecord(
      megaCharVessels: reading(vessels, megaCharVessels)?.number?.toInt() ?? 0,
      softenerVessels: reading(vessels, softenerVessels)?.number?.toInt() ?? 0,
      vesselsInstalledOn: reading(vessels, installedOn)?.date,
      preFilterInstalledOn: reading(filters, preFilterInstalledOn)?.date,
      roFilterInstalledOn: reading(filters, roFilterInstalledOn)?.date,
      postFilterInstalledOn: reading(filters, postFilterInstalledOn)?.date,
      membranes: reading(membraneStep, membranes)?.number?.toInt() ?? 0,
      membranesInstalledOn: reading(membraneStep, installedOn)?.date,
      spec: spec,
      recordedAt: now,
    );
    return record.isComplete ? record : null;
  }
}

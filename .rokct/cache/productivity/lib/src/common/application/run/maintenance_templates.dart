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

// Design strip section 47 (frames 47a–47d, 47h, 47i; approved 2026-08-31)
// — the RO plant's service runs as ORDINARY TASKS. Ray's ruling, verbatim:
// "maintenance is just a normal multi step task with reminder, no
// privilege". So there is no maintenance screen, no dashboard, no hub
// row and no doctype here: a service run is a task map with
// `stepsAreSequential` set and a step list, made from the compose lane's
// "From template" chooser exactly as any other task is made, run on
// section 46's runner exactly as any other run is run, and reminded of
// by the task's own reminder and recurrence.
//
// The step lists are PORTED, NOT INVENTED. Names, order, durations and
// instruction strings are paas_pos's own — the `MaintenanceStage`
// sequences (`enums.dart:126-151`, nine stages for a softener, seven for
// a megaChar, the first four shared) with the durations from its
// `AppConstants` maps (`app_constants.dart:118-138`) and the operator
// instructions from `maintenance_timer_dialog.dart:234-256`. The two
// things paas_pos does not have — the readings step (47h) and the photo
// step (47i) — are the section's one addition and ride at the end of
// each run, exactly where 47a's rail draws them as steps 10 and 11.
//
// The 11-value stage enum is deliberately NOT carried: a stage is a step
// title, a step is a subtask, and an owner who wants a 20-minute rinse
// edits the number on the task. The maps below are the seed, not a
// schema.
//
// Durations are ONE map, in seconds. The clock is section 46's — remaining
// time is recomputed from `startedAt` on every read, so a brine rinse
// started at 22:00 and looked at the next morning (47c) has run out, with
// no timer alive in between. paas_pos's two-timer countdown is not ported.

import 'maintenance_plant.dart';
import 'task_run.dart';

/// The stage clock: seconds per stage, paas_pos's `AppConstants` maps
/// (minutes × 60). 0 is an untimed, confirm-only step — never skipped,
/// never automatic.
const Map<String, int> kMaintenanceStageSeconds = <String, int>{
  'Initial Check': 0,
  'Pressure Release': 120,
  'Backwash': 600,
  'Settling': 120,
  'Fast Wash': 600,
  'Brine and Slow Rinse': 1800,
  'Fast Rinse': 600,
  'Brine Refill': 300,
  'Stabilization': 120,
  'Return to Filter': 0,
  'Return to Service': 0,
};

/// What the operator does on each stage, verbatim.
const Map<String, String> kMaintenanceStageInstructions = <String, String>{
  'Initial Check':
      'Check all connections and ensure system is ready for maintenance.',
  'Pressure Release': 'Release pressure from the system carefully.',
  'Backwash': 'System is in backwash mode. Monitor pressure gauge.',
  'Settling': 'Allow system to settle. Check for any irregularities.',
  'Fast Wash': 'System is in fast wash mode. Monitor water clarity.',
  'Brine and Slow Rinse': 'System is in brine and slow rinse mode.',
  'Fast Rinse': 'System is in fast rinse mode. Monitor water quality.',
  'Brine Refill': 'Brine tank is being refilled.',
  'Stabilization': 'Allow system to stabilize. Check pressure readings.',
  'Return to Filter': 'Return system to filtration mode.',
  'Return to Service': 'Return system to service mode.',
};

/// The softener regeneration, nine stages in paas_pos's order (47a).
const List<String> kSoftenerStages = <String>[
  'Initial Check',
  'Pressure Release',
  'Backwash',
  'Settling',
  'Brine and Slow Rinse',
  'Fast Rinse',
  'Brine Refill',
  'Stabilization',
  'Return to Service',
];

/// The megaChar backwash, seven stages; the first four are the softener's.
const List<String> kMegaCharStages = <String>[
  'Initial Check',
  'Pressure Release',
  'Backwash',
  'Settling',
  'Fast Wash',
  'Stabilization',
  'Return to Filter',
];

/// Service and replacement intervals, in days. The vessel service is the
/// 47a card's "every 7 days" and travels as the task's Weekly recurrence;
/// the sediment pre-filter's 30 days is the same card's; the RO filter's
/// 180 and the membranes' 365 are paas_pos's defaults.
const int kVesselServiceDays = 7;
const int kPreFilterDays = 30;
const int kRoFilterDays = 180;
const int kMembraneDays = 365;

/// The step titles 47a adds after the last stage.
const String kReadingsStepTitle = 'Readings';
const String kPhotoStepTitle = 'Photo & notes';

/// The reading labels on the 47h card.
const String kFeedTdsLabel = 'TDS — feed';
const String kPermeateTdsLabel = 'TDS — permeate';
const String kFeedPressureLabel = 'Pressure — feed';
const String kPermeatePressureLabel = 'Pressure — permeate';

/// What the compose lane's "From template" chooser offers.
enum MaintenanceTemplate {
  /// 47d — describe the plant. Offered first; the rest wait on it.
  plantSetup,

  /// 47a — the nine-stage softener regeneration plus readings and photo.
  softenerMaintenance,

  /// The seven-stage megaChar backwash plus readings and photo.
  megaCharMaintenance,

  /// The 47a list's replacement reminders: an ordinary task with a due
  /// date from the plant record and no step list, because no source
  /// gives one and none is invented here.
  preFilterReplacement,
  roFilterReplacement,
  membraneReplacement,
}

extension MaintenanceTemplateX on MaintenanceTemplate {
  /// The value on the task map's `template` key.
  String get key => switch (this) {
    MaintenanceTemplate.plantSetup => MaintenanceSetup.template,
    MaintenanceTemplate.softenerMaintenance => 'softener_maintenance',
    MaintenanceTemplate.megaCharMaintenance => 'megachar_maintenance',
    MaintenanceTemplate.preFilterReplacement => 'pre_filter_replacement',
    MaintenanceTemplate.roFilterReplacement => 'ro_filter_replacement',
    MaintenanceTemplate.membraneReplacement => 'membrane_replacement',
  };

  /// The task's title. The two vessel runs are paas_pos's own display
  /// names ("Megachar" / "Softener" + "Maintenance"); the rest are the
  /// 47a and 47d cards' words.
  String get title => switch (this) {
    MaintenanceTemplate.plantSetup => MaintenanceSetup.title,
    MaintenanceTemplate.softenerMaintenance => 'Softener Maintenance',
    MaintenanceTemplate.megaCharMaintenance => 'Megachar Maintenance',
    MaintenanceTemplate.preFilterReplacement => 'Pre-filter replacement',
    MaintenanceTemplate.roFilterReplacement => 'RO filter replacement',
    MaintenanceTemplate.membraneReplacement => 'RO membrane replacement',
  };

  /// 47d's gate: everything but the setup needs the plant described.
  bool get needsPlant => this != MaintenanceTemplate.plantSetup;

  /// Whether the template is a guided run — has a step list.
  bool get isGuided => switch (this) {
    MaintenanceTemplate.plantSetup ||
    MaintenanceTemplate.softenerMaintenance ||
    MaintenanceTemplate.megaCharMaintenance => true,
    _ => false,
  };
}

/// The templates, built as task maps.
class MaintenanceTemplates {
  MaintenanceTemplates._();

  /// The task-map key naming the template a task was made from. Absent on
  /// a task made by hand — which is every task before this release.
  static const String templateKey = MaintenanceSetup.templateKey;

  /// Every template, in the order the chooser lists them: setup first.
  static const List<MaintenanceTemplate> all = MaintenanceTemplate.values;

  /// Whether [template] may be chosen with [plant] as the record: setup
  /// always, the rest only once the plant is described (47d).
  static bool isOffered(MaintenanceTemplate template, PlantRecord? plant) =>
      !template.needsPlant || plant != null;

  static MaintenanceTemplate? byKey(String? key) {
    for (final MaintenanceTemplate template in all) {
      if (template.key == key) return template;
    }
    return null;
  }

  /// The step list for [template]: the stages as timed or confirm-only
  /// steps, then the required readings step and the optional photo
  /// step; the setup's four steps; nothing for a replacement.
  static List<Map<String, dynamic>> steps(
    MaintenanceTemplate template, {
    PlantRecord? plant,
  }) {
    final WaterSpec spec = plant?.spec ?? WaterSpec.defaults;
    switch (template) {
      case MaintenanceTemplate.plantSetup:
        return MaintenanceSetup.steps(spec: spec);
      case MaintenanceTemplate.softenerMaintenance:
        return _serviceRun(kSoftenerStages, spec);
      case MaintenanceTemplate.megaCharMaintenance:
        return _serviceRun(kMegaCharStages, spec);
      case MaintenanceTemplate.preFilterReplacement:
      case MaintenanceTemplate.roFilterReplacement:
      case MaintenanceTemplate.membraneReplacement:
        return const <Map<String, dynamic>>[];
    }
  }

  /// When [template]'s task is due. A vessel service is due the day it is
  /// made (the 47a card's DUE TODAY) and repeats weekly; a replacement is
  /// due its interval after the install date the plant record holds,
  /// or today when the record has no date for it; the setup has no
  /// deadline.
  static DateTime? dueOn(
    MaintenanceTemplate template, {
    required DateTime now,
    PlantRecord? plant,
  }) {
    DateTime day(DateTime value) =>
        DateTime(value.year, value.month, value.day);
    switch (template) {
      case MaintenanceTemplate.plantSetup:
        return null;
      case MaintenanceTemplate.softenerMaintenance:
      case MaintenanceTemplate.megaCharMaintenance:
        return day(now);
      case MaintenanceTemplate.preFilterReplacement:
        return _after(plant?.preFilterInstalledOn, kPreFilterDays, day(now));
      case MaintenanceTemplate.roFilterReplacement:
        return _after(plant?.roFilterInstalledOn, kRoFilterDays, day(now));
      case MaintenanceTemplate.membraneReplacement:
        return _after(plant?.membranesInstalledOn, kMembraneDays, day(now));
    }
  }

  /// The task's recurrence, in the compose lane's own vocabulary: the
  /// vessel services are weekly (the 7-day interval), the pre-filter's 30
  /// days is monthly, and the two long intervals have no Select value
  /// and repeat by the next template pick.
  static String recurrence(MaintenanceTemplate template) => switch (template) {
    MaintenanceTemplate.softenerMaintenance ||
    MaintenanceTemplate.megaCharMaintenance => 'Weekly',
    MaintenanceTemplate.preFilterReplacement => 'Monthly',
    _ => 'None',
  };

  /// The task map for [template] — everything the compose lane would
  /// have filled by hand, and nothing it adds itself (id, notification
  /// id, created-at are the page's). Handed to the form, not saved here.
  static Map<String, dynamic> build(
    MaintenanceTemplate template, {
    required DateTime now,
    PlantRecord? plant,
  }) {
    final DateTime? due = dueOn(template, now: now, plant: plant);
    return <String, dynamic>{
      'title': template.title,
      templateKey: template.key,
      'isDone': false,
      'priority': 'Medium',
      'stepsAreSequential': template.isGuided,
      'recurrence': recurrence(template),
      'reminder': due != null,
      'deadline': due?.toIso8601String(),
      'subtasks': steps(template, plant: plant),
    };
  }

  static DateTime _after(DateTime? installed, int days, DateTime fallback) =>
      installed == null ? fallback : installed.add(Duration(days: days));

  static List<Map<String, dynamic>> _serviceRun(
    List<String> stages,
    WaterSpec spec,
  ) => <Map<String, dynamic>>[
    for (final String stage in stages)
      TaskRunStep(
        title: stage,
        instruction: kMaintenanceStageInstructions[stage],
        durationSeconds: kMaintenanceStageSeconds[stage] ?? 0,
      ).toMap(),
    readingsStep(spec).toMap(),
    photoStep().toMap(),
  ];

  /// 47h — REQUIRED. Four readings against the plant's spec; the step
  /// blocks while one is empty or out of spec and unexplained.
  static TaskRunStep readingsStep([WaterSpec spec = WaterSpec.defaults]) =>
      TaskRunStep(
        title: kReadingsStepTitle,
        instruction: 'Take TDS and pressure before returning to service.',
        kind: StepKind.reading,
        readings: <ReadingSpec>[
          ReadingSpec(label: kFeedTdsLabel, unit: 'ppm', max: spec.feedTdsMax),
          ReadingSpec(
            label: kPermeateTdsLabel,
            unit: 'ppm',
            max: spec.permeateTdsMax,
          ),
          ReadingSpec(
            label: kFeedPressureLabel,
            unit: 'bar',
            min: spec.feedPressureMin,
            max: spec.feedPressureMax,
          ),
          ReadingSpec(
            label: kPermeatePressureLabel,
            unit: 'bar',
            min: spec.permeatePressureMin,
          ),
        ],
      );

  /// 47i — OPTIONAL. A photo and a note; Skip is live beside Finish.
  static TaskRunStep photoStep() => const TaskRunStep(
    title: kPhotoStepTitle,
    instruction: 'Optional. Skipping does not hold up the run.',
    kind: StepKind.photo,
    optional: true,
  );
}

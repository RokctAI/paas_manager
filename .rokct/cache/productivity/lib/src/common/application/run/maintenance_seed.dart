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

// THE RO PLANT, SEEDED. Ray, 2026-09-24: "i think you need to make it a
// seedable data ... seed as already setup". The templates in
// maintenance_templates.dart stay in the "From template" chooser for
// everyone else; the accounts that run the plant START with it already
// described and its service runs and replacement reminders already on
// their list as real tasks, due and recurring, never picked by hand.
//
// Two paths reach the same state:
//
// * DEMO (DemoSession.demoActive): no server is consulted, so
//   [MaintenanceSeed.seedDemo] writes the plant record, a finished setup
//   run and the five service tasks straight into the local stores, once.
// * A REAL ACCOUNT (the signed-in email is in [plantOwnerEmails]):
//   [MaintenanceSeed.seedAccount] writes the same records once per owner,
//   with ids stable per account, through the ordinary tasks save, so the
//   SyncEngine pushes them to the server. No backend seeder exists (Ray:
//   seeds happen in Dart). Another device of the same account pulls them
//   down; its own seed finds the same ids and writes nothing. The plant is
//   device-local (maintenance_plant.dart) and the server Task carries no
//   `template` column and no step kinds, so [MaintenanceSeed.adoptPulled]
//   recognises a seeded task by its client id, restores its template key
//   and full step list, and writes the placeholder plant record when the
//   device has none.
//
// PLACEHOLDERS. The plant's real numbers were never given. Every figure
// below that is not a paas_pos default already ported into
// maintenance_templates.dart is a PLACEHOLDER, named as one, and the owner
// corrects it by editing the seeded Plant setup run: one megaChar vessel,
// one softener vessel, one membrane, every install date the day of
// seeding, and WaterSpec.defaults for the water spec.

import 'package:base_sdk/base_sdk.dart';

import 'maintenance_plant.dart';
import 'maintenance_templates.dart';

class MaintenanceSeed {
  MaintenanceSeed._();

  /// PLACEHOLDER counts — not known for the real plant.
  static const int placeholderMegaCharVessels = 1;
  static const int placeholderSoftenerVessels = 1;
  static const int placeholderMembranes = 1;

  /// The client-id prefix of every seeded task, followed by the template
  /// key and a dash.
  static const String clientIdPrefix = 'ro-seed-';

  /// The templates seeded as live tasks (everything but the setup, which
  /// is seeded as a FINISHED run).
  static const List<MaintenanceTemplate> seededTemplates =
      <MaintenanceTemplate>[
        MaintenanceTemplate.softenerMaintenance,
        MaintenanceTemplate.megaCharMaintenance,
        MaintenanceTemplate.phFixMaintenance,
        MaintenanceTemplate.preFilterReplacement,
        MaintenanceTemplate.roFilterReplacement,
        MaintenanceTemplate.membraneReplacement,
      ];

  /// The seed's version, written on its done flag. 2 added the pH fix
  /// vessel's service run (Ray, 2026-10-04).
  static const int seedVersion = 2;

  /// The template keys each version ADDED. An owner seeded at an older
  /// version gets only these on the next start — never the rest again,
  /// so a seeded task they deleted stays deleted.
  static const Map<int, Set<String>> addedInVersion = <int, Set<String>>{
    2: <String>{'phfix_maintenance'},
  };

  /// LocalStorage key marking the demo seed as done, so a seeded task the
  /// demo user deletes stays deleted.
  static const String demoSeededKey = 'productivity.plant.demo_seeded';

  static DateTime _day(DateTime v) => DateTime(v.year, v.month, v.day);

  /// The placeholder plant: installs dated [now]'s day.
  static PlantRecord plant(DateTime now) {
    final DateTime day = _day(now);
    return PlantRecord(
      megaCharVessels: placeholderMegaCharVessels,
      softenerVessels: placeholderSoftenerVessels,
      vesselsInstalledOn: day,
      preFilterInstalledOn: day,
      roFilterInstalledOn: day,
      postFilterInstalledOn: day,
      membranes: placeholderMembranes,
      membranesInstalledOn: day,
      recordedAt: now,
    );
  }

  /// The template a seeded client id names, or null.
  static MaintenanceTemplate? templateOfClientId(String? clientId) {
    final String id = clientId ?? '';
    if (!id.startsWith(clientIdPrefix)) return null;
    final String rest = id.substring(clientIdPrefix.length);
    final int dash = rest.indexOf('-');
    return MaintenanceTemplates.byKey(
      dash < 0 ? rest : rest.substring(0, dash),
    );
  }

  /// The setup run for [record], every step done and every reading filled,
  /// so MaintenanceSetup.recordFrom reads [record] back off it.
  static Map<String, dynamic> finishedSetup(PlantRecord record, DateTime now) {
    String day(DateTime? v) => v == null
        ? ''
        : '${v.year.toString().padLeft(4, '0')}-'
              '${v.month.toString().padLeft(2, '0')}-'
              '${v.day.toString().padLeft(2, '0')}';
    final Map<String, Map<String, String>>
    values = <String, Map<String, String>>{
      MaintenanceSetup.vesselsStep: <String, String>{
        MaintenanceSetup.megaCharVessels: '${record.megaCharVessels}',
        MaintenanceSetup.softenerVessels: '${record.softenerVessels}',
        MaintenanceSetup.installedOn: day(record.vesselsInstalledOn),
      },
      MaintenanceSetup.filtersStep: <String, String>{
        MaintenanceSetup.preFilterInstalledOn: day(record.preFilterInstalledOn),
        MaintenanceSetup.roFilterInstalledOn: day(record.roFilterInstalledOn),
        MaintenanceSetup.postFilterInstalledOn: day(
          record.postFilterInstalledOn,
        ),
      },
      MaintenanceSetup.membranesStep: <String, String>{
        MaintenanceSetup.membranes: '${record.membranes}',
        MaintenanceSetup.installedOn: day(record.membranesInstalledOn),
      },
    };
    final String stamp = now.toIso8601String();
    final List<Map<String, dynamic>> steps = <Map<String, dynamic>>[
      for (final Map<String, dynamic> step in MaintenanceSetup.steps(
        spec: record.spec,
      ))
        <String, dynamic>{
          ...step,
          'isDone': true,
          'startedAt': stamp,
          'completedAt': stamp,
          'readings': <Map<String, dynamic>>[
            for (final Object? r in (step['readings'] as List? ?? const []))
              <String, dynamic>{
                ...(r as Map).cast<String, dynamic>(),
                if (values[step['title']]?[r['label']] case final String v)
                  'value': v,
              },
          ],
        },
    ];
    final Map<String, dynamic> task = MaintenanceTemplates.build(
      MaintenanceTemplate.plantSetup,
      now: now,
      plant: record,
    );
    return <String, dynamic>{...task, 'isDone': true, 'subtasks': steps};
  }

  /// Every seeded task map for [record], with stable ids built from
  /// [idSuffix] so a second seed finds the first.
  static List<Map<String, dynamic>> tasks(
    PlantRecord record, {
    required DateTime now,
    String idSuffix = 'demo',
  }) {
    Map<String, dynamic> withIds(Map<String, dynamic> task, String key) {
      final String id = '$clientIdPrefix$key-$idSuffix';
      return <String, dynamic>{
        ...task,
        'id': id,
        'clientId': id,
        'notifId': id.hashCode & 0x7fffffff,
        'createdAt': now.toIso8601String(),
      };
    }

    return <Map<String, dynamic>>[
      withIds(finishedSetup(record, now), MaintenanceSetup.template),
      for (final MaintenanceTemplate t in seededTemplates)
        withIds(MaintenanceTemplates.build(t, now: now, plant: record), t.key),
    ];
  }

  /// DEMO: seed the plant and its tasks once. [load]/[save] are the tasks
  /// repository's; the flag and plant store are injectable for tests.
  /// Returns whether anything was written.
  static Future<bool> seedDemo({
    required Future<List<Map<String, dynamic>>> Function() load,
    required Future<void> Function(List<Map<String, dynamic>>) save,
    MaintenancePlantStore? store,
    bool Function()? isSeeded,
    int Function()? seededVersion,
    Future<void> Function()? markSeeded,
    DateTime? now,
  }) => _seed(
    load: load,
    save: save,
    store: store,
    idSuffix: 'demo',
    flagKey: demoSeededKey,
    isSeeded: isSeeded,
    seededVersion: seededVersion,
    markSeeded: markSeeded,
    now: now,
  );

  /// The accounts that run the plant. Matched case-insensitively against
  /// the signed-in user's email.
  static const Set<String> plantOwnerEmails = <String>{'sinyage@gmail.com'};

  /// LocalStorage key prefix marking the account seed as done for one
  /// owner; the owner id follows it.
  static const String accountSeededKeyPrefix = 'productivity.plant.seeded.';

  /// The signed-in user's email, from the profile auth persists in
  /// base_sdk's LocalStorage (null for a temp-local account, which stores
  /// no user).
  static String? currentEmail() => LocalStorage.getUser()?.email;

  /// An owner id reduced to characters safe in a client id.
  static String idSuffixFor(String owner) =>
      owner.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');

  /// REAL ACCOUNT: when the signed-in user is a plant owner, seed the plant
  /// and its tasks once per owner. The tasks go through [save], the tasks
  /// repository's ordinary save, so the SyncEngine pushes them to the
  /// server like any task the user made. Ids are `ro-seed-<key>-<owner>`:
  /// stable per account, so a second device (or this one after a pull)
  /// finds the same ids and writes nothing twice, and [adoptPulled] still
  /// recognises them by prefix.
  static Future<bool> seedAccount({
    required Future<List<Map<String, dynamic>>> Function() load,
    required Future<void> Function(List<Map<String, dynamic>>) save,
    String? Function()? email,
    String Function()? owner,
    MaintenancePlantStore? store,
    bool Function()? isSeeded,
    int Function()? seededVersion,
    Future<void> Function()? markSeeded,
    DateTime? now,
  }) async {
    final String mail = ((email ?? currentEmail)() ?? '').trim().toLowerCase();
    if (!plantOwnerEmails.contains(mail)) return false;
    final String who = (owner ?? () => OwnerScope.instance.current)();
    if (who.isEmpty || who == kUnownedOwner) return false;
    return _seed(
      load: load,
      save: save,
      store: store,
      idSuffix: idSuffixFor(who),
      flagKey: '$accountSeededKeyPrefix${idSuffixFor(who)}',
      isSeeded: isSeeded,
      seededVersion: seededVersion,
      markSeeded: markSeeded,
      now: now,
    );
  }

  static Future<bool> _seed({
    required Future<List<Map<String, dynamic>>> Function() load,
    required Future<void> Function(List<Map<String, dynamic>>) save,
    required String idSuffix,
    required String flagKey,
    MaintenancePlantStore? store,
    bool Function()? isSeeded,
    int Function()? seededVersion,
    Future<void> Function()? markSeeded,
    DateTime? now,
  }) async {
    // The version this owner was seeded at: 0 never, [seedVersion] done.
    // A flag written before versions were compared reads as its own
    // `version` field (1 for every flag written so far).
    final int had = seededVersion != null
        ? seededVersion()
        : isSeeded != null
        ? (isSeeded() ? seedVersion : 0)
        : switch (LocalStorage.getJson(flagKey)) {
            null => 0,
            final Map<String, dynamic> j =>
              (j['version'] as num?)?.toInt() ?? 1,
            _ => 1,
          };
    if (had >= seedVersion) return false;
    final Set<String>? onlyKeys = had == 0
        ? null
        : <String>{
            for (int v = had + 1; v <= seedVersion; v++) ...?addedInVersion[v],
          };
    final DateTime at = now ?? DateTime.now();
    final MaintenancePlantStore plants = store ?? MaintenancePlantStore.local;
    final PlantRecord record = plants.current() ?? plant(at);
    if (plants.current() == null) await plants.save(record);
    final List<Map<String, dynamic>> todos = await load();
    final Set<String> have = <String>{
      for (final Map<String, dynamic> t in todos) ...<String>{
        '${t['id'] ?? ''}',
        '${t['clientId'] ?? ''}',
      },
    };
    final List<Map<String, dynamic>> fresh = <Map<String, dynamic>>[
      for (final Map<String, dynamic> t in tasks(
        record,
        now: at,
        idSuffix: idSuffix,
      ))
        if (!have.contains(t['id']) &&
            (onlyKeys == null ||
                onlyKeys.contains(t[MaintenanceTemplates.templateKey])))
          t,
    ];
    if (fresh.isNotEmpty)
      await save(<Map<String, dynamic>>[...todos, ...fresh]);
    await (markSeeded ??
        () => LocalStorage.setJson(flagKey, <String, dynamic>{
          'version': seedVersion,
          'at': at.toIso8601String(),
        }))();
    return true;
  }

  /// REAL ACCOUNT: make pulled seeded tasks whole on this device. For each
  /// task whose client id carries [clientIdPrefix]: restores the
  /// `template` key and, while no step has been touched, the template's
  /// full step list (the server keeps no step kinds or readings). Writes
  /// the placeholder plant record when any seeded task is present and the
  /// device has none. Returns the tasks that changed, for the caller to
  /// save; the list passed in is updated in place.
  static Future<List<Map<String, dynamic>>> adoptPulled(
    List<Map<String, dynamic>> todos, {
    MaintenancePlantStore? store,
    DateTime? now,
  }) async {
    final MaintenancePlantStore plants = store ?? MaintenancePlantStore.local;
    final List<Map<String, dynamic>> changed = <Map<String, dynamic>>[];
    PlantRecord? record = plants.current();
    for (final Map<String, dynamic> todo in todos) {
      final MaintenanceTemplate? template = templateOfClientId(
        '${todo['clientId'] ?? ''}',
      );
      if (template == null) continue;
      if (record == null) {
        record = plant(now ?? DateTime.now());
        await plants.save(record);
      }
      if (todo[MaintenanceTemplates.templateKey] == template.key) continue;
      todo[MaintenanceTemplates.templateKey] = template.key;
      final List<Object?> steps = (todo['subtasks'] as List?) ?? const [];
      final bool untouched = steps.every(
        (s) => s is Map && s['isDone'] != true && s['startedAt'] == null,
      );
      if (untouched && template.isGuided) {
        todo['subtasks'] = MaintenanceTemplates.steps(template, plant: record);
      }
      changed.add(todo);
    }
    return changed;
  }
}

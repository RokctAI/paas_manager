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

import '../../infrastructure/services/task_pull_service.dart';
import '../tasks/tasks_notifier.dart';

/// This SDK's half of a sign-out: the tasks leave the SCREEN. They do not
/// leave the DEVICE.
///
/// WHY THIS EXISTS. Ray, 2026-09-19: "if on temp local user you logout all
/// your tasks still show". The reported symptom was never that the rows were
/// on disk -- it was that they were still painted. `tasksStateProvider` is a
/// plain `StateNotifierProvider`, root-scoped and not `autoDispose`, so the
/// notifier and the tasks it is holding outlive the `replaceMainRoute` a
/// sign-out ends with: the page is rebuilt and RE-READS the same surviving
/// notifier. Nothing else in the fleet cleared it, because users_sdk's
/// `SessionEndHooks` had published the moment since it shipped with exactly
/// one subscriber -- auth_sdk's restore-key revoke.
///
/// WHY IT DELETES NOTHING. Ray, on the first cut of this hook, which did
/// delete: a local temp account that does real work and signs out must not
/// come back to an empty list, and the same holds for a seller. Emptying the
/// screen is reversible -- the next read of the tables puts the list back.
/// Emptying the tables is not. The symptom was cosmetic; the fix was
/// cosmetic; the data stays.
///
/// WHAT IT TOUCHES, AND WHAT IT LEAVES ALONE.
///
///   * [TasksNotifier.clearLive] -- in-memory task objects in every live
///     notifier. The half that actually fixed the reported symptom.
///   * `TaskPullService.lastFailure` -- a transient "sync failed" notice that
///     belonged to the session that just ended. Not user data, and the next
///     user's list must not be drawn under it.
///
/// It does NOT delete the `TasksTable` rows, the `NotesTable` rows, this
/// SDK's pending `outboxTable` rows, or the incremental pull cursor. The
/// outbox rows matter most of all: they are work the user did that has not
/// reached the server yet, and deleting them destroys it outright. The
/// recovery tables (`recovery_tables.dart`) were never touched here and still
/// are not.
///
/// WHAT IS THEREFORE STILL OPEN. This clears the session, not the ownership.
/// One device shared by two accounts still shows each the other's rows once
/// the tables are read again, because `TasksTable.createdBy` is written and
/// never filtered on and `NotesTable` has no user column at all. That is an
/// owner-scoping change -- a `WHERE` at the repository layer and a migration
/// for notes -- and it is the right fix. It is not this file's to make, and
/// wiping the data is not a substitute for it.
///
/// WHY IT CANNOT FAIL A SIGN-OUT. Nothing here reaches the network or the
/// store; it is two in-memory writes. `SessionEndHooks.run()` isolates each
/// hook besides, so a throw here could never block the sign-out either.
///
/// HOW IT IS WIRED. This SDK's `manifest.json` boot hook registers
/// [clearLiveView] under [hookId] against users_sdk's `SessionEndHooks`,
/// which `UserRepository` fires on logout AND on delete-account, before the
/// request goes out and therefore on both the success and the failure path.
class ProductivitySessionEnd {
  ProductivitySessionEnd._();

  /// The `SessionEndHooks` id this SDK registers under. Registration is
  /// idempotent by id, so a hot restart or a double-armed boot hook cannot
  /// stack duplicates.
  ///
  /// Unchanged from the version of this hook that deleted: the id is only an
  /// idempotency key inside users_sdk's registry, nothing persists it and no
  /// other package reads it, so renaming it would buy nothing and would
  /// break any host still composing the old wiring block.
  static const String hookId = 'productivity_local_data';

  /// Drop this SDK's in-memory session state. Writes nothing and deletes
  /// nothing.
  static Future<void> clearLiveView() async {
    // The stale "sync failed" notice belonged to the session that just ended,
    // and the tasks page would otherwise draw it over the next user's list.
    TaskPullService.lastFailure.value = null;

    // THE ONE THE BUG WAS ABOUT. See [TasksNotifier.clearLive]:
    // `tasksStateProvider` is root-scoped, so the notifier -- and the tasks
    // it is holding -- outlive the route replace that a sign-out ends with.
    TasksNotifier.clearLive();
  }
}

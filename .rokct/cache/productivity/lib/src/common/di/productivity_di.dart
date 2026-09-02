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

import 'package:get_it/get_it.dart';
import 'package:base_sdk/base_sdk.dart';
import '../domain/interface/recovery_repository_facade.dart';
import '../infrastructure/repositories/recovery_repository_impl.dart';
import '../infrastructure/services/task_sync_handlers.dart';

class ProductivitySdkDependencies {
  static void register(GetIt getIt) {
    // Register Recovery Repository. Guarded, like every other SDK's hook
    // (auth's AuthSdkDependencies, orders' ManagerOrdersDependencies): the
    // installer convention is that a host may call this more than once, and
    // an unguarded registerLazySingleton throws the second time.
    if (!getIt.isRegistered<RecoveryRepositoryFacade>()) {
      getIt.registerLazySingleton<RecoveryRepositoryFacade>(
        () => RecoveryRepositoryImpl(getIt<AppDatabase>()),
      );
    }
    // Attach the task push handlers so tasks written on the device drain to
    // the backend (auth_di's AuthSyncHandler pattern, and orders'
    // ManagerOrdersDependencies for the multi-op-type shape).
    // BaseSdkDependencies.register puts the engine in get_it before feature
    // SDKs run; the process-singleton fallback keeps hand-wired hosts that
    // skipped it working. registerHandler replaces any previous handler, so
    // this is idempotent too. Requires base_sdk >= 1.5.0
    // (SyncEngine/SyncHandler).
    //
    // The engine is opt-in PER OP TYPE, not per table: an op whose type no
    // composed SDK registered stays pending untouched forever. Which is
    // exactly why nothing synced before this line existed, and why a host
    // that does not call this hook keeps the old local-only behaviour rather
    // than breaking.
    final engine = getIt.isRegistered<SyncEngine>()
        ? getIt<SyncEngine>()
        : SyncEngine();
    engine.registerHandler(
      TaskUpsertSyncHandler.opType,
      TaskUpsertSyncHandler(),
    );
    engine.registerHandler(
      TaskDeleteSyncHandler.opType,
      TaskDeleteSyncHandler(),
    );
    engine.registerHandler(
      TaskSnoozeSyncHandler.opType,
      TaskSnoozeSyncHandler(),
    );
  }
}

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

import 'package:base_sdk/base_sdk.dart' show DemoFixtures;
import 'package:kitchen_sdk/src/common/di/kitchen_di.dart'
    show kitchenDemoFixtureDirectory;
import 'package:kitchen_sdk/src/manager/domain/interface/kitchen_orders.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/repositories/kitchen_orders_repository.dart';

/// Manager-role DI hook (orders_sdk's `ManagerOrdersDependencies` pattern):
/// wired through the manifest's app_type.manager `di_hooks`, importing this
/// file via its direct `src/` path, so a compose without the manager role
/// never touches this slice. Registers idempotently so hand-wired hosts can
/// call it too.
class ManagerKitchenDependencies {
  static void register(GetIt getIt) {
    // Demo runs the REAL repository: base_sdk's DemoGatewayInterceptor
    // answers its cmds from the `<cmd>.json` fixtures in
    // [kitchenDemoFixtureDirectory] (a seeded service of five tickets)
    // while DemoSession.demoActive; an unknown cmd fails loudly with
    // DemoFixtureMissing. The production path is untouched.
    DemoFixtures.registerAssetDirectory(kitchenDemoFixtureDirectory);
    if (!getIt.isRegistered<KitchenOrdersRepositoryFacade>()) {
      getIt.registerSingleton<KitchenOrdersRepositoryFacade>(
        KitchenOrdersRepository(),
      );
    }
  }
}

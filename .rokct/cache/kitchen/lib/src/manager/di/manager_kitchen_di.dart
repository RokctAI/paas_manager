// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:get_it/get_it.dart';

import 'package:base_sdk/src/constants/app_constants.dart';
import 'package:kitchen_sdk/src/manager/domain/interface/kitchen_orders.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/repositories/demo_kitchen_orders_repository.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/repositories/kitchen_orders_repository.dart';

/// Manager-role DI hook (orders_sdk's `ManagerOrdersDependencies` pattern):
/// wired through the manifest's app_type.manager `di_hooks`, importing this
/// file via its direct `src/` path, so a compose without the manager role
/// never touches this slice. Registers idempotently so hand-wired hosts can
/// call it too.
class ManagerKitchenDependencies {
  static void register(GetIt getIt) {
    // Demo-gated like merchants_sdk's POS seams and products_sdk's catalog
    // facades: --dart-define=IS_DEMO=true serves a seeded kitchen service
    // from memory, so the Kitchen tab shows a live queue with ticking
    // clocks and dish pills instead of its empty state, with zero backend
    // contact. The production path is untouched.
    if (!getIt.isRegistered<KitchenOrdersRepositoryFacade>()) {
      getIt.registerSingleton<KitchenOrdersRepositoryFacade>(
        AppConstants.isDemo
            ? DemoKitchenOrdersRepository()
            : KitchenOrdersRepository(),
      );
    }
  }
}

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

import 'package:base_sdk/src/constants/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/manager/infrastructure/repositories/demo_seller_statistics_repository.dart';
import 'package:revenue_sdk/src/manager/infrastructure/repositories/seller_statistics_repository.dart';

/// Manager-role DI hook. Not exported by the barrel and not called by the
/// generated `main.dart` — the common `RevenueSdkDependencies.register` cannot
/// import this file because a driver app's cache has `lib/src/manager/`
/// stripped. A manager host calls this from its own DI setup, importing it via
/// this direct `src/` path, before the installed income page first builds
/// `statisticsProvider` (which resolves the facade from GetIt). Registers
/// idempotently so hand-wired hosts can call it too.
class ManagerRevenueDependencies {
  static void register(GetIt getIt) {
    // Demo mode (--dart-define=IS_DEMO=true) swaps the HTTP facade for its
    // Demo* twin serving fictional store revenue offline — the same isDemo
    // split delivery_sdk's DriverDeliveryDependencies applies to every
    // courier facade. Zero behavior change when IS_DEMO is off.
    if (!getIt.isRegistered<SellerStatisticsRepositoryFacade>()) {
      getIt.registerSingleton<SellerStatisticsRepositoryFacade>(
        AppConstants.isDemo
            ? DemoSellerStatisticsRepository()
            : SellerStatisticsRepository(),
      );
    }
  }
}

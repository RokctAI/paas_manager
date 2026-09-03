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
import 'package:revenue_sdk/src/common/domain/interface/deposit_approval.dart';
import 'package:revenue_sdk/src/common/domain/interface/driver_payout.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/common/infrastructure/repositories/deposit_approval_repository.dart';
import 'package:revenue_sdk/src/common/infrastructure/repositories/driver_payout_repository.dart';
import 'package:revenue_sdk/src/manager/infrastructure/repositories/demo_seller_statistics_repository.dart';
import 'package:revenue_sdk/src/manager/infrastructure/repositories/seller_statistics_repository.dart';

/// Manager-role DI hook. Not exported by the barrel — the common
/// `RevenueSdkDependencies.register` cannot import this file because a driver
/// app's cache has `lib/src/manager/` stripped. The manifest's
/// app_type.manager `di_hooks` entry (`revenue-manager-role-di`) injects the
/// call into the generated `main.dart` via this direct `src/` path, mirroring
/// the driver side's `revenue-driver-role-di`, so the facade is registered
/// before the installed income page first builds `statisticsProvider` /
/// `profitDashboardProvider` (both resolve it from GetIt). A host mid
/// migration may still call it from its own DI setup too; registers
/// idempotently so both call sites can coexist.
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
    // Design strip frame 49l (approved 2026-08-31): the manager hub's
    // Withdraw. `managerWalletProvider`, and the bank-details / payout-trail
    // slices it opens, resolve the payout seam from GetIt exactly as the
    // driver's do. The concrete repository is the same class the driver
    // registers — wallet's `api.payout.*` is USER-scoped and serves any
    // signed-in user — so a manager host gets it here, and a host that
    // composes both roles double-boots safely on the guard.
    if (!getIt.isRegistered<DriverPayoutRepositoryFacade>()) {
      getIt.registerSingleton<DriverPayoutRepositoryFacade>(
        DriverPayoutRepository(),
      );
    }
    // Design strip frame 49i, manager side: the deposit approval queue the
    // manager hub's wallet pane opens (`depositApprovalsProvider` resolves
    // this seam). Manager-only by design — the server gates approve/reject
    // by role, and no driver surface draws the queue — so it is registered
    // here and not by the driver hook.
    if (!getIt.isRegistered<DepositApprovalRepositoryFacade>()) {
      getIt.registerSingleton<DepositApprovalRepositoryFacade>(
        DepositApprovalRepository(),
      );
    }
  }
}

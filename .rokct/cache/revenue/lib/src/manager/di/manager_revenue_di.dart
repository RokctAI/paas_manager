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

import 'package:base_sdk/src/services/demo_session.dart';
import 'package:flutter/foundation.dart';
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
///
/// The statistics facade has a Demo* twin serving fictional store revenue
/// offline. Which of the two is registered follows base's
/// [DemoSession.demoActive]: a demo BUILD (`--dart-define=IS_DEMO=true`,
/// the tour and the store screenshots) or a demo SESSION (a server-marked
/// account signed in on the production backend). The build half is a
/// compile-time constant and answers at [register]; the session half flips
/// at runtime - after login, before routing, and back on sign-out - so the
/// hook also subscribes ONCE to [DemoSession.instance] and swaps the
/// registration in place on every flip. Zero behavior change for a real
/// account in a production build.
class ManagerRevenueDependencies {
  static VoidCallback? _demoSessionListener;

  static void register(GetIt getIt) {
    if (!getIt.isRegistered<SellerStatisticsRepositoryFacade>()) {
      getIt.registerSingleton<SellerStatisticsRepositoryFacade>(
        _sellerStatistics(),
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
    _listenToDemoSession(getIt);
  }

  /// The facade for the demo switch's CURRENT position. Read at every
  /// (re-)registration rather than captured, so a flip never serves a
  /// twin picked at boot.
  static SellerStatisticsRepositoryFacade _sellerStatistics() =>
      DemoSession.demoActive
          ? DemoSellerStatisticsRepository()
          : SellerStatisticsRepository();

  /// One listener for the life of the process, whichever call site
  /// registered first; a host that also calls [register] by hand during
  /// its migration window does not subscribe twice.
  static void _listenToDemoSession(GetIt getIt) {
    if (_demoSessionListener != null) return;
    final listener = () => _swapDemoTwins(getIt);
    _demoSessionListener = listener;
    DemoSession.instance.addListener(listener);
  }

  /// Re-registers the facades that have a demo twin for the switch's new
  /// position. The payout and deposit-approval seams are the same class on
  /// both sides and stay as they are. Guarded so it cannot throw:
  /// unregister only what is registered, then register fresh.
  static void _swapDemoTwins(GetIt getIt) {
    if (getIt.isRegistered<SellerStatisticsRepositoryFacade>()) {
      getIt.unregister<SellerStatisticsRepositoryFacade>();
    }
    getIt.registerSingleton<SellerStatisticsRepositoryFacade>(
      _sellerStatistics(),
    );
  }

  /// Drops the process-wide subscription so a test that resets GetIt
  /// between cases does not carry a listener bound to the previous case's
  /// registrations. The app never calls this.
  @visibleForTesting
  static void resetDemoSessionListener() {
    final listener = _demoSessionListener;
    if (listener == null) return;
    DemoSession.instance.removeListener(listener);
    _demoSessionListener = null;
  }
}

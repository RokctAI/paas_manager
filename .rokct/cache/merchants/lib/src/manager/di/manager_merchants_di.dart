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

import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:base_sdk/base_sdk.dart' show DemoFixtures;
import 'package:merchants_sdk/src/common/di/merchants_di.dart'
    show merchantsDemoFixtureDirectory;
import 'package:base_sdk/src/services/demo_session.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/sync/sync_engine.dart';
import 'package:merchants_sdk/src/manager/infrastructure/demo_currency.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_catalog.dart';
import 'package:merchants_sdk/src/manager/domain/interface/quick_flow.dart';
import 'package:merchants_sdk/src/manager/domain/interface/seller_sections_tables.dart';
import 'package:merchants_sdk/src/manager/domain/interface/seller_shop.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/pos_catalog_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/quick_flow_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/seller_sections_tables_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/seller_shop_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/services/shop_create_sync_handler.dart';
import 'package:merchants_sdk/src/manager/infrastructure/services/sync_issues_service.dart';

/// Manager-role DI hook (orders_sdk `ManagerOrdersDependencies` /
/// revenue_sdk `ManagerRevenueDependencies` pattern).
///
/// Not exported by the barrel and not called by the generated `main.dart` —
/// the common `MerchantsSdkDependencies.register` cannot import this file
/// because a customer app's cache has `lib/src/manager/` stripped. A manager
/// host calls this from its own DI setup via this direct `src/` path, before
/// any installed restaurant page first builds a provider. Registers
/// idempotently so hand-wired hosts can call it too.
///
/// [SellerSectionsTablesRepositoryFacade] is also the data source the host's
/// installed `orders_adapters.dart` (`ManagerPosSectionsTablesAdapter`,
/// ADR-005) should delegate to once it swaps off its transitional direct
/// endpoint calls — register this before that adapter.
///
/// Demo runs the REAL repositories: base_sdk's DemoGatewayInterceptor
/// answers their cmds from the fixtures in [merchantsDemoFixtureDirectory]
/// (and, for the POS catalog, which delegates to products_sdk, from
/// products_sdk's) while DemoSession.demoActive. The one piece of demo
/// switch code left here is the rand seed, see [_seedDemoCurrency].
class ManagerMerchantsDependencies {
  /// Guards the demo-session listener against being added twice.
  static bool _listening = false;

  static void register(GetIt getIt) {
    DemoFixtures.registerAssetDirectory(merchantsDemoFixtureDirectory);
    _put<SellerShopRepositoryFacade>(getIt, SellerShopRepository.new);
    // The POS till's product-lookup seam (BillingPage barcode scans and the
    // Add Items lane) delegates to the composed app's products_sdk
    // facades, resolved lazily per call.
    _put<PosCatalogRepositoryFacade>(getIt, PosCatalogRepository.new);
    // Quick flow settings (design strip section 42), read by both the
    // Quick flow page and the till's keypad.
    _put<QuickFlowRepositoryFacade>(getIt, QuickFlowRepository.new);
    _seedDemoCurrency();
    if (!getIt.isRegistered<SellerSectionsTablesRepositoryFacade>()) {
      getIt.registerSingleton<SellerSectionsTablesRepositoryFacade>(
        SellerSectionsTablesRepository(),
      );
    }
    // Attach the shop.create push handler so offline shop creates drain to
    // the backend (auth_di's AuthSyncHandler pattern). Registered here rather
    // than in the common MerchantsSdkDependencies because a customer app's
    // cache has lib/src/manager/ stripped, so the common hook cannot import
    // this slice. BaseSdkDependencies.register puts the engine in get_it
    // before feature SDKs run; the process-singleton fallback keeps
    // hand-wired hosts that skipped it working. registerHandler replaces any
    // previous handler, so this is idempotent too. Requires
    // base_sdk >= 1.5.0 (SyncEngine/SyncHandler).
    final engine = getIt.isRegistered<SyncEngine>()
        ? getIt<SyncEngine>()
        : SyncEngine();
    engine.registerHandler(
      ShopCreateSyncHandler.opType,
      ShopCreateSyncHandler(),
    );
    // Park-and-surface read API over the three manager local-first boxes.
    if (!getIt.isRegistered<SyncIssuesService>()) {
      getIt.registerLazySingleton<SyncIssuesService>(SyncIssuesService.new);
    }
    if (!_listening) {
      _listening = true;
      DemoSession.instance.addListener(_seedDemoCurrency);
    }
  }

  /// The till's money strings (the "Cart is empty" summary's R0.00, the
  /// line cards, Continue) go through AppHelpers.numberFormat, which reads
  /// LocalStorage's selected currency. Nothing in a composed manager app
  /// seeds one in demo (no manager shell calls
  /// CurrencyNotifier.fetchCurrency), so the till printed intl's locale
  /// fallback ("0.00USD") while every seller fixture trades in rand. Seed
  /// that rand in a demo session, and only where nothing is selected, so a
  /// real currency - or a test harness's own seed - is never overwritten.
  /// Runs at registration and again when a demo session begins later.
  static void _seedDemoCurrency() {
    if (DemoSession.demoActive && LocalStorage.getSelectedCurrency() == null) {
      unawaited(LocalStorage.setSelectedCurrency(demoCurrency));
    }
  }

  /// An existing registration (a host's own) wins.
  static void _put<T extends Object>(GetIt getIt, T Function() build) {
    if (!getIt.isRegistered<T>()) getIt.registerSingleton<T>(build());
  }
}

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
import 'package:base_sdk/src/services/demo_session.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/sync/sync_engine.dart';
import 'package:merchants_sdk/src/manager/infrastructure/demo_currency.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_catalog.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_orders.dart';
import 'package:merchants_sdk/src/manager/domain/interface/quick_flow.dart';
import 'package:merchants_sdk/src/manager/domain/interface/seller_sections_tables.dart';
import 'package:merchants_sdk/src/manager/domain/interface/seller_shop.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/demo_seller_shop_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/mock_pos_orders_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/mock_products_repository.dart';
import 'package:merchants_sdk/src/manager/infrastructure/repositories/mock_quick_flow_repository.dart';
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
/// The demo twins follow the RUNTIME demo switch, base_sdk's
/// [DemoSession.demoActive] (a demo build OR a demo session): chosen by
/// that read at registration, and swapped by the one listener this hook
/// adds to [DemoSession.instance] when the switch flips - after a demo
/// account's login, before routing, and back on sign-out. Only
/// registrations this hook made are ever swapped; a facade a host
/// registered itself is left alone - with the one exception of
/// [PosOrdersFacade], see [_registerPosOrders].
class ManagerMerchantsDependencies {
  /// The container the last [register] call wired; the listener re-wires
  /// the same one. Null until the first call, so a flip that lands before
  /// any registration is a no-op and the registration then reads the
  /// switch itself.
  static GetIt? _container;

  /// Guards the listener against being added twice.
  static bool _listening = false;

  /// The instances this hook registered (weak), so a flip replaces exactly
  /// those and never a host's own registration.
  static final Expando<bool> _ours = Expando<bool>();

  /// The host's own [PosOrdersFacade] a demo session displaced, put back
  /// when the session ends. Null while nothing is displaced.
  static PosOrdersFacade? _displacedPosOrders;

  static void register(GetIt getIt) {
    _container = getIt;
    _registerDemoTwins(getIt, replace: false);
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
      DemoSession.instance.addListener(_onDemoSessionChanged);
    }
  }

  /// Every seam with a demo twin, plus the demo currency seed. `replace`
  /// is false at boot (an existing registration wins, as before) and true
  /// on a flip. Nothing here can throw: unregister runs only behind
  /// `isRegistered`, and a fresh registration never collides.
  static void _registerDemoTwins(GetIt getIt, {required bool replace}) {
    final bool demo = DemoSession.demoActive;
    // The manager's own shop identity (restaurant hub header, shop-edit
    // flow, open/closed switch). Demo-gated like the POS seams below: a
    // demo build or a demo session serves MockShopsRepository's demoShop --
    // the SAME shop the customer-facing ShopsRepositoryFacade serves in
    // demo, not a second invention -- so the hub renders with a shop
    // instead of a blank header, with zero backend contact.
    _put<SellerShopRepositoryFacade>(
      getIt,
      () => demo ? DemoSellerShopRepository() : SellerShopRepository(),
      replace: replace,
    );
    // The POS till's product-lookup seam (BillingPage barcode scans and
    // the Add Items lane). Demo-gated like MerchantsSdkDependencies'
    // ShopsRepositoryFacade: demo routes lookups to this SDK's
    // MockProductsRepository ("Flame-grilled beef burger", 150.00) so
    // headless tours and the standalone POS test harness run with zero
    // backend contact; otherwise the real repository delegates to the
    // composed app's ProductsRepositoryFacade (products_sdk's, resolved
    // lazily per call).
    _put<PosCatalogRepositoryFacade>(
      getIt,
      () => demo ? MockProductsRepository() : PosCatalogRepository(),
      replace: replace,
    );
    _registerPosOrders(getIt, demo: demo, replace: replace);
    // The till's money strings (the "Cart is empty" summary's R0.00, the
    // line cards, Continue) go through AppHelpers.numberFormat, which reads
    // LocalStorage's selected currency. Nothing in a composed manager app
    // seeds one in demo: comms_sdk registers the real CurrenciesRepository
    // regardless of the switch and no manager shell calls
    // CurrencyNotifier.fetchCurrency, so the till printed intl's locale
    // fallback ("0.00USD" - the ISO code as a suffix) while every other
    // seller fixture trades in rand (orders_sdk's DemoSellerOrdersRepository,
    // this SDK's R150.00 catalog line). Seed that rand once, and only where
    // nothing is selected, so a real currency - or a test harness's own seed
    // - is never overwritten. The generated main.dart awaits
    // LocalStorage.init() before any *Dependencies.register call, and
    // SharedPreferences writes its in-memory cache synchronously, so the
    // first numberFormat call already reads it; nothing here awaits. A
    // demo session that begins later seeds the same way.
    if (demo && LocalStorage.getSelectedCurrency() == null) {
      unawaited(LocalStorage.setSelectedCurrency(demoCurrency));
    }
    // Quick flow settings (design strip section 42): the shop's three
    // order-automation switches and the till keypad's digit->product map,
    // read by BOTH the Quick flow page and the till (the pad arms off the
    // same provider). Demo-gated like the catalog seam: demo serves the
    // section-42 seed shop from memory so headless tours and the standalone
    // harness drive the whole surface, and the till's autodial, with zero
    // backend contact.
    _put<QuickFlowRepositoryFacade>(
      getIt,
      () => demo ? MockQuickFlowRepository() : QuickFlowRepository(),
      replace: replace,
    );
  }

  /// The POS checkout's order seam (customer attach, credit outstanding,
  /// and the cart -> create-order handoff into the seller pipeline).
  /// Demo gets this SDK's mock so tours, the standalone harness and a
  /// demo session run the full checkout with zero backend contact. REAL
  /// registration is the HOST's: the installed ManagerPosOrdersAdapter
  /// (templates/adapters/manager/pos_orders_adapter.dart) delegates to
  /// orders_sdk, which this lib must not import (ADR-005). Unregistered,
  /// the checkout degrades honestly — no customer/credit surface, sales
  /// complete locally only.
  ///
  /// Because the real side is the host's, this seam is the one where a
  /// FLIP (`replace`) touches a registration this hook did not make: a
  /// demo session beginning in a wired host displaces the host's adapter
  /// with the mock (the session must not create real orders), remembers
  /// it, and puts it back when the session ends; a demo session ending in
  /// an unwired host simply drops the mock. At boot (`replace` false) an
  /// existing registration wins, as before.
  static void _registerPosOrders(
    GetIt getIt, {
    required bool demo,
    required bool replace,
  }) {
    final bool registered = getIt.isRegistered<PosOrdersFacade>();
    if (demo) {
      if (registered) {
        if (!replace) return;
        final PosOrdersFacade current = getIt<PosOrdersFacade>();
        if (current is MockPosOrdersRepository) return;
        _displacedPosOrders = current;
        getIt.unregister<PosOrdersFacade>();
      }
      getIt.registerSingleton<PosOrdersFacade>(MockPosOrdersRepository());
      return;
    }
    if (registered && getIt<PosOrdersFacade>() is MockPosOrdersRepository) {
      getIt.unregister<PosOrdersFacade>();
      final PosOrdersFacade? displaced = _displacedPosOrders;
      _displacedPosOrders = null;
      if (displaced != null) {
        getIt.registerSingleton<PosOrdersFacade>(displaced);
      }
    }
  }

  static void _put<T extends Object>(
    GetIt getIt,
    T Function() build, {
    required bool replace,
  }) {
    if (getIt.isRegistered<T>()) {
      if (!replace || _ours[getIt<T>()] != true) return;
      getIt.unregister<T>();
    }
    final T instance = build();
    _ours[instance] = true;
    getIt.registerSingleton<T>(instance);
  }

  static void _onDemoSessionChanged() {
    final GetIt? getIt = _container;
    if (getIt == null) return;
    _registerDemoTwins(getIt, replace: true);
  }
}

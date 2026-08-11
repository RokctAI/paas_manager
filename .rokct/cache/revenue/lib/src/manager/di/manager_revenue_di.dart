import 'package:get_it/get_it.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
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
    if (!getIt.isRegistered<SellerStatisticsRepositoryFacade>()) {
      getIt.registerSingleton<SellerStatisticsRepositoryFacade>(
        SellerStatisticsRepository(),
      );
    }
  }
}

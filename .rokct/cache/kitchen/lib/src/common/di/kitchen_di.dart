import 'package:get_it/get_it.dart';
import 'package:kitchen_sdk/src/common/domain/interface/kitchens.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/repositories/kitchens_repository.dart';

/// Installer-convention DI hook: the composed app's generated `main.dart` calls
/// `KitchenSdkDependencies.register(GetIt.instance)` for every installed SDK.
/// Registers idempotently so hand-wired hosts can call it too.
class KitchenSdkDependencies {
  static void register(GetIt getIt) {
    if (!getIt.isRegistered<KitchensRepositoryFacade>()) {
      getIt.registerSingleton<KitchensRepositoryFacade>(KitchensRepository());
    }
  }
}

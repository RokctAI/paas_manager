import 'package:get_it/get_it.dart';
import 'package:base_sdk/base_sdk.dart';
import '../domain/interface/recovery_repository_facade.dart';
import '../infrastructure/repositories/recovery_repository_impl.dart';

class ProductivitySdkDependencies {
  static void register(GetIt getIt) {
    // Register Recovery Repository
    getIt.registerLazySingleton<RecoveryRepositoryFacade>(
      () => RecoveryRepositoryImpl(getIt<AppDatabase>()),
    );
  }
}

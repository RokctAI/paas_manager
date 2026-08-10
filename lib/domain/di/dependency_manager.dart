// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:get_it/get_it.dart';
import 'package:google_place/google_place.dart';
import 'package:venderfoodyman/domain/interface/notification.dart';
import 'package:venderfoodyman/domain/interface/table.dart';
import 'package:venderfoodyman/infrastructure/services/local_storage.dart';
import 'package:venderfoodyman/domain/handlers/handlers.dart';
import '../interface/interfaces.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/infrastructure/repositories/repositories.dart';

final GetIt getIt = GetIt.instance;

Future setUpDependencies() async {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerSingleton<Map>(LocalStorage.getTranslations());
  getIt.registerSingleton<AuthInterface>(AuthRepository());
  getIt.registerSingleton<TableInterface>(TableRepository());
  getIt.registerSingleton<UsersInterface>(UsersRepository());
  getIt.registerSingleton<ShopsInterface>(ShopsRepository());
  getIt.registerSingleton<OrdersInterface>(OrdersRepository());
  getIt.registerSingleton<CatalogInterface>(CatalogRepository());
  getIt.registerSingleton<SettingsInterface>(SettingsRepository());
  getIt.registerSingleton<ProductsInterface>(ProductsRepository());
  getIt.registerSingleton<NotificationInterface>(NotificationRepository());

}

final translation = getIt.get<Map>();
final dioHttp = getIt.get<HttpService>();
final appRouter = getIt.get<AppRouter>();
final googlePlace = getIt.get<GooglePlace>();
final authRepository = getIt.get<AuthInterface>();
final shopsRepository = getIt.get<ShopsInterface>();
final tableRepository = getIt.get<TableInterface>();
final usersRepository = getIt.get<UsersInterface>();
final ordersRepository = getIt.get<OrdersInterface>();
final catalogRepository = getIt.get<CatalogInterface>();
final productRepository = getIt.get<ProductsInterface>();
final settingsRepository = getIt.get<SettingsInterface>();
final notificationRepository = getIt.get<NotificationInterface>();


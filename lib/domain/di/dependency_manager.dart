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

// Shrunken to the single seam that still needs a host-owned repository
// (migration stage M2): zones_sdk's installed manager adapter
// (lib/presentation/routes/zones_adapters.dart) resolves the shop's
// delivery-zone polygon through `di.usersRepository`. Everything else the
// old setUpDependencies() registered is SDK-owned now (base_sdk registers
// HttpService and the translations Map; each vertical SDK registers its own
// repositories in the @generated-sdk-di block).
//
// This file dies entirely once zones_sdk's adapter template is rewritten
// against a users_sdk delivery-zone repository (zones repo follow-up), or
// once the registration moves to a `di_hooks` manifest declaration
// (The-Rokct-Protocol#160) - see scratchpad/di-hooks-declarations.md.
import 'package:get_it/get_it.dart';
import 'package:manager/domain/interface/users.dart';
import 'package:manager/infrastructure/repositories/users_repository.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  if (!getIt.isRegistered<UsersInterface>()) {
    getIt.registerSingleton<UsersInterface>(UsersRepository());
  }
}

final usersRepository = getIt.get<UsersInterface>();

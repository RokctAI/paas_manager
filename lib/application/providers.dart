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

// Host-owned providers only - the feature verticals (orders/POS, foods,
// restaurant, income, delivery zone) migrated into their SDKs; their
// providers now come from orders_sdk/products_sdk/merchants_sdk/revenue_sdk/
// zones_sdk (see composer.json).
export 'splash/splash_provider.dart';
export 'profile/profile_provider.dart';
export 'auth/login/login_provider.dart';
export 'auth/sign_up/sign_up_provider.dart';
export 'auth/reset_password/reset_password_provider.dart';
export 'auth/login/languages/languages_provider.dart';
export 'auth/confirmation/register_confirmation_provider.dart';

// restaurantProvider moved to merchants_sdk's manager slice (commerce#3).
// Re-exported here so the host splash/login flows keep reading
// `restaurantProvider` unchanged (fetchMyShop(afterFetched:) signature is
// preserved by the SDK port).
export 'package:merchants_sdk/src/manager/application/restaurant/restaurant_provider.dart';

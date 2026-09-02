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

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'package:base_sdk/src/constants/app_constants.dart';
import 'package:base_sdk/src/presentation/pages/profile/profile_section.dart';
import 'package:base_sdk/src/presentation/pages/profile/profile_section_registry.dart';
import 'package:booking_sdk/src/manager/domain/interface/seller_booking.dart';
import 'package:booking_sdk/src/manager/infrastructure/repositories/demo_seller_booking_repository.dart';
import 'package:booking_sdk/src/manager/infrastructure/repositories/seller_booking_repository.dart';
import 'package:booking_sdk/src/manager/presentation/booking_manager_hub_section.dart';

/// Manager / POS role DI hook (orders_sdk's `ManagerOrdersDependencies`
/// pattern). Not exported by the barrel and not called by the generated
/// `main.dart`: the manager block's `booking-manager-role-di` di_hook
/// calls it (POS shells compose the manager persona), importing this file
/// by its direct `src/` path, so a customer cache (lib/src/manager/
/// stripped) never references it.
///
/// Besides the seller seam it registers the RESERVATIONS group into
/// base_sdk's [ProfileSectionRegistry] at order 135 - between merchants'
/// wallet group (130) and its sections list (140) - which is how the
/// manager profile host reaches the three routes without merchants_sdk
/// changing.
class ManagerBookingDependencies {
  static const String hubSectionId = 'booking.reservations';
  static const int hubSectionOrder = 135;

  static void register(GetIt getIt) {
    if (!getIt.isRegistered<SellerBookingRepositoryFacade>()) {
      getIt.registerSingleton<SellerBookingRepositoryFacade>(
        AppConstants.isDemo
            ? DemoSellerBookingRepository()
            : SellerBookingRepository(),
      );
    }
    registerBookingManagerHubSection();
  }

  /// Idempotent: the registry keeps the first registration of an id.
  static void registerBookingManagerHubSection() {
    final registry = ProfileSectionRegistry.I;
    if (registry.contains(hubSectionId)) return;
    registry.register(ProfileSection(
      id: hubSectionId,
      order: hubSectionOrder,
      builder: (BuildContext context) => const BookingManagerHubSection(),
    ));
  }
}

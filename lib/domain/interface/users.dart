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

// Shrunken to the delivery-zone surface consumed by zones_sdk's installed
// manager adapter (see domain/di/dependency_manager.dart for the exit plan).
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:manager/infrastructure/models/response/delivery_zone_paginate.dart';

abstract class UsersInterface {
  Future<ApiResult<void>> updateDeliveryZones({
    required List<LatLng> points,
  });

  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone();
}

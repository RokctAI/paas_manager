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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'delivery_zone_state.freezed.dart';

@freezed
class DeliveryZoneState with _$DeliveryZoneState {
  const factory DeliveryZoneState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default([]) List<List<double>> deliveryZones,
    @Default([]) List<LatLng> tappedPoints,
    @Default({}) Set<Polygon> polygon,
  }) = _DeliveryZoneState;

  const DeliveryZoneState._();
}

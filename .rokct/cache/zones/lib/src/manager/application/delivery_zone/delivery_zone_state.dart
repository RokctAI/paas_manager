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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'delivery_zone_state.freezed.dart';

@freezed
abstract class DeliveryZoneState with _$DeliveryZoneState {
  const factory DeliveryZoneState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default([]) List<List<double>> deliveryZones,
    @Default([]) List<LatLng> tappedPoints,
    @Default({}) Set<Polygon> polygon,

    /// Undo stack for vertex edits (section 39's approved correction
    /// affordances, chips 737/742): every add/move pushes the PREVIOUS
    /// [tappedPoints] snapshot here, undo pops the newest snapshot back.
    /// Cleared on fetch and on a successful save, so an empty stack means
    /// "what the map shows is what the server holds".
    @Default([]) List<List<LatLng>> pointsHistory,
  }) = _DeliveryZoneState;

  const DeliveryZoneState._();

  /// Whether there is a vertex edit to undo.
  bool get canUndo => pointsHistory.isNotEmpty;

  /// The shipped Save gate: a zone is a closed, saveable shape only once
  /// it has more than three vertices.
  bool get isShapeClosed => tappedPoints.length > 3;

  /// True while the drawn shape has edits the server has not seen — the
  /// panel's Drawing state. An untouched fetched zone (or a fresh save)
  /// reads as Saved.
  bool get isDirty => pointsHistory.isNotEmpty;
}

// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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

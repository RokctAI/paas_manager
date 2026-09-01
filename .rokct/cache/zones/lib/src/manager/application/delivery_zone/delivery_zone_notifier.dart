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

import 'package:base_sdk/src/handlers/api_result.dart';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';

import 'package:zones_sdk/src/manager/application/delivery_zone/delivery_zone_state.dart';
import 'package:zones_sdk/src/common/domain/interface/delivery_zones.dart';

/// Manager flavour of the zone editor: a merchant drawing their own shop's
/// delivery catchment.
///
/// Ported from paas_manager's `application/restaurant/delivery_zone/`
/// (2026-08 refork) and rewired from the app's `UsersInterface` onto the
/// common [DeliveryZonesFacade] seam — the host app's adapter decides which
/// repository actually persists the shop polygon (legacy Laravel:
/// `/api/v1/dashboard/seller/delivery-zones`, shop-scoped).
///
/// Unlike the driver notifier there is no `canEdit` policy hook here, on
/// purpose: [ZoneEditPolicy]'s own contract doc records that a merchant
/// editing their own shop's catchment has no equivalent of the driver's
/// `driver_can_edit_credentials` restriction. Adding the hook "for symmetry"
/// would hand the flavour a gate keyed on a concept that means nothing to it.
class DeliveryZoneNotifier extends StateNotifier<DeliveryZoneState> {
  final DeliveryZonesFacade _zones;

  DeliveryZoneNotifier(this._zones) : super(const DeliveryZoneState());

  /// The drawn polygon, styled the same whether it came from the server or
  /// from taps. Kept private so both paths cannot drift apart visually.
  ///
  /// A CLOSED shape (more than three vertices — the Save gate) wears the
  /// shipped styling verbatim: primary fill at 0.30, primary stroke 4. An
  /// OPEN shape (section 39b, chip 741) keeps only a faint fill and no
  /// stroke — the page draws the tapped edges solid and the closing edge
  /// dashed itself, so the polygon's self-closing edge must not paint a
  /// solid line underneath the dash.
  Set<Polygon> _polygonFor(List<LatLng> points) {
    final Set<Polygon> polygon = HashSet<Polygon>();
    if (points.isEmpty) return polygon;
    final bool closed = points.length > 3;
    polygon.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: AppStyle.primary.withValues(alpha: closed ? 0.3 : 0.15),
        strokeColor: closed ? AppStyle.primary : AppStyle.transparent,
        geodesic: false,
        strokeWidth: closed ? 4 : 0,
      ),
    );
    return polygon;
  }

  Future<void> updateDeliveryZone({VoidCallback? updateSuccess}) async {
    state = state.copyWith(isSaving: true);
    final response = await _zones.updateDeliveryZones(
      points: state.tappedPoints
          .map((p) => <double>[p.latitude, p.longitude])
          .toList(),
    );
    response.when(
      success: (data) {
        // The saved shape IS the drawn shape now — clearing the undo stack
        // flips the panel back to Saved without touching the vertices.
        state = state.copyWith(isSaving: false, pointsHistory: []);
        updateSuccess?.call();
      },
      failure: (fail, status) {
        state = state.copyWith(isSaving: false);
        debugPrint('===> update delivery zone failed $fail');
      },
    );
  }

  /// Applies a vertex edit: snapshots the current ring onto the undo stack,
  /// then swaps in [points]. Every mutation goes through here so add, drag
  /// and undo can never disagree about what one undo step is.
  void _applyPoints(List<LatLng> points) {
    state = state.copyWith(
      tappedPoints: points,
      polygon: _polygonFor(points),
      pointsHistory: [...state.pointsHistory, state.tappedPoints],
    );
  }

  void addTappedPoint(LatLng point) {
    _applyPoints(List.from(state.tappedPoints)..add(point));
  }

  /// Drags an existing vertex to [position] (chip 737's grab affordance).
  /// Out-of-range indices are ignored — a drag callback racing a concurrent
  /// undo must not throw.
  void moveTappedPoint(int index, LatLng position) {
    if (index < 0 || index >= state.tappedPoints.length) return;
    final List<LatLng> points = List.from(state.tappedPoints);
    points[index] = position;
    _applyPoints(points);
  }

  /// Undoes the newest vertex edit (chip 742) — pops the latest snapshot
  /// off the stack. No-op when there is nothing to undo.
  void undoLastPoint() {
    if (state.pointsHistory.isEmpty) return;
    final points = state.pointsHistory.last;
    state = state.copyWith(
      tappedPoints: points,
      polygon: _polygonFor(points),
      pointsHistory: state.pointsHistory.sublist(
        0,
        state.pointsHistory.length - 1,
      ),
    );
  }

  Future<void> fetchDeliveryZone() async {
    state = state.copyWith(
      isLoading: true,
      tappedPoints: [],
      pointsHistory: [],
    );
    final response = await _zones.fetchDeliveryZones();
    response.when(
      success: (addresses) {
        if (addresses.isNotEmpty) {
          final points = addresses
              .where((a) => a.length >= 2)
              .map((a) => LatLng(a[0], a[1]))
              .toList();
          // The saved ring is seeded as the editable ring (section 39a's
          // approved reading: "tap the map to add a point; new points
          // EXTEND the shape") — so a fetched zone can be extended and its
          // vertices dragged, instead of the first tap starting over.
          state = state.copyWith(
            deliveryZones: addresses,
            tappedPoints: points,
            polygon: _polygonFor(points),
          );
        }
        state = state.copyWith(isLoading: false);
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> error with fetching delivery zone $failure');
      },
    );
  }
}

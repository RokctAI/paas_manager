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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:booking_sdk/src/common/infrastructure/models/booking_models.dart';
import 'package:booking_sdk/src/manager/domain/interface/seller_booking.dart';
import 'package:booking_sdk/src/manager/utils/seller_shop_id.dart';

/// The shop's reservation list with status changes - paas_pos's
/// TablesNotifier.fetchBookings / changeStatus, against the SDK seam.
class ShopReservationsState {
  final bool isLoading;
  final List<ReservationData> reservations;

  /// null = all.
  final ReservationStatus? filter;
  final String? updatingId;
  final String? error;
  final bool noShop;

  const ShopReservationsState({
    this.isLoading = false,
    this.reservations = const [],
    this.filter,
    this.updatingId,
    this.error,
    this.noShop = false,
  });

  List<ReservationData> get visible => [
        for (final r in reservations)
          if (filter == null || r.status == filter) r,
      ];

  int countOf(ReservationStatus? status) => status == null
      ? reservations.length
      : reservations.where((r) => r.status == status).length;

  ShopReservationsState copyWith({
    bool? isLoading,
    List<ReservationData>? reservations,
    ReservationStatus? filter,
    bool clearFilter = false,
    String? updatingId,
    bool clearUpdating = false,
    String? error,
    bool clearError = false,
    bool? noShop,
  }) =>
      ShopReservationsState(
        isLoading: isLoading ?? this.isLoading,
        reservations: reservations ?? this.reservations,
        filter: clearFilter ? null : (filter ?? this.filter),
        updatingId: clearUpdating ? null : (updatingId ?? this.updatingId),
        error: clearError ? null : (error ?? this.error),
        noShop: noShop ?? this.noShop,
      );
}

class ShopReservationsNotifier extends StateNotifier<ShopReservationsState> {
  final SellerBookingRepositoryFacade _repo;

  ShopReservationsNotifier(this._repo) : super(const ShopReservationsState());

  Future<void> fetch() async {
    final shopId = sellerShopId();
    if (shopId == null) {
      state = state.copyWith(noShop: true, isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true, noShop: false);
    // Always the full list: the filter tabs count every status locally.
    final result = await _repo.getShopReservations(shopId);
    if (!mounted) return;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(isLoading: false, reservations: data);
      case Failure(:final error):
        state = state.copyWith(isLoading: false, error: error);
    }
  }

  void setFilter(ReservationStatus? status) => state = status == null
      ? state.copyWith(clearFilter: true)
      : state.copyWith(filter: status);

  /// Returns the failure message, or null.
  Future<String?> setStatus(String id, ReservationStatus status) async {
    state = state.copyWith(updatingId: id, clearError: true);
    final result = await _repo.updateReservationStatus(id, status);
    if (!mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          clearUpdating: true,
          reservations: [
            for (final r in state.reservations)
              if (r.id == id) r.copyWith(status: data.status) else r,
          ],
        );
        return null;
      case Failure(:final error):
        state = state.copyWith(clearUpdating: true, error: error);
        return error;
    }
  }
}

final shopReservationsProvider = StateNotifierProvider.autoDispose<
    ShopReservationsNotifier, ShopReservationsState>(
  (ref) => ShopReservationsNotifier(
      GetIt.instance<SellerBookingRepositoryFacade>()),
);

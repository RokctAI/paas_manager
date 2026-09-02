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

/// Section + table CRUD for the seller's shop.
class ReservationTablesState {
  final bool isLoading;
  final bool loadingTables;
  final bool busy;
  final List<BookingSection> sections;
  final BookingSection? section;
  final List<BookingTable> tables;
  final String? error;
  final bool noShop;

  const ReservationTablesState({
    this.isLoading = false,
    this.loadingTables = false,
    this.busy = false,
    this.sections = const [],
    this.section,
    this.tables = const [],
    this.error,
    this.noShop = false,
  });

  ReservationTablesState copyWith({
    bool? isLoading,
    bool? loadingTables,
    bool? busy,
    List<BookingSection>? sections,
    BookingSection? section,
    bool clearSection = false,
    List<BookingTable>? tables,
    String? error,
    bool clearError = false,
    bool? noShop,
  }) =>
      ReservationTablesState(
        isLoading: isLoading ?? this.isLoading,
        loadingTables: loadingTables ?? this.loadingTables,
        busy: busy ?? this.busy,
        sections: sections ?? this.sections,
        section: clearSection ? null : (section ?? this.section),
        tables: tables ?? this.tables,
        error: clearError ? null : (error ?? this.error),
        noShop: noShop ?? this.noShop,
      );
}

class ReservationTablesNotifier extends StateNotifier<ReservationTablesState> {
  final SellerBookingRepositoryFacade _repo;

  ReservationTablesNotifier(this._repo)
      : super(const ReservationTablesState());

  Future<void> fetch() async {
    final shopId = sellerShopId();
    if (shopId == null) {
      state = state.copyWith(noShop: true, isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true, noShop: false);
    final result = await _repo.getShopSections(shopId);
    if (!mounted) return;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(isLoading: false, sections: data);
        final keep = state.section;
        final still = keep == null
            ? null
            : data.where((s) => s.id == keep.id).firstOrNull;
        if (still != null) {
          await selectSection(still);
        } else if (data.isNotEmpty) {
          await selectSection(data.first);
        } else {
          state = state.copyWith(clearSection: true, tables: const []);
        }
      case Failure(:final error):
        state = state.copyWith(isLoading: false, error: error);
    }
  }

  Future<void> selectSection(BookingSection section) async {
    state = state.copyWith(
      section: section,
      loadingTables: true,
      tables: const [],
      clearError: true,
    );
    final result = await _repo.getSectionTables(section.id);
    if (!mounted || state.section?.id != section.id) return;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(loadingTables: false, tables: data);
      case Failure(:final error):
        state = state.copyWith(loadingTables: false, error: error);
    }
  }

  Future<String?> addSection(String title) async {
    final shopId = sellerShopId();
    if (shopId == null || title.trim().isEmpty) return null;
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.createSection(shopId, title.trim());
    if (!mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          busy: false,
          sections: [...state.sections, data],
        );
        await selectSection(data);
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }

  Future<String?> removeSection(String sectionId) async {
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.deleteSection(sectionId);
    if (!mounted) return null;
    switch (result) {
      case Success():
        state = state.copyWith(busy: false);
        await fetch();
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }

  Future<String?> addTable(String name, int chairCount) async {
    final section = state.section;
    if (section == null || name.trim().isEmpty) return null;
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.createTable(
      sectionId: section.id,
      name: name.trim(),
      chairCount: chairCount,
    );
    if (!mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(busy: false, tables: [...state.tables, data]);
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }

  Future<String?> removeTable(String tableId) async {
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.deleteTable(tableId);
    if (!mounted) return null;
    switch (result) {
      case Success():
        state = state.copyWith(
          busy: false,
          tables: [
            for (final t in state.tables)
              if (t.id != tableId) t,
          ],
        );
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }
}

final reservationTablesProvider = StateNotifierProvider.autoDispose<
    ReservationTablesNotifier, ReservationTablesState>(
  (ref) => ReservationTablesNotifier(
      GetIt.instance<SellerBookingRepositoryFacade>()),
);

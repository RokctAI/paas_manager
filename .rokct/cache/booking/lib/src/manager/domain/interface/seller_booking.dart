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

import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:booking_sdk/src/common/infrastructure/models/booking_models.dart';

/// The seller-side booking seam (manager and POS composes). Registered by
/// `ManagerBookingDependencies.register` from the manager / pos di_hook.
/// Everything here is what paas_pos's TableRepository actually implemented
/// (getBookings / setBookings / changeOrderStatus / working days / closed
/// days) plus the section + table CRUD the server always had.
abstract class SellerBookingRepositoryFacade {
  /// `api.booking.get_shop_reservations`.
  Future<ApiResult<List<ReservationData>>> getShopReservations(
    String shopId, {
    ReservationStatus? status,
  });

  /// `api.booking.update_reservation_status` (seller: any status).
  Future<ApiResult<ReservationData>> updateReservationStatus(
    String reservationId,
    ReservationStatus status,
  );

  /// `api.booking.get_shop_sections_for_booking`.
  Future<ApiResult<List<BookingSection>>> getShopSections(String shopId);

  /// `api.booking.create_shop_section`.
  Future<ApiResult<BookingSection>> createSection(String shopId, String title);

  /// `api.booking.delete_shop_section`.
  Future<ApiResult<void>> deleteSection(String sectionId);

  /// `api.booking.get_tables_for_section`.
  Future<ApiResult<List<BookingTable>>> getSectionTables(String sectionId);

  /// `api.booking.create_table`.
  Future<ApiResult<BookingTable>> createTable({
    required String sectionId,
    required String name,
    required int chairCount,
  });

  /// `api.booking.delete_table`.
  Future<ApiResult<void>> deleteTable(String tableId);

  /// `api.booking.get_booking_slots` - the shop's booking hours.
  Future<ApiResult<List<BookingSlot>>> getBookingSlots(String shopId);

  /// `api.booking.create_booking_slot`.
  Future<ApiResult<BookingSlot>> createBookingSlot({
    required String shopId,
    required String startTime,
    required String endTime,
    required int maxTime,
  });

  /// `api.booking.delete_booking_slot`.
  Future<ApiResult<void>> deleteBookingSlot(String slotId);

  /// `api.booking.get_shop_booking_schedule`.
  Future<ApiResult<BookingSchedule>> getShopSchedule(String shopId);

  /// `api.booking.manage_shop_booking_working_days`, then the re-read
  /// schedule.
  Future<ApiResult<BookingSchedule>> saveWorkingDays(
    String shopId,
    List<BookingWorkingDay> days,
  );

  /// `api.booking.manage_shop_booking_closed_dates`, then the re-read
  /// schedule.
  Future<ApiResult<BookingSchedule>> saveClosedDates(
    String shopId,
    List<BookingClosedDate> dates,
  );
}

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
import 'package:base_sdk/src/handlers/platform_gateway.dart';
import 'package:booking_sdk/src/common/infrastructure/models/booking_models.dart';
import 'package:booking_sdk/src/common/infrastructure/repositories/booking_wire.dart';
import 'package:booking_sdk/src/manager/domain/interface/seller_booking.dart';

/// Seller `api.booking.*` calls over base_sdk's [PlatformGateway].
///
/// Provenance: paas_pos `table_repository_iml.dart` called
/// `paas.api.get_all_bookings` / `create_booking` / `update_booking` /
/// `get_seller_shop_working_days` / `get_seller_shop_closed_days`, none of
/// which exist on the fork's backend; these are the whitelisted booking
/// methods that carry the same operations.
class SellerBookingRepository implements SellerBookingRepositoryFacade {
  static const _gateway = PlatformGateway();

  @override
  Future<ApiResult<List<ReservationData>>> getShopReservations(
    String shopId, {
    ReservationStatus? status,
  }) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.get_shop_reservations',
        {
          'shop_id': shopId,
          if (status != null) 'status': status.wire,
        },
      );
      return ApiResult.success(
        data: asRows(body).map(ReservationData.fromJson).toList(),
      );
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<ReservationData>> updateReservationStatus(
    String reservationId,
    ReservationStatus status,
  ) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.update_reservation_status',
        {'name': reservationId, 'status': status.wire},
      );
      return ApiResult.success(data: ReservationData.fromJson(asRow(body)));
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<List<BookingSection>>> getShopSections(
      String shopId) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.get_shop_sections_for_booking',
        {'shop_id': shopId},
      );
      return ApiResult.success(
        data: asRows(body).map(BookingSection.fromJson).toList(),
      );
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<BookingSection>> createSection(
      String shopId, String title) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.create_shop_section',
        {
          'data': {'shop': shopId, 'area': title},
        },
      );
      return ApiResult.success(data: BookingSection.fromJson(asRow(body)));
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<void>> deleteSection(String sectionId) async {
    try {
      await _gateway.tenant(
        'api.booking.delete_shop_section',
        {'name': sectionId},
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<List<BookingTable>>> getSectionTables(
      String sectionId) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.get_tables_for_section',
        {'shop_section_id': sectionId},
      );
      return ApiResult.success(
        data: asRows(body).map(BookingTable.fromJson).toList(),
      );
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<BookingTable>> createTable({
    required String sectionId,
    required String name,
    required int chairCount,
  }) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.create_table',
        {
          'data': {
            'name': name,
            'shop_section': sectionId,
            'chair_count': chairCount,
            'active': 1,
          },
        },
      );
      return ApiResult.success(data: BookingTable.fromJson(asRow(body)));
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<void>> deleteTable(String tableId) async {
    try {
      await _gateway.tenant('api.booking.delete_table', {'name': tableId});
      return const ApiResult.success(data: null);
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<List<BookingSlot>>> getBookingSlots(String shopId) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.get_booking_slots',
        {'shop_id': shopId},
      );
      return ApiResult.success(
        data: asRows(body).map(BookingSlot.fromJson).toList(),
      );
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<BookingSlot>> createBookingSlot({
    required String shopId,
    required String startTime,
    required String endTime,
    required int maxTime,
  }) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.create_booking_slot',
        {
          'data': {
            'shop': shopId,
            'start_time': startTime,
            'end_time': endTime,
            'max_time': maxTime,
            'active': 1,
          },
        },
      );
      return ApiResult.success(data: BookingSlot.fromJson(asRow(body)));
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<void>> deleteBookingSlot(String slotId) async {
    try {
      await _gateway.tenant(
        'api.booking.delete_booking_slot',
        {'name': slotId},
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<BookingSchedule>> getShopSchedule(String shopId) async {
    try {
      final body = await _gateway.tenant(
        'api.booking.get_shop_booking_schedule',
        {'shop_id': shopId},
      );
      return ApiResult.success(data: BookingSchedule.fromJson(asRow(body)));
    } catch (e) {
      return bookingFailure(e);
    }
  }

  @override
  Future<ApiResult<BookingSchedule>> saveWorkingDays(
    String shopId,
    List<BookingWorkingDay> days,
  ) async {
    try {
      await _gateway.tenant(
        'api.booking.manage_shop_booking_working_days',
        {
          'shop_id': shopId,
          'working_days': [for (final d in days) d.toJson()],
        },
      );
    } catch (e) {
      return bookingFailure(e);
    }
    return getShopSchedule(shopId);
  }

  @override
  Future<ApiResult<BookingSchedule>> saveClosedDates(
    String shopId,
    List<BookingClosedDate> dates,
  ) async {
    try {
      await _gateway.tenant(
        'api.booking.manage_shop_booking_closed_dates',
        {
          'shop_id': shopId,
          'closed_dates': [for (final d in dates) d.toJson()],
        },
      );
    } catch (e) {
      return bookingFailure(e);
    }
    return getShopSchedule(shopId);
  }
}

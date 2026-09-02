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
import 'package:booking_sdk/src/manager/domain/interface/seller_booking.dart';

/// Demo data behind the manager / POS reservation screens
/// (`--dart-define=IS_DEMO=true`): a seeded evening of reservations, two
/// sections with tables, one booking-hours slot and a weekly schedule,
/// all served from memory. Writes stick for the session.
class DemoSellerBookingRepository implements SellerBookingRepositoryFacade {
  final List<ReservationData> _reservations = [];
  final List<BookingSection> _sections = [];
  final List<BookingTable> _tables = [];
  final List<BookingSlot> _slots = [];
  BookingSchedule _schedule = const BookingSchedule(shopId: 'demo-shop');
  int _seq = 0;

  DemoSellerBookingRepository() {
    final now = DateTime.now();
    final tonight = DateTime(now.year, now.month, now.day, 18, 0);
    _sections.addAll(const [
      BookingSection(id: 'demo-main-hall', title: 'Main hall', shopId: 'demo-shop'),
      BookingSection(id: 'demo-terrace', title: 'Terrace', shopId: 'demo-shop'),
    ]);
    _tables.addAll(const [
      BookingTable(id: 'Window 1', sectionId: 'demo-main-hall', chairCount: 2),
      BookingTable(id: 'Window 2', sectionId: 'demo-main-hall', chairCount: 4),
      BookingTable(id: 'Corner 5', sectionId: 'demo-main-hall', chairCount: 6),
      BookingTable(id: 'Terrace 1', sectionId: 'demo-terrace', chairCount: 4),
    ]);
    _slots.add(const BookingSlot(
      id: 'demo-slot',
      shopId: 'demo-shop',
      startTime: '10:00:00',
      endTime: '22:00:00',
      maxTime: 180,
    ));
    _schedule = BookingSchedule(
      shopId: 'demo-shop',
      workingDays: [
        for (final day in const [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ])
          BookingWorkingDay(
            day: day,
            fromTime: '10:00:00',
            toTime: '22:00:00',
            disabled: day == 'Monday',
          ),
      ],
    );
    final seeds = [
      ('Window 2', 'Thandi M.', 2, ReservationStatus.newStatus, 0, 'Birthday'),
      ('Corner 5', 'Sipho K.', 6, ReservationStatus.accepted, 30, null),
      ('Terrace 1', 'Lerato D.', 4, ReservationStatus.accepted, 90, null),
      ('Window 1', 'Johan V.', 2, ReservationStatus.cancelled, 120, null),
    ];
    for (final (table, user, guests, status, offset, note) in seeds) {
      final start = tonight.add(Duration(minutes: offset));
      _reservations.add(ReservationData(
        id: 'demo-reservation-${++_seq}',
        slotId: 'demo-slot',
        tableId: table,
        user: user,
        start: start,
        end: start.add(const Duration(hours: 2)),
        guestCount: guests,
        note: note,
        status: status,
      ));
    }
  }

  @override
  Future<ApiResult<List<ReservationData>>> getShopReservations(
    String shopId, {
    ReservationStatus? status,
  }) async =>
      ApiResult.success(data: [
        for (final r in _reservations)
          if (status == null || r.status == status) r,
      ]);

  @override
  Future<ApiResult<ReservationData>> updateReservationStatus(
    String reservationId,
    ReservationStatus status,
  ) async {
    final i = _reservations.indexWhere((r) => r.id == reservationId);
    if (i < 0) {
      return const ApiResult.failure(error: 'Not found', statusCode: 404);
    }
    _reservations[i] = _reservations[i].copyWith(status: status);
    return ApiResult.success(data: _reservations[i]);
  }

  @override
  Future<ApiResult<List<BookingSection>>> getShopSections(
          String shopId) async =>
      ApiResult.success(data: List.unmodifiable(_sections));

  @override
  Future<ApiResult<BookingSection>> createSection(
      String shopId, String title) async {
    final s = BookingSection(id: 'demo-section-${++_seq}', title: title, shopId: shopId);
    _sections.add(s);
    return ApiResult.success(data: s);
  }

  @override
  Future<ApiResult<void>> deleteSection(String sectionId) async {
    _sections.removeWhere((s) => s.id == sectionId);
    _tables.removeWhere((t) => t.sectionId == sectionId);
    return const ApiResult.success(data: null);
  }

  @override
  Future<ApiResult<List<BookingTable>>> getSectionTables(
          String sectionId) async =>
      ApiResult.success(data: [
        for (final t in _tables)
          if (t.sectionId == sectionId && t.active) t,
      ]);

  @override
  Future<ApiResult<BookingTable>> createTable({
    required String sectionId,
    required String name,
    required int chairCount,
  }) async {
    final t = BookingTable(id: name, sectionId: sectionId, chairCount: chairCount);
    _tables.add(t);
    return ApiResult.success(data: t);
  }

  @override
  Future<ApiResult<void>> deleteTable(String tableId) async {
    _tables.removeWhere((t) => t.id == tableId);
    return const ApiResult.success(data: null);
  }

  @override
  Future<ApiResult<List<BookingSlot>>> getBookingSlots(String shopId) async =>
      ApiResult.success(data: List.unmodifiable(_slots));

  @override
  Future<ApiResult<BookingSlot>> createBookingSlot({
    required String shopId,
    required String startTime,
    required String endTime,
    required int maxTime,
  }) async {
    final s = BookingSlot(
      id: 'demo-slot-${++_seq}',
      shopId: shopId,
      startTime: startTime,
      endTime: endTime,
      maxTime: maxTime,
    );
    _slots.add(s);
    return ApiResult.success(data: s);
  }

  @override
  Future<ApiResult<void>> deleteBookingSlot(String slotId) async {
    _slots.removeWhere((s) => s.id == slotId);
    return const ApiResult.success(data: null);
  }

  @override
  Future<ApiResult<BookingSchedule>> getShopSchedule(String shopId) async =>
      ApiResult.success(data: _schedule);

  @override
  Future<ApiResult<BookingSchedule>> saveWorkingDays(
    String shopId,
    List<BookingWorkingDay> days,
  ) async {
    _schedule = BookingSchedule(
      shopId: shopId,
      workingDays: List.of(days),
      closedDates: _schedule.closedDates,
    );
    return ApiResult.success(data: _schedule);
  }

  @override
  Future<ApiResult<BookingSchedule>> saveClosedDates(
    String shopId,
    List<BookingClosedDate> dates,
  ) async {
    _schedule = BookingSchedule(
      shopId: shopId,
      workingDays: _schedule.workingDays,
      closedDates: List.of(dates),
    );
    return ApiResult.success(data: _schedule);
  }
}

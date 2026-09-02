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
import 'package:booking_sdk/src/common/utils/booking_schedule_rules.dart';
import 'package:booking_sdk/src/manager/domain/interface/seller_booking.dart';
import 'package:booking_sdk/src/manager/utils/seller_shop_id.dart';

/// Booking hours (Booking slots), working days and closed dates - the
/// seller half of paas_pos's getWorkingDay / getCloseDay, with the writes
/// the server always had (manage_shop_booking_*) and the schedule read
/// added alongside them.
class ReservationScheduleState {
  final bool isLoading;
  final bool busy;
  final List<BookingSlot> slots;

  /// Seven rows, Monday..Sunday, editable locally until [dirty] is saved.
  final List<BookingWorkingDay> workingDays;
  final List<BookingClosedDate> closedDates;
  final bool dirty;
  final String? error;
  final bool noShop;

  const ReservationScheduleState({
    this.isLoading = false,
    this.busy = false,
    this.slots = const [],
    this.workingDays = const [],
    this.closedDates = const [],
    this.dirty = false,
    this.error,
    this.noShop = false,
  });

  ReservationScheduleState copyWith({
    bool? isLoading,
    bool? busy,
    List<BookingSlot>? slots,
    List<BookingWorkingDay>? workingDays,
    List<BookingClosedDate>? closedDates,
    bool? dirty,
    String? error,
    bool clearError = false,
    bool? noShop,
  }) =>
      ReservationScheduleState(
        isLoading: isLoading ?? this.isLoading,
        busy: busy ?? this.busy,
        slots: slots ?? this.slots,
        workingDays: workingDays ?? this.workingDays,
        closedDates: closedDates ?? this.closedDates,
        dirty: dirty ?? this.dirty,
        error: clearError ? null : (error ?? this.error),
        noShop: noShop ?? this.noShop,
      );
}

/// A full week from what the shop saved: days the shop never configured
/// start disabled with the first slot's hours (or 10:00-22:00).
List<BookingWorkingDay> weekFrom(
  BookingSchedule? schedule, {
  BookingSlot? slot,
}) {
  final from = slot?.startTime.isNotEmpty == true ? slot!.startTime : '10:00:00';
  final to = slot?.endTime.isNotEmpty == true ? slot!.endTime : '22:00:00';
  return [
    for (final day in kWeekdayNames)
      schedule?.workingDays
              .where((w) => w.day.trim().toLowerCase() == day.toLowerCase())
              .firstOrNull ??
          BookingWorkingDay(
            day: day,
            fromTime: from,
            toTime: to,
            disabled: schedule != null && schedule.workingDays.isNotEmpty,
          ),
  ];
}

class ReservationScheduleNotifier
    extends StateNotifier<ReservationScheduleState> {
  final SellerBookingRepositoryFacade _repo;

  ReservationScheduleNotifier(this._repo)
      : super(const ReservationScheduleState());

  Future<void> fetch() async {
    final shopId = sellerShopId();
    if (shopId == null) {
      state = state.copyWith(noShop: true, isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true, noShop: false);
    final results = await Future.wait([
      _repo.getBookingSlots(shopId),
      _repo.getShopSchedule(shopId),
    ]);
    if (!mounted) return;
    var slots = state.slots;
    BookingSchedule? schedule;
    String? error;
    if (results[0] case Success(:final data)) {
      slots = List<BookingSlot>.from(data as List);
    } else if (results[0] case Failure(error: final e)) {
      error = e;
    }
    if (results[1] case Success(:final data)) {
      schedule = data as BookingSchedule;
    } else if (results[1] case Failure(error: final e)) {
      error ??= e;
    }
    state = state.copyWith(
      isLoading: false,
      slots: slots,
      workingDays: weekFrom(schedule, slot: slots.firstOrNull),
      closedDates: schedule?.closedDates ?? state.closedDates,
      dirty: false,
      error: error,
    );
  }

  Future<String?> addSlot({
    required String startTime,
    required String endTime,
    required int maxMinutes,
  }) async {
    final shopId = sellerShopId();
    if (shopId == null) return null;
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.createBookingSlot(
      shopId: shopId,
      startTime: startTime,
      endTime: endTime,
      maxTime: maxMinutes,
    );
    if (!mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(busy: false, slots: [...state.slots, data]);
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }

  Future<String?> removeSlot(String slotId) async {
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.deleteBookingSlot(slotId);
    if (!mounted) return null;
    switch (result) {
      case Success():
        state = state.copyWith(
          busy: false,
          slots: [
            for (final s in state.slots)
              if (s.id != slotId) s,
          ],
        );
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }

  void toggleDay(String day) => _editDay(day, (d) => d.copyWith(disabled: !d.disabled));

  void setDayTimes(String day, {String? fromTime, String? toTime}) =>
      _editDay(day, (d) => d.copyWith(fromTime: fromTime, toTime: toTime));

  void _editDay(String day, BookingWorkingDay Function(BookingWorkingDay) f) {
    state = state.copyWith(
      dirty: true,
      workingDays: [
        for (final d in state.workingDays) if (d.day == day) f(d) else d,
      ],
    );
  }

  Future<String?> saveWorkingDays() async {
    final shopId = sellerShopId();
    if (shopId == null) return null;
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.saveWorkingDays(shopId, state.workingDays);
    if (!mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          busy: false,
          dirty: false,
          workingDays: weekFrom(data, slot: state.slots.firstOrNull),
          closedDates: data.closedDates,
        );
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }

  Future<String?> addClosedDate(DateTime day) =>
      _saveClosedDates([
        ...state.closedDates.where((d) => d.date != formatDateKey(day)),
        BookingClosedDate(formatDateKey(day)),
      ]..sort((a, b) => a.date.compareTo(b.date)));

  Future<String?> removeClosedDate(String date) => _saveClosedDates([
        for (final d in state.closedDates)
          if (d.date != date) d,
      ]);

  Future<String?> _saveClosedDates(List<BookingClosedDate> dates) async {
    final shopId = sellerShopId();
    if (shopId == null) return null;
    state = state.copyWith(busy: true, clearError: true);
    final result = await _repo.saveClosedDates(shopId, dates);
    if (!mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(busy: false, closedDates: data.closedDates);
        return null;
      case Failure(:final error):
        state = state.copyWith(busy: false, error: error);
        return error;
    }
  }
}

final reservationScheduleProvider = StateNotifierProvider.autoDispose<
    ReservationScheduleNotifier, ReservationScheduleState>(
  (ref) => ReservationScheduleNotifier(
      GetIt.instance<SellerBookingRepositoryFacade>()),
);

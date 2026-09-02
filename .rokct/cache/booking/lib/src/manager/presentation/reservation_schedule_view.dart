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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/components/buttons/custom_button.dart';
import 'package:base_sdk/src/presentation/components/loading.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:booking_sdk/src/common/booking_tr_keys.dart';
import 'package:booking_sdk/src/common/presentation/reservation_widgets.dart';
import 'package:booking_sdk/src/common/utils/booking_schedule_rules.dart';
import 'package:booking_sdk/src/manager/application/reservation_schedule/reservation_schedule_provider.dart';
import 'package:booking_sdk/src/manager/presentation/booking_dialogs.dart';

/// `/reservation-schedule`: booking hours (Booking slots - without one the
/// shop is not taking reservations), the weekly working days, and closed
/// dates. paas_pos read working / closed days for validation only; the
/// writes are the server's manage_shop_booking_* methods.
class ReservationScheduleView extends ConsumerStatefulWidget {
  const ReservationScheduleView({super.key});

  @override
  ConsumerState<ReservationScheduleView> createState() =>
      _ReservationScheduleViewState();
}

class _ReservationScheduleViewState
    extends ConsumerState<ReservationScheduleView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(reservationScheduleProvider.notifier).fetch();
    });
  }

  void _report(String? error, {String? done}) {
    if (!mounted) return;
    if (error != null) {
      AppHelpers.showCheckTopSnackBar(context, error);
    } else if (done != null) {
      AppHelpers.showCheckTopSnackBarDone(context, done);
    }
  }

  Future<void> _addSlot() async {
    final start = await pickBookingClock(context, '10:00:00');
    if (start == null || !mounted) return;
    final end = await pickBookingClock(context, '22:00:00');
    if (end == null || !mounted) return;
    final values = await promptBookingFields(
      context,
      title: AppHelpers.getTranslation(BookingTrKeys.addBookingHours),
      fields: [
        BookingPromptField(
          key: 'max',
          label:
              AppHelpers.getTranslation(BookingTrKeys.maxMinutesPerReservation),
          numeric: true,
          initial: '120',
        ),
      ],
    );
    if (values == null) return;
    _report(await ref.read(reservationScheduleProvider.notifier).addSlot(
          startTime: start,
          endTime: end,
          maxMinutes: int.tryParse(values['max'] ?? '') ?? 0,
        ));
  }

  Future<void> _addClosedDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    _report(await ref
        .read(reservationScheduleProvider.notifier)
        .addClosedDate(picked));
  }

  Future<void> _pickDayTime(String day, String current, bool from) async {
    final t = await pickBookingClock(context, current);
    if (t == null || !mounted) return;
    ref.read(reservationScheduleProvider.notifier).setDayTimes(
          day,
          fromTime: from ? t : null,
          toTime: from ? null : t,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = LocalStorage.getAppThemeMode();
    final state = ref.watch(reservationScheduleProvider);
    final notifier = ref.read(reservationScheduleProvider.notifier);
    final textColor = isDark ? AppStyle.white : AppStyle.black;
    final cardColor =
        isDark ? AppStyle.bottomNavigationBarColor : AppStyle.white;
    final border = isDark ? AppStyle.borderDark : AppStyle.borderColor;

    Widget body;
    if (state.noShop) {
      body = BookingMessage(
        isDark: isDark,
        text: AppHelpers.getTranslation(BookingTrKeys.noShopOnThisAccount),
      );
    } else if (state.isLoading && state.workingDays.isEmpty) {
      body = const Loading();
    } else {
      body = ListView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        children: [
          // Booking hours.
          Row(
            children: [
              Expanded(
                child: BookingStepTitle(
                  isDark: isDark,
                  title: AppHelpers.getTranslation(BookingTrKeys.bookingHours),
                ),
              ),
              IconButton(
                onPressed: state.busy ? null : _addSlot,
                icon: Icon(Remix.add_line, size: 22.r, color: textColor),
              ),
            ],
          ),
          if (state.slots.isEmpty)
            Text(
              AppHelpers.getTranslation(
                  BookingTrKeys.shopNotTakingReservationsYet),
              style: AppStyle.interNormal(size: 13, color: AppStyle.textGrey),
            )
          else
            for (final s in state.slots)
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: border),
                ),
                child: Row(
                  children: [
                    Icon(Remix.time_line, size: 20.r, color: AppStyle.primary),
                    12.horizontalSpace,
                    Expanded(
                      child: Text(
                        '${_clock(s.startTime)} - ${_clock(s.endTime)}'
                        '${s.maxTime > 0 ? '  (${maxDurationMinutes(s)} min)' : ''}',
                        style: AppStyle.interSemi(size: 14, color: textColor),
                      ),
                    ),
                    IconButton(
                      onPressed: state.busy
                          ? null
                          : () async {
                              _report(await notifier.removeSlot(s.id));
                            },
                      icon: Icon(Remix.delete_bin_line,
                          size: 20.r, color: AppStyle.red),
                    ),
                  ],
                ),
              ),

          // Working days.
          BookingStepTitle(
            isDark: isDark,
            title: AppHelpers.getTranslation(BookingTrKeys.bookingWorkingDays),
          ),
          for (final d in state.workingDays)
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      d.day,
                      style: AppStyle.interSemi(
                        size: 14,
                        color: d.disabled ? AppStyle.textGrey : textColor,
                      ),
                    ),
                  ),
                  if (!d.disabled) ...[
                    _ClockButton(
                      label: _clock(d.fromTime),
                      isDark: isDark,
                      onTap: () => _pickDayTime(d.day, d.fromTime, true),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Text('-',
                          style: AppStyle.interNormal(
                              size: 14, color: AppStyle.textGrey)),
                    ),
                    _ClockButton(
                      label: _clock(d.toTime),
                      isDark: isDark,
                      onTap: () => _pickDayTime(d.day, d.toTime, false),
                    ),
                  ],
                  Switch(
                    value: !d.disabled,
                    activeThumbColor: AppStyle.primary,
                    onChanged: (_) => notifier.toggleDay(d.day),
                  ),
                ],
              ),
            ),
          8.verticalSpace,
          CustomButton(
            title: AppHelpers.getTranslation(BookingTrKeys.saveSchedule),
            background: AppStyle.primary,
            textColor: AppStyle.white,
            isLoading: state.busy,
            onPressed: state.dirty && !state.busy
                ? () async {
                    _report(
                      await notifier.saveWorkingDays(),
                      done: AppHelpers.getTranslation(
                          BookingTrKeys.scheduleSaved),
                    );
                  }
                : null,
          ),

          // Closed dates.
          Row(
            children: [
              Expanded(
                child: BookingStepTitle(
                  isDark: isDark,
                  title:
                      AppHelpers.getTranslation(BookingTrKeys.bookingClosedDates),
                ),
              ),
              IconButton(
                onPressed: state.busy ? null : _addClosedDate,
                icon: Icon(Remix.add_line, size: 22.r, color: textColor),
              ),
            ],
          ),
          if (state.closedDates.isEmpty)
            Text(
              AppHelpers.getTranslation(BookingTrKeys.addClosedDate),
              style: AppStyle.interNormal(size: 13, color: AppStyle.textGrey),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final c in state.closedDates)
                  InputChip(
                    label: Text(
                      c.date,
                      style: AppStyle.interNormal(size: 13, color: textColor),
                    ),
                    backgroundColor: cardColor,
                    side: BorderSide(color: border),
                    deleteIcon: Icon(Remix.close_line, size: 16.r),
                    onDeleted: state.busy
                        ? null
                        : () async {
                            _report(await notifier.removeClosedDate(c.date));
                          },
                  ),
              ],
            ),
          if (state.error != null)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                state.error!,
                style: AppStyle.interNormal(size: 13, color: AppStyle.red),
              ),
            ),
        ],
      );
    }

    return BookingScreen(
      isDark: isDark,
      title: AppHelpers.getTranslation(BookingTrKeys.reservationSchedule),
      child: body,
    );
  }

  String _clock(String raw) {
    final m = parseClockMinutes(raw);
    return m == null ? raw : formatClock(m);
  }
}

class _ClockButton extends StatelessWidget {
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _ClockButton({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: isDark ? AppStyle.mainBackDark : AppStyle.bgGrey,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: AppStyle.interSemi(
              size: 13,
              color: isDark ? AppStyle.white : AppStyle.black,
            ),
          ),
        ),
      );
}

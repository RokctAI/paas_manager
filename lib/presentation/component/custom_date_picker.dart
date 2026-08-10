// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';

class CustomDatePicker extends StatefulWidget {
  final List<DateTime?> range;

  const CustomDatePicker({super.key, required this.range});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final config = CalendarDatePicker2Config(
    calendarType: CalendarDatePicker2Type.range,
    selectedDayHighlightColor: Style.primary,
    weekdayLabelTextStyle: Style.interNormal(
      size: 14.sp,
      letterSpacing: -0.3,
      color: Style.blackColor,
    ),
    controlsTextStyle: Style.interNormal(
      size: 14.sp,
      letterSpacing: -0.3,
      color: Style.blackColor,
    ),
    dayTextStyle: Style.interNormal(
      size: 14.sp,
      letterSpacing: -0.3,
      color: Style.blackColor,
    ),
    disabledDayTextStyle: Style.interNormal(
      size: 14.sp,
      letterSpacing: -0.3,
      color: Style.textColor,
    ),
    dayBorderRadius: BorderRadius.circular(10.r),
  );

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: config,
      value: widget.range,
      onValueChanged: (values) {},
    );
  }
}

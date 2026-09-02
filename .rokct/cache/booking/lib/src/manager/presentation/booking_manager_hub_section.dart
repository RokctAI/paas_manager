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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/components/title_icon.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:booking_sdk/src/common/booking_routes.dart';
import 'package:booking_sdk/src/common/booking_tr_keys.dart';

/// The RESERVATIONS group on the manager profile host (base_sdk's
/// GenericProfilePage, sections from ProfileSectionRegistry): three rows
/// that push booking_sdk's manager routes by path. Registered by
/// `ManagerBookingDependencies` at order 135, between merchants' wallet
/// (130) and sections (140) groups. Drawn in the same shape as merchants'
/// SectionsItem rows (which this SDK cannot import - ADR-005).
class BookingManagerHubSection extends StatelessWidget {
  const BookingManagerHubSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndIcon(
          title: AppHelpers.getTranslation(BookingTrKeys.reservations),
          // The shared default is pinned black for white-sheet hosts; the
          // manager profile host is dark-surfaced.
          titleColor: AppStyle.textPrimary,
        ),
        20.verticalSpace,
        _HubRow(
          icon: Remix.reserved_line,
          title: AppHelpers.getTranslation(BookingTrKeys.reservations),
          onTap: () =>
              BookingRoutes.push(context, BookingRoutes.shopReservations),
        ),
        _HubRow(
          icon: Remix.layout_grid_line,
          title: AppHelpers.getTranslation(BookingTrKeys.tablesAndSections),
          onTap: () =>
              BookingRoutes.push(context, BookingRoutes.reservationTables),
        ),
        _HubRow(
          icon: Remix.calendar_check_line,
          title: AppHelpers.getTranslation(BookingTrKeys.reservationSchedule),
          onTap: () =>
              BookingRoutes.push(context, BookingRoutes.reservationSchedule),
        ),
      ],
    );
  }
}

class _HubRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HubRow({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, size: 22.r, color: AppStyle.textPrimary),
            14.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: AppStyle.interNormal(size: 15, color: AppStyle.textPrimary),
              ),
            ),
            Icon(
              Remix.arrow_right_s_line,
              size: 20.r,
              color: AppStyle.textDarkSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

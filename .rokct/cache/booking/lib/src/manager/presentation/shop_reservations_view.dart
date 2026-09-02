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

import 'package:base_sdk/src/presentation/components/lists/list_language.dart';
import 'package:base_sdk/src/presentation/components/loading.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:booking_sdk/src/common/booking_tr_keys.dart';
import 'package:booking_sdk/src/common/infrastructure/models/booking_models.dart';
import 'package:booking_sdk/src/common/presentation/reservation_widgets.dart';
import 'package:booking_sdk/src/manager/application/shop_reservations/shop_reservations_provider.dart';

/// `/shop-reservations`: paas_pos's TablesPage booking list (table_order
/// cards + list_table_info's New / Accepted / Cancelled buttons), in the
/// standard list language (ListFilterTabBar for the status tabs).
class ShopReservationsView extends ConsumerStatefulWidget {
  const ShopReservationsView({super.key});

  @override
  ConsumerState<ShopReservationsView> createState() =>
      _ShopReservationsViewState();
}

class _ShopReservationsViewState extends ConsumerState<ShopReservationsView> {
  static const List<ReservationStatus?> _tabs = [
    null,
    ReservationStatus.newStatus,
    ReservationStatus.accepted,
    ReservationStatus.cancelled,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(shopReservationsProvider.notifier).fetch();
    });
  }

  Future<void> _setStatus(ReservationData r, ReservationStatus status) async {
    final error =
        await ref.read(shopReservationsProvider.notifier).setStatus(r.id, status);
    if (!mounted || error == null) return;
    AppHelpers.showCheckTopSnackBar(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = LocalStorage.getAppThemeMode();
    final state = ref.watch(shopReservationsProvider);
    final notifier = ref.read(shopReservationsProvider.notifier);

    Widget body;
    if (state.noShop) {
      body = BookingMessage(
        isDark: isDark,
        text: AppHelpers.getTranslation(BookingTrKeys.noShopOnThisAccount),
      );
    } else if (state.isLoading && state.reservations.isEmpty) {
      body = const Loading();
    } else {
      final visible = state.visible;
      body = Column(
        children: [
          ListFilterTabBar(
            tabs: [
              ListFilterTab(
                label: AppHelpers.getTranslation(TrKeys.all),
                color: AppStyle.primary,
                count: state.countOf(null),
              ),
              ListFilterTab(
                label: reservationStatusLabel(ReservationStatus.newStatus),
                color: AppStyle.pendingDark,
                count: state.countOf(ReservationStatus.newStatus),
              ),
              ListFilterTab(
                label: reservationStatusLabel(ReservationStatus.accepted),
                color: AppStyle.green,
                count: state.countOf(ReservationStatus.accepted),
              ),
              ListFilterTab(
                label: reservationStatusLabel(ReservationStatus.cancelled),
                color: AppStyle.red,
                count: state.countOf(ReservationStatus.cancelled),
              ),
            ],
            activeIndex: _tabs.indexOf(state.filter),
            onSelect: (i) => notifier.setFilter(_tabs[i]),
          ),
          Expanded(
            child: visible.isEmpty
                ? BookingMessage(
                    isDark: isDark,
                    text: state.error ??
                        AppHelpers.getTranslation(
                            BookingTrKeys.noReservationsYet),
                  )
                : RefreshIndicator(
                    onRefresh: notifier.fetch,
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                      itemCount: visible.length,
                      itemBuilder: (context, i) {
                        final r = visible[i];
                        final busy = state.updatingId == r.id;
                        return ReservationCard(
                          reservation: r,
                          isDark: isDark,
                          showUser: true,
                          actions: Wrap(
                            spacing: 8.w,
                            children: [
                              if (r.status != ReservationStatus.accepted)
                                _action(
                                  BookingTrKeys.markAccepted,
                                  AppStyle.green,
                                  busy
                                      ? null
                                      : () => _setStatus(
                                          r, ReservationStatus.accepted),
                                ),
                              if (r.status != ReservationStatus.newStatus)
                                _action(
                                  BookingTrKeys.markNew,
                                  AppStyle.pendingDark,
                                  busy
                                      ? null
                                      : () => _setStatus(
                                          r, ReservationStatus.newStatus),
                                ),
                              if (r.status != ReservationStatus.cancelled)
                                _action(
                                  BookingTrKeys.markCancelled,
                                  AppStyle.red,
                                  busy
                                      ? null
                                      : () => _setStatus(
                                          r, ReservationStatus.cancelled),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      );
    }

    return BookingScreen(
      isDark: isDark,
      title: AppHelpers.getTranslation(BookingTrKeys.reservations),
      child: body,
    );
  }

  Widget _action(String key, Color color, VoidCallback? onTap) => TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          minimumSize: Size(0, 32.h),
        ),
        child: Text(
          AppHelpers.getTranslation(key),
          style: AppStyle.interSemi(size: 13, color: color),
        ),
      );
}

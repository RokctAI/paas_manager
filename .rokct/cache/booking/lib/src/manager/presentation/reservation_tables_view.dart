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

import 'package:base_sdk/src/presentation/components/loading.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:booking_sdk/src/common/booking_tr_keys.dart';
import 'package:booking_sdk/src/common/presentation/reservation_widgets.dart';
import 'package:booking_sdk/src/manager/application/reservation_tables/reservation_tables_provider.dart';
import 'package:booking_sdk/src/manager/presentation/booking_dialogs.dart';

/// `/reservation-tables`: the shop's sections (chips, add / delete) and
/// the selected section's tables (rows with seat count, add / delete).
class ReservationTablesView extends ConsumerStatefulWidget {
  const ReservationTablesView({super.key});

  @override
  ConsumerState<ReservationTablesView> createState() =>
      _ReservationTablesViewState();
}

class _ReservationTablesViewState extends ConsumerState<ReservationTablesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(reservationTablesProvider.notifier).fetch();
    });
  }

  void _report(String? error) {
    if (!mounted || error == null) return;
    AppHelpers.showCheckTopSnackBar(context, error);
  }

  Future<void> _addSection() async {
    final values = await promptBookingFields(
      context,
      title: AppHelpers.getTranslation(BookingTrKeys.addSection),
      fields: [
        BookingPromptField(
          key: 'title',
          label: AppHelpers.getTranslation(BookingTrKeys.sectionName),
        ),
      ],
    );
    if (values == null) return;
    _report(await ref
        .read(reservationTablesProvider.notifier)
        .addSection(values['title'] ?? ''));
  }

  Future<void> _addTable() async {
    final values = await promptBookingFields(
      context,
      title: AppHelpers.getTranslation(BookingTrKeys.addTable),
      fields: [
        BookingPromptField(
          key: 'name',
          label: AppHelpers.getTranslation(BookingTrKeys.tableName),
        ),
        BookingPromptField(
          key: 'chairs',
          label: AppHelpers.getTranslation(BookingTrKeys.chairCount),
          numeric: true,
          initial: '4',
        ),
      ],
    );
    if (values == null) return;
    _report(await ref.read(reservationTablesProvider.notifier).addTable(
          values['name'] ?? '',
          int.tryParse(values['chairs'] ?? '') ?? 0,
        ));
  }

  Future<void> _removeSection(String id, String title) async {
    final ok = await confirmBooking(
      context,
      title: AppHelpers.getTranslation(
          BookingTrKeys.deleteThisSectionAndItsTables),
      body: title,
    );
    if (!ok) return;
    _report(
        await ref.read(reservationTablesProvider.notifier).removeSection(id));
  }

  Future<void> _removeTable(String id) async {
    final ok = await confirmBooking(
      context,
      title: AppHelpers.getTranslation(BookingTrKeys.deleteThisTable),
      body: id,
    );
    if (!ok) return;
    _report(await ref.read(reservationTablesProvider.notifier).removeTable(id));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = LocalStorage.getAppThemeMode();
    final state = ref.watch(reservationTablesProvider);
    final notifier = ref.read(reservationTablesProvider.notifier);
    final textColor = isDark ? AppStyle.white : AppStyle.black;

    Widget body;
    if (state.noShop) {
      body = BookingMessage(
        isDark: isDark,
        text: AppHelpers.getTranslation(BookingTrKeys.noShopOnThisAccount),
      );
    } else if (state.isLoading && state.sections.isEmpty) {
      body = const Loading();
    } else {
      body = ListView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        children: [
          Row(
            children: [
              Expanded(
                child: BookingStepTitle(
                  isDark: isDark,
                  title: AppHelpers.getTranslation(TrKeys.sections),
                ),
              ),
              _RoundAction(
                icon: Remix.add_line,
                isDark: isDark,
                onTap: state.busy ? null : _addSection,
              ),
            ],
          ),
          if (state.sections.isEmpty)
            Text(
              AppHelpers.getTranslation(BookingTrKeys.noSectionsYet),
              style: AppStyle.interNormal(size: 13, color: AppStyle.textGrey),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final s in state.sections)
                  BookingChip(
                    label: s.title,
                    isDark: isDark,
                    selected: state.section?.id == s.id,
                    onTap: () => notifier.selectSection(s),
                  ),
              ],
            ),
          if (state.section != null) ...[
            Row(
              children: [
                Expanded(
                  child: BookingStepTitle(
                    isDark: isDark,
                    title: '${AppHelpers.getTranslation(BookingTrKeys.tables)} - '
                        '${state.section!.title}',
                  ),
                ),
                _RoundAction(
                  icon: Remix.delete_bin_line,
                  isDark: isDark,
                  color: AppStyle.red,
                  onTap: state.busy
                      ? null
                      : () => _removeSection(
                          state.section!.id, state.section!.title),
                ),
                8.horizontalSpace,
                _RoundAction(
                  icon: Remix.add_line,
                  isDark: isDark,
                  onTap: state.busy ? null : _addTable,
                ),
              ],
            ),
            if (state.loadingTables)
              const Padding(padding: EdgeInsets.all(16), child: Loading())
            else if (state.tables.isEmpty)
              Text(
                AppHelpers.getTranslation(BookingTrKeys.noTablesYet),
                style:
                    AppStyle.interNormal(size: 13, color: AppStyle.textGrey),
              )
            else
              for (final t in state.tables)
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppStyle.bottomNavigationBarColor
                        : AppStyle.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color:
                          isDark ? AppStyle.borderDark : AppStyle.borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Remix.table_line, size: 20.r, color: AppStyle.primary),
                      12.horizontalSpace,
                      Expanded(
                        child: Text(
                          t.id,
                          style:
                              AppStyle.interSemi(size: 15, color: textColor),
                        ),
                      ),
                      Text(
                        '${t.chairCount} '
                        '${AppHelpers.getTranslation(BookingTrKeys.reservationSeats)}',
                        style: AppStyle.interNormal(
                            size: 13, color: AppStyle.textGrey),
                      ),
                      8.horizontalSpace,
                      IconButton(
                        onPressed:
                            state.busy ? null : () => _removeTable(t.id),
                        icon: Icon(Remix.delete_bin_line,
                            size: 20.r, color: AppStyle.red),
                      ),
                    ],
                  ),
                ),
          ],
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
      title: AppHelpers.getTranslation(BookingTrKeys.tablesAndSections),
      child: body,
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final Color? color;
  final VoidCallback? onTap;

  const _RoundAction({
    required this.icon,
    required this.isDark,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isDark ? AppStyle.bottomNavigationBarColor : AppStyle.white,
            border: Border.all(
              color: isDark ? AppStyle.borderDark : AppStyle.borderColor,
            ),
          ),
          child: Icon(
            icon,
            size: 18.r,
            color: onTap == null
                ? AppStyle.textGrey
                : (color ?? (isDark ? AppStyle.white : AppStyle.black)),
          ),
        ),
      );
}

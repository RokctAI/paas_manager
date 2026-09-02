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

import 'package:flutter/foundation.dart';

import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/manager/application/profit/profit_dashboard_state.dart';
import 'package:revenue_sdk/src/manager/application/profit/revenue_period.dart';

/// Drives the approved revenue dashboard (section 36): one fetch per window
/// change, three parallel calls —
///
///  * `get_seller_profit_report` for the current window,
///  * the same endpoint for the previous window (delta pills 657),
///  * the SHIPPED `get_order_report` for the payout strip (662) and the
///    "N today" sub-line.
///
/// The three fail independently: a backend that predates the profit
/// endpoint still answers the payout call, and the dashboard renders its
/// honest error card for the profit content instead of fake zeros.
class ProfitDashboardNotifier extends StateNotifier<ProfitDashboardState> {
  ProfitDashboardNotifier(this._repository)
      : super(const ProfitDashboardState());

  final SellerStatisticsRepositoryFacade _repository;

  /// Guards against a stale window's response landing over a newer one.
  int _fetchStamp = 0;

  RevenueWindow window({DateTime? now}) => RevenueWindow.of(
        state.period,
        now ?? DateTime.now(),
        customFrom: state.customFrom,
        customTo: state.customTo,
      );

  Future<void> setPeriod(RevenuePeriod period) async {
    if (period == state.period && period != RevenuePeriod.custom) return;
    state = state.copyWith(period: period);
    await fetch();
  }

  Future<void> setCustomRange(DateTime from, DateTime to) async {
    state = state.copyWith(
      period: RevenuePeriod.custom,
      customFrom: from,
      customTo: to,
    );
    await fetch();
  }

  void selectProduct(String? id) {
    if (id == null) {
      state = state.copyWith(clearSelection: true);
    } else {
      state = state.copyWith(selectedProductId: id);
    }
  }

  Future<void> fetch() async {
    final stamp = ++_fetchStamp;
    final w = window();
    state = state.copyWith(
      isLoading: true,
      hasReportError: false,
      clearReport: true,
      clearPrevious: true,
    );

    // Started eagerly, awaited together — three parallel calls.
    final reportFuture = _repository.getProfitReport(from: w.from, to: w.to);
    final previousFuture =
        _repository.getProfitReport(from: w.previousFrom, to: w.previousTo);
    // The shipped statistics call takes its window as startTime (newer) /
    // endTime (older) — the legacy naming its repository maps back to
    // from_date/to_date.
    final payoutFuture =
        _repository.getStatistics(startTime: w.to, endTime: w.from);

    final reportResult = await reportFuture;
    final previousResult = await previousFuture;
    final payoutResult = await payoutFuture;
    if (stamp != _fetchStamp || !mounted) return;

    var next = state.copyWith(isLoading: false);
    reportResult.when(
      success: (data) {
        final report = data.data;
        next = next.copyWith(report: report, hasReportError: report == null);
      },
      failure: (fail, status) {
        debugPrint('==> profit report fetch failed: $fail');
        next = next.copyWith(hasReportError: true);
      },
    );
    previousResult.when(
      success: (data) {
        next = next.copyWith(previous: data.data);
      },
      failure: (fail, status) {
        // Deltas simply do not render without a previous window.
        debugPrint('==> previous-window profit report failed: $fail');
      },
    );
    payoutResult.when(
      success: (data) {
        next = next.copyWith(payout: data.data);
      },
      failure: (fail, status) {
        debugPrint('==> payout statistics fetch failed: $fail');
      },
    );
    state = next;
  }
}

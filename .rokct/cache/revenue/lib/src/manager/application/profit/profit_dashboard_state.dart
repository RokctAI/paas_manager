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

import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_response.dart';
import 'package:revenue_sdk/src/manager/application/profit/revenue_period.dart';

/// Plain immutable state, hand-written `copyWith` like the sibling
/// `StatisticsState` (revenue_sdk stays analyzable without build_runner).
///
/// Three data sources ride together, failing independently so the dashboard
/// degrades honestly instead of all-or-nothing:
///  * [report] — the new profit endpoint, current window;
///  * [previous] — the same endpoint, shifted window (delta pills);
///  * [payout] — the SHIPPED `get_order_report` (payout strip 662 and the
///    "N today" sub-line), which keeps answering on backends that predate
///    the profit endpoint.
class ProfitDashboardState {
  const ProfitDashboardState({
    this.isLoading = false,
    this.hasReportError = false,
    this.report,
    this.previous,
    this.payout,
    this.period = RevenuePeriod.week,
    this.customFrom,
    this.customTo,
    this.selectedProductId,
  });

  final bool isLoading;

  /// True when the CURRENT window's profit report failed (backend not yet
  /// deployed, network) — the dashboard shows its error card with retry;
  /// a missing [previous] alone only hides the delta pills.
  final bool hasReportError;
  final ProfitReport? report;
  final ProfitReport? previous;
  final StatisticsModel? payout;
  final RevenuePeriod period;
  final DateTime? customFrom;
  final DateTime? customTo;

  /// The drill-down selection (chip 670) — plane pushes are selection
  /// driven, exactly like the kitchen/catalog flows.
  final String? selectedProductId;

  ProductProfit? get selectedProduct {
    final id = selectedProductId;
    if (id == null) return null;
    for (final product in report?.products ?? const <ProductProfit>[]) {
      if (product.id == id) return product;
    }
    return null;
  }

  ProfitDashboardState copyWith({
    bool? isLoading,
    bool? hasReportError,
    ProfitReport? report,
    bool clearReport = false,
    ProfitReport? previous,
    bool clearPrevious = false,
    StatisticsModel? payout,
    RevenuePeriod? period,
    DateTime? customFrom,
    DateTime? customTo,
    String? selectedProductId,
    bool clearSelection = false,
  }) =>
      ProfitDashboardState(
        isLoading: isLoading ?? this.isLoading,
        hasReportError: hasReportError ?? this.hasReportError,
        report: clearReport ? null : (report ?? this.report),
        previous: clearPrevious ? null : (previous ?? this.previous),
        payout: payout ?? this.payout,
        period: period ?? this.period,
        customFrom: customFrom ?? this.customFrom,
        customTo: customTo ?? this.customTo,
        selectedProductId: clearSelection
            ? null
            : (selectedProductId ?? this.selectedProductId),
      );
}

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
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_order_response.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_response.dart';

/// Demo-only [SellerStatisticsRepositoryFacade]
/// (`--dart-define=IS_DEMO=true`): serves a small fictional week of store
/// revenue offline so the manager /income screen is never a zeroed shell in
/// demo builds — the same `AppConstants.isDemo` split delivery_sdk's
/// `DriverDeliveryDependencies` applies to every courier facade
/// (DemoLmsRepository precedent). Registered in place of
/// `SellerStatisticsRepository` by `ManagerRevenueDependencies`; zero
/// behavior change when IS_DEMO is off. Never used in production; nothing
/// leaves the device.
///
/// Covers the whole facade, the section-36 profit dashboard included: the
/// real `SellerStatisticsRepository.getProfitReport` calls an endpoint that
/// a demo device has no backend for, so the demo answers from the same
/// fictional week the statistics methods above already serve.
class DemoSellerStatisticsRepository
    implements SellerStatisticsRepositoryFacade {
  /// Per-day demo figures, indexed by a stable day ordinal rather than by
  /// position in the window: the dashboard asks for the current window AND
  /// the shifted previous one, so keying off the date is what makes the two
  /// answers differ and the vs-previous-period delta pills actually render.
  static const _dailyRevenue = <double>[
    5200,
    4750,
    6100,
    5650,
    6900,
    7400,
    5900,
  ];
  static const _dailyMarginPct = <double>[
    31.5,
    29.8,
    33.2,
    30.6,
    34.1,
    32.7,
    28.9,
  ];
  static const _dailyOrders = <int>[46, 41, 53, 49, 58, 63, 51];

  /// Share of revenue whose lines carry a cost snapshot. The remainder is
  /// the honest unknown bucket, so the demo dashboard exercises that state
  /// too instead of pretending every order is costed.
  static const _costedShare = 0.88;

  /// Trading-hour weights for the Today view: the backend answers per-hour
  /// when `from == to`, so the demo shapes its series the same way.
  static const _hourlyWeights = <double>[
    0.03,
    0.05,
    0.07,
    0.11,
    0.13,
    0.10,
    0.07,
    0.06,
    0.08,
    0.12,
    0.11,
    0.07,
  ];
  static const _firstTradingHour = 8;

  /// Bound on a custom range so a wide window cannot spin the loop.
  static const _maxWindowDays = 400;

  /// A small deterministic per-day wobble (0.85..1.15) layered over the
  /// seven-value base pattern. Without it a seven-day window and the
  /// seven-day-earlier window it is compared against would sum the same
  /// seven values, and every vs-previous-period delta pill would read zero.
  /// 31 and 7 are coprime, so the combined pattern only repeats after 217
  /// days — longer than any window the dashboard offers.
  static double _wobble(int slot) => 0.85 + ((slot * 37) % 31) / 100.0;

  /// Seven days of per-day revenue ending today, so every tab window
  /// (today / weekly / monthly) has points inside it.
  static List<Chart> _chartDays() {
    const dailyTotals = <num>[5200, 4750, 6100, 5650, 6900, 7400, 5900];
    final today = DateTime.now();
    return [
      for (var i = 0; i < dailyTotals.length; i++)
        Chart(
          time: DateTime(today.year, today.month, today.day)
              .subtract(Duration(days: dailyTotals.length - 1 - i)),
          totalPrice: dailyTotals[i],
        ),
    ];
  }

  @override
  Future<ApiResult<StatisticsResponse>> getStatistics({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final chart = _chartDays();
    final total = chart.fold<num>(0, (sum, c) => sum + (c.totalPrice ?? 0));
    return ApiResult.success(
      data: StatisticsResponse(
        data: StatisticsModel(
          lastOrderTotalPrice: 640,
          lastOrderIncome: 640,
          totalPrice: total,
          fmTotalPrice: total,
          totalCount: 342,
          totalNewCount: 4,
          totalReadyCount: 3,
          totalOnAWayCount: 2,
          totalAcceptedCount: 5,
          totalCanceledCount: 6,
          totalDeliveredCount: 322,
          totalTodayCount: 14,
          chart: chart,
        ),
      ),
    );
  }

  @override
  Future<ApiResult<StatisticsOrderResponse>> getStatisticsOrder({
    DateTime? startTime,
    DateTime? endTime,
    int? page,
    int? perPage,
  }) async =>
      ApiResult.success(
        data: StatisticsOrderResponse(
          status: true,
          data: (page ?? 1) > 1
              ? const []
              : [
                  StatisticsOrder(
                    id: 1041,
                    status: 'delivered',
                    firstname: 'Naledi',
                    lastname: 'K.',
                    active: 1,
                    quantity: 3,
                    price: 640,
                    products: const ['Family bundle', 'Juice 1L'],
                  ),
                  StatisticsOrder(
                    id: 1040,
                    status: 'delivered',
                    firstname: 'Sipho',
                    lastname: 'D.',
                    active: 1,
                    quantity: 2,
                    price: 285,
                    products: const ['Breakfast box'],
                  ),
                  StatisticsOrder(
                    id: 1039,
                    status: 'canceled',
                    firstname: 'Lerato',
                    lastname: 'M.',
                    active: 0,
                    quantity: 1,
                    price: 120,
                    products: const ['Snack pack'],
                  ),
                ],
        ),
      );

  @override
  Future<ApiResult<ProfitReportResponse>> getProfitReport({
    required DateTime from,
    required DateTime to,
  }) async {
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);

    // Inclusive [from]..[to], walked through DateTime's own normalisation so
    // month ends and DST shifts cannot drift the day count.
    final days = <DateTime>[];
    while (days.length < _maxWindowDays) {
      final day = DateTime(start.year, start.month, start.day + days.length);
      if (day.isAfter(end)) break;
      days.add(day);
    }
    if (days.isEmpty) days.add(start);

    var revenue = 0.0;
    var profit = 0.0;
    var costedRevenue = 0.0;
    var orders = 0;
    var ordersCosted = 0;
    var series = <ProfitPoint>[];

    for (final day in days) {
      final slot = _ordinal(day);
      final wobble = _wobble(slot);
      final dayRevenue = _dailyRevenue[slot % _dailyRevenue.length] * wobble;
      final dayMargin = _dailyMarginPct[slot % _dailyMarginPct.length];
      final dayOrders =
          (_dailyOrders[slot % _dailyOrders.length] * wobble).round();
      final dayCosted = dayRevenue * _costedShare;
      final dayProfit = dayCosted * dayMargin / 100;

      revenue += dayRevenue;
      costedRevenue += dayCosted;
      profit += dayProfit;
      orders += dayOrders;
      ordersCosted += (dayOrders * _costedShare).round();
      series.add(
        ProfitPoint(
          date: _isoDay(day),
          revenue: dayRevenue,
          profit: dayProfit,
        ),
      );
    }

    // Single-day window: hourly buckets, matching the endpoint contract.
    if (days.length == 1) {
      series = [
        for (var hour = 0; hour < _hourlyWeights.length; hour++)
          ProfitPoint(
            date: '${_pad(_firstTradingHour + hour)}:00',
            revenue: revenue * _hourlyWeights[hour],
            profit: profit * _hourlyWeights[hour],
          ),
      ];
    }

    final revenueExcluded = revenue - costedRevenue;
    final marginPct =
        costedRevenue == 0 ? 0.0 : profit / costedRevenue * 100;

    // Four costed rows sharing the costed pot, plus one row sold without a
    // cost price so the "cost not set" state has something to render.
    final products = <ProductProfit>[
      _costedProduct(
        id: 'demo-family-bundle',
        name: 'Family bundle',
        share: 0.38,
        price: 219,
        costedRevenue: costedRevenue,
        marginPct: marginPct,
      ),
      _costedProduct(
        id: 'demo-breakfast-box',
        name: 'Breakfast box',
        share: 0.27,
        price: 145,
        costedRevenue: costedRevenue,
        marginPct: marginPct,
      ),
      _costedProduct(
        id: 'demo-snack-pack',
        name: 'Snack pack',
        share: 0.21,
        price: 62,
        costedRevenue: costedRevenue,
        marginPct: marginPct,
      ),
      _costedProduct(
        id: 'demo-juice-1l',
        name: 'Juice 1L',
        share: 0.14,
        price: 38,
        costedRevenue: costedRevenue,
        marginPct: marginPct,
      ),
      ProductProfit(
        id: 'demo-seasonal-special',
        name: 'Seasonal special',
        sold: (revenueExcluded / 95).round(),
        revenue: revenueExcluded,
        price: 95,
        costMissing: true,
      ),
    ];

    final cancelled = (orders * 0.04).round();
    final onAWay = (orders * 0.02).round();
    final cooking = (orders * 0.03).round();
    final accepted = (orders * 0.03).round();
    final fresh = (orders * 0.02).round();
    final open = cancelled + onAWay + cooking + accepted + fresh;
    final delivered = orders > open ? orders - open : 0;

    return ApiResult.success(
      data: ProfitReportResponse(
        data: ProfitReport(
          totals: ProfitTotals(
            revenue: revenue,
            profit: profit,
            costedRevenue: costedRevenue,
            marginPct: marginPct,
            orders: orders,
            ordersCosted: ordersCosted,
            avgOrder: orders == 0 ? 0 : revenue / orders,
          ),
          unknownBucket: UnknownCostBucket(
            orders: orders - ordersCosted,
            revenueExcluded: revenueExcluded,
          ),
          series: series,
          products: products,
          statusCounts: {
            'delivered': delivered,
            'on_a_way': onAWay,
            'cooking': cooking,
            'accepted': accepted,
            'new': fresh,
            'cancelled': cancelled,
          },
        ),
      ),
    );
  }

  /// One Profit-by-product row carrying a cost snapshot. `cost` is derived
  /// from the window margin so Price/Cost/Margin stays internally consistent
  /// with the row's own profit.
  static ProductProfit _costedProduct({
    required String id,
    required String name,
    required double share,
    required double price,
    required double costedRevenue,
    required double marginPct,
  }) {
    final revenue = costedRevenue * share;
    return ProductProfit(
      id: id,
      name: name,
      sold: price <= 0 ? 0 : (revenue / price).round(),
      revenue: revenue,
      price: price,
      cost: price * (1 - marginPct / 100),
      profit: revenue * marginPct / 100,
      marginPct: marginPct,
    );
  }

  /// A monotonic day ordinal. Deliberately not a `difference()` in days:
  /// this needs a stable index per calendar date, not an elapsed duration.
  static int _ordinal(DateTime day) =>
      day.year * 372 + day.month * 31 + day.day;

  static String _pad(int value) => value.toString().padLeft(2, '0');

  /// `yyyy-MM-dd`, the wire shape a day bucket carries.
  static String _isoDay(DateTime day) =>
      '${day.year.toString().padLeft(4, '0')}-'
      '${_pad(day.month)}-${_pad(day.day)}';
}

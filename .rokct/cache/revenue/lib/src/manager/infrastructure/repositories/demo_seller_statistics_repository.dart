// Copyright (c) 2026 RokctAI
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
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
class DemoSellerStatisticsRepository
    implements SellerStatisticsRepositoryFacade {
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
}

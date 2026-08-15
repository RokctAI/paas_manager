import 'package:flutter/material.dart';
import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revenue_sdk/src/manager/application/statistics/statistics_state.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_order_response.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_response.dart';

/// Straight port of `paas_manager`'s `StatisticsNotifier`.
///
/// The dead `addListInfo()` (a fully commented-out `charts_flutter_new` series
/// builder) is dropped; everything else, including the [addChartInfo] price/time
/// axis derivation, is carried over unchanged.
class StatisticsNotifier extends StateNotifier<StatisticsState> {
  StatisticsNotifier(this._repository) : super(const StatisticsState());

  final SellerStatisticsRepositoryFacade _repository;
  int page = 1;

  Future<void> fetchStatistics({
    required DateTime endTime,
    required DateTime startTime,
  }) async {
    if (state.countData == null) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _repository.getStatistics(
      startTime: startTime,
      endTime: endTime,
    );
    response.when(
      success: (data) {
        if (state.countData == null) {
          state = state.copyWith(countData: data.data, isLoading: false);
        } else {
          state = state.copyWith(countData: data.data);
        }
        addChartInfo(
          chart: data.data?.chart ?? [],
          startTime: startTime,
          endTime: endTime,
        );
      },
      failure: (fail, status) {
        if (state.countData == null) {
          state = state.copyWith(isLoading: false);
        }
        debugPrint('==> error with fetching statistics $fail');
      },
    );
  }

  Future<void> fetchStatisticsOrder({
    DateTime? endTime,
    DateTime? startTime,
  }) async {
    page = 1;
    state = state.copyWith(isLoading: true, isRefresh: true);
    final response = await _repository.getStatisticsOrder(
      startTime: startTime,
      endTime: endTime,
      page: 1,
    );
    response.when(
      success: (data) {
        state = state.copyWith(listOfOrder: data.data ?? [], isLoading: false);
      },
      failure: (fail, status) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> error with fetching statistics $fail');
      },
    );
  }

  Future<void> fetchStatisticsOrderByDay({
    DateTime? endTime,
    DateTime? startTime,
  }) async {
    page = 1;
    state = state.copyWith(isLoading: true, isRefresh: false);
    final response = await _repository.getStatisticsOrder(
      startTime: startTime,
      endTime: endTime,
      page: 1,
      perPage: 100,
    );
    response.when(
      success: (data) {
        state = state.copyWith(listOfOrder: data.data ?? [], isLoading: false);
      },
      failure: (fail, status) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> error with fetching statistics $fail');
      },
    );
  }

  Future<void> fetchStatisticsOrderPage({
    DateTime? endTime,
    DateTime? startTime,
    RefreshController? refreshController,
  }) async {
    final response = await _repository.getStatisticsOrder(
      startTime: startTime,
      endTime: endTime,
      page: ++page,
    );
    response.when(
      success: (data) {
        final List<StatisticsOrder> newList = List.from(state.listOfOrder);
        newList.addAll(data.data ?? []);
        refreshController?.loadComplete();
        state = state.copyWith(listOfOrder: newList);
      },
      failure: (fail, status) {
        refreshController?.loadNoData();
        if (state.countData == null) {
          state = state.copyWith(isLoading: false);
        }
        debugPrint('==> error with fetching statistics $fail');
      },
    );
  }

  void addChartInfo({
    required List<Chart> chart,
    required DateTime endTime,
    required DateTime startTime,
  }) {
    List<num> prices = [];
    List<DateTime> times = [];
    if (chart.isNotEmpty) {
      num price = chart.first.totalPrice ?? 0;
      for (final element in chart) {
        if (price < (element.totalPrice ?? 0)) {
          price = element.totalPrice ?? 0;
        }
      }
      final num a = price / 6;
      prices = List.generate(7, (index) => (price - (index * a)));
      times = List.generate(
        startTime.difference(endTime).inDays == 1
            ? 24
            : startTime.difference(endTime).inDays,
        (index) => DateTime.now().subtract(
          startTime.difference(endTime).inDays == 1
              ? Duration(hours: index)
              : Duration(days: index),
        ),
      );
    }

    state = state.copyWith(
      prices: prices.reversed.toList(),
      time: times,
      isLoading: false,
    );
  }
}

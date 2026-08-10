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

// import 'package:charts_flutter_new/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'statistics_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class StatisticsNotifier extends StateNotifier<StatisticsState> {
  final UsersInterface _usersRepository;
  int page = 1;

  StatisticsNotifier(this._usersRepository) : super(const StatisticsState());

  Future<void> fetchStatistics(
      {required DateTime endTime, required DateTime startTime}) async {
    if (state.countData == null) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _usersRepository.getStatistics(
        startTime: startTime, endTime: endTime);
    response.when(
      success: (data) {
        if (state.countData == null) {
          state = state.copyWith(countData: data.data, isLoading: false);
        } else {
          state = state.copyWith(countData: data.data);
        }
        addListInfo();
        addChartInfo(
            chart: data.data?.chart ?? [],
            startTime: startTime,
            endTime: endTime);
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
    final response = await _usersRepository.getStatisticsOrder(
        startTime: startTime, endTime: endTime, page: 1);
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

  Future<void> fetchStatisticsOrderByDay(
      {DateTime? endTime, DateTime? startTime}) async {
    page = 1;
    state = state.copyWith(isLoading: true, isRefresh: false);
    final response = await _usersRepository.getStatisticsOrder(
        startTime: startTime, endTime: endTime, page: 1, perPage: 100);
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

  Future<void> fetchStatisticsOrderPage(
      {DateTime? endTime,
      DateTime? startTime,
      RefreshController? refreshController}) async {
    final response = await _usersRepository.getStatisticsOrder(
        startTime: startTime, endTime: endTime, page: ++page);
    response.when(
      success: (data) {
        List<StatisticsOrder> newList = List.from(state.listOfOrder);
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

  addListInfo() {
    // List<OrdinalSales> day = [];
    //
    // state.countData?.chart?.forEach((element) {
    //   day.add(OrdinalSales(
    //     day: DateFormat("dd MMM").format(element.time ?? DateTime.now()),
    //     sales: element.totalPrice?.floor() ?? 0,
    //   ));
    // });
    // List<Series<OrdinalSales, String>> newList = [];
    // newList.add(
    //   Series(
    //     id: "chart",
    //     data: day,
    //     domainFn: (OrdinalSales sales, _) => sales.day,
    //     measureFn: (OrdinalSales sales, _) => sales.sales,
    //     seriesColor: ColorUtil.fromDartColor(Style.primary),
    //   ),
    // );
    // state = state.copyWith(list: newList);
  }

  addChartInfo({
    required List<Chart> chart,
    required DateTime endTime,
    required DateTime startTime,
  }) {
    List<num> prices = [];
    List<DateTime> times = [];
    if (chart.isNotEmpty) {
      num price = chart.first.totalPrice ?? 0;
      for (var element in chart) {
        if (price < (element.totalPrice ?? 0)) {
          price = element.totalPrice ?? 0;
        }
      }
      num a = price / 6;
      prices = List.generate(7, (index) => (price - (index * a)));
      times = List.generate(
        startTime.difference(endTime).inDays == 1
            ? 24
            : startTime.difference(endTime).inDays,
        (index) => DateTime.now().subtract(
            startTime.difference(endTime).inDays == 1
                ? Duration(hours: index)
                : Duration(days: index)),
      );
    }

    state = state.copyWith(
        prices: prices.reversed.toList(), time: times, isLoading: false);
  }
}

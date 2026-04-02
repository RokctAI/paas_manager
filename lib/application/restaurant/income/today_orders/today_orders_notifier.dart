import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'today_orders_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class TodayOrdersNotifier extends StateNotifier<TodayOrdersState> {
  final OrdersInterface _ordersRepository;

  TodayOrdersNotifier(this._ordersRepository) : super(const TodayOrdersState());

  Future<void> fetchTodayOrders() async {
    if (state.ordersStatistic == null) {
      state = state.copyWith(isLoading: true);
    }
    final date = DateTime.now().toString().substring(0, 10);
    final response = await _ordersRepository.getOrders(from: date, to: date);
    response.when(
      success: (data) {
        final List<OrderData> orders = data.data?.orders ?? [];
        OrderData? lastOrder;
        if (orders.isNotEmpty) {
          lastOrder = orders.first;
        }
        if (state.ordersStatistic == null) {
          state = state.copyWith(
            ordersStatistic: data.data?.statistic,
            lastOrder: lastOrder,
            todayOrders: orders,
            isLoading: false,
          );
        } else {
          state = state.copyWith(
            ordersStatistic: data.data?.statistic,
            lastOrder: lastOrder,
            todayOrders: orders,
          );
        }
      },
      failure: (fail, status) {
        if (state.ordersStatistic == null) {
          state = state.copyWith(isLoading: false);
        }
        debugPrint('==> error order statistics $fail');
      },
    );
  }
}

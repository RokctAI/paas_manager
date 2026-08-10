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
      failure: (fail,status) {
        if (state.ordersStatistic == null) {
          state = state.copyWith(isLoading: false);
        }
        debugPrint('==> error order statistics $fail');
      },
    );
  }
}

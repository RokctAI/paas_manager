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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';

import 'new_orders_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class NewOrdersNotifier extends StateNotifier<NewOrdersState> {
  final OrdersInterface _ordersRepository;
  int _page = 0;
  bool _hasMore = true;

  NewOrdersNotifier(this._ordersRepository)
      : super(NewOrdersState(refreshController: RefreshController()));

  Future<void> fetchNewOrders({
    required BuildContext context,
    bool isRefresh = false,
    Function(int)? updateTotal,
    required int activeTabIndex,
  }) async {
    if (isRefresh) {
      _page = 0;
      _hasMore = true;
      if (activeTabIndex == 0) {
        state.refreshController?.requestRefresh();
      }
      state.refreshController?.resetNoData();
    }
    if (!_hasMore) {
      state.refreshController?.loadNoData();
      return;
    }
    if (_page == 0 && !isRefresh) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _ordersRepository.getOrders(
      status: OrderStatus.newOrder,
      page: ++_page,
    );
    response.when(
      success: (data) {
        List<OrderData> orders = isRefresh ? [] : List.from(state.orders);
        final List<OrderData> newOrders = data.data?.orders ?? [];
        orders.addAll(newOrders);
        _hasMore = newOrders.length >= 10;
        if (_page == 1 && !isRefresh) {
          state = state.copyWith(
            isLoading: false,
            orders: orders,
            totalCount: data.data?.statistic?.newOrdersCount ?? 0,
          );
          updateTotal?.call(data.data?.statistic?.newOrdersCount ?? 0);
        } else {
          state = state.copyWith(
            orders: orders,
            totalCount: data.data?.statistic?.newOrdersCount ?? 0,
          );
          updateTotal?.call(data.data?.statistic?.newOrdersCount ?? 0);
        }
        if (isRefresh) {
          state.refreshController?.refreshCompleted();
        } else {
          state.refreshController?.loadComplete();
        }
      },
      failure: (failure,status) {
        _page--;
        if (_page == 0) {
          state = state.copyWith(isLoading: false);
        }
        if (isRefresh) {
          state.refreshController?.refreshFailed();
        } else {
          state.refreshController?.loadFailed();
        }
        if(status == 401){
          LocalStorage.logout();
          context.router.popUntilRoot();
          context.replaceRoute(const LoginRoute());
        }
      },
    );
  }
}

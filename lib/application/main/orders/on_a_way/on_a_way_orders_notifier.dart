import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'on_a_way_orders_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class OnAWayOrdersNotifier extends StateNotifier<OnAWayOrdersState> {
  final OrdersInterface _ordersRepository;
  int _page = 0;
  bool _hasMore = true;

  OnAWayOrdersNotifier(this._ordersRepository)
    : super(const OnAWayOrdersState());

  Future<void> fetchOnAWayOrders({
    RefreshController? refreshController,
    bool isRefresh = false,
    Function(int)? updateTotal,
  }) async {
    if (isRefresh) {
      _page = 0;
      _hasMore = true;
      refreshController?.requestRefresh();
    }
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    if (_page == 0 && !isRefresh) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _ordersRepository.getOrders(
      status: OrderStatus.onAWay,
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
            totalCount: data.data?.statistic?.onAWayOrdersCount ?? 0,
          );
          updateTotal?.call(data.data?.statistic?.onAWayOrdersCount ?? 0);
        } else {
          state = state.copyWith(
            orders: orders,
            totalCount: data.data?.statistic?.onAWayOrdersCount ?? 0,
          );
          updateTotal?.call(data.data?.statistic?.onAWayOrdersCount ?? 0);
        }
        if (isRefresh) {
          refreshController?.refreshCompleted();
        } else {
          refreshController?.loadComplete();
        }
      },
      failure: (failure, status) {
        _page--;
        if (_page == 0) {
          state = state.copyWith(isLoading: false);
        }
        if (isRefresh) {
          refreshController?.refreshFailed();
        } else {
          refreshController?.loadFailed();
        }
      },
    );
  }
}

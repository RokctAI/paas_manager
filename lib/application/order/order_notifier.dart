import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final OrdersInterface _ordersRepository;
  int _page = 0;
  bool _hasMore = true;
  int _canceledPage = 0;
  int _deliveredPage = 0;

  OrderNotifier(this._ordersRepository) : super(const OrderState());

  void changeDeliveryType(int index) {
    state = state.copyWith(deliveryType: index);
  }

  void changeDeliveryTime(int index) {
    state = state.copyWith(deliveryTime: index);
  }

  void changePaymentType(bool isActive) {
    state = state.copyWith(paymentType: isActive);
  }

  Future<void> fetchHistoryOrders({
    RefreshController? refreshController,
    bool isRefresh = false,
    DateTime? start,
    DateTime? end,
  }) async {
    if (isRefresh) {
      _page = 0;
      _hasMore = true;
      state = state.copyWith(isLoading: true);
      refreshController?.requestRefresh();
    }
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    if (_page == 0 && !isRefresh) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _ordersRepository.getHistoryOrders(
      page: ++_page,
      from: start != null ? DateFormat("yyyy-MM-dd").format(start) : null,
      to: end != null ? DateFormat("yyyy-MM-dd").format(end) : null,
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
            totalCount:
                (data.data?.statistic?.deliveredOrdersCount ?? 0) +
                (data.data?.statistic?.cancelOrdersCount ?? 0),
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            orders: orders,
            totalCount:
                (data.data?.statistic?.deliveredOrdersCount ?? 0) +
                (data.data?.statistic?.cancelOrdersCount ?? 0),
          );
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

  Future<void> fetchCanceledOrders({
    RefreshController? refreshController,
    bool isRefresh = false,
    DateTime? start,
    DateTime? end,
  }) async {
    if (isRefresh) {
      _canceledPage = 0;
      _hasMore = true;
      state = state.copyWith(isLoading: true);
      refreshController?.requestRefresh();
    }
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    if (_canceledPage == 0 && !isRefresh) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _ordersRepository.getHistoryOrders(
      status: "canceled",
      page: ++_canceledPage,
      from: start != null ? DateFormat("yyyy-MM-dd").format(start) : null,
      to: end != null ? DateFormat("yyyy-MM-dd").format(end) : null,
    );
    response.when(
      success: (data) {
        List<OrderData> orders = isRefresh ? [] : List.from(state.canceledOrders);
        final List<OrderData> newOrders = data.data?.orders ?? [];
        orders.addAll(newOrders);
        _hasMore = newOrders.length >= 10;
        if (_canceledPage == 1 && !isRefresh) {
          state = state.copyWith(
            isLoading: false,
            canceledOrders: orders,
            totalCanceledOrderCount:
                (data.data?.statistic?.cancelOrdersCount ?? 0),
              totalCount: (data.data?.statistic?.cancelOrdersCount ?? 0)
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            canceledOrders: orders,
            totalCanceledOrderCount:
                (data.data?.statistic?.cancelOrdersCount ?? 0),
              totalCount: (data.data?.statistic?.cancelOrdersCount ?? 0)
          );
        }
        if (isRefresh) {
          refreshController?.refreshCompleted();
        } else {
          refreshController?.loadComplete();
        }
      },
      failure: (failure, status) {
        _canceledPage--;
        if (_canceledPage == 0) {
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

  Future<void> fetchDeliveredOrders({
    RefreshController? refreshController,
    bool isRefresh = false,
    DateTime? start,
    DateTime? end,
  }) async {
    if (isRefresh) {
      _deliveredPage = 0;
      _hasMore = true;
      refreshController?.requestRefresh();
    }
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    if (_deliveredPage == 0 && !isRefresh) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _ordersRepository.getHistoryOrders(
      status: "delivered",
      page: ++_deliveredPage,
      from: start != null ? DateFormat("yyyy-MM-dd").format(start) : null,
      to: end != null ? DateFormat("yyyy-MM-dd").format(end) : null,
    );
    response.when(
      success: (data) {
        List<OrderData> orders = isRefresh ? [] : List.from(state.deliveredOrders);
        final List<OrderData> newOrders = data.data?.orders ?? [];
        orders.addAll(newOrders);
        _hasMore = newOrders.length >= 10;
        if (_deliveredPage == 1 && !isRefresh) {
          state = state.copyWith(
            isLoading: false,
            deliveredOrders: orders,
            totalDeliveredOrderCount: (data.data?.statistic?.deliveredOrdersCount ?? 0),
              totalCount: (data.data?.statistic?.deliveredOrdersCount ?? 0)
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            deliveredOrders: orders,
            totalDeliveredOrderCount: (data.data?.statistic?.deliveredOrdersCount ?? 0),
            totalCount: (data.data?.statistic?.deliveredOrdersCount ?? 0)
          );
        }
        if (isRefresh) {
          refreshController?.refreshCompleted();
        } else {
          refreshController?.loadComplete();
        }
      },
      failure: (failure, status) {
        _deliveredPage--;
        if (_deliveredPage == 0) {
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

 void changeIndex(int? index) {
    state = state.copyWith(totalCount: (index ?? 0)==0?state.totalDeliveredOrderCount : state.totalCanceledOrderCount);
  }

}

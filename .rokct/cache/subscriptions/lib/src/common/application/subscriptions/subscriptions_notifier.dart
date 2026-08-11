import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:base_sdk/base_sdk.dart';
import '../../domain/interface/subscription_facade.dart';
import '../../domain/interface/subscription_payments_provider.dart';
import '../../infrastructure/models/data/subscriptions_data.dart';
import 'subscriptions_state.dart';

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionsFacade _subscriptionRepository;
  final SubscriptionPaymentsProvider _paymentsRepo;
  final num Function()? _getWalletPrice;
  final Future<void> Function(BuildContext context, String url)?
  _onNavigateToWebView;
  final void Function(BuildContext context, String message)? _onError;
  final String Function(String key)? _getTranslation;

  int _page = 0;

  SubscriptionNotifier(
    this._subscriptionRepository,
    this._paymentsRepo, {
    num Function()? getWalletPrice,
    Future<void> Function(BuildContext context, String url)?
    onNavigateToWebView,
    void Function(BuildContext context, String message)? onError,
    String Function(String key)? getTranslation,
  }) : _getWalletPrice = getWalletPrice,
       _onNavigateToWebView = onNavigateToWebView,
       _onError = onError,
       _getTranslation = getTranslation,
       super(const SubscriptionState());

  Future<void> fetchSubscriptions({
    BuildContext? context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(list: [], isLoading: true);
    }
    final res = await _subscriptionRepository.getSubscriptions(page: ++_page);
    res.when(
      success: (data) {
        List<SubscriptionData> list = List.from(state.list);
        list.addAll(data.data ?? []);
        state = state.copyWith(isLoading: false, list: list);
        if (isRefresh ?? false) {
          controller?.refreshCompleted();
          return;
        } else if (data.data?.isEmpty ?? true) {
          controller?.loadNoData();
          return;
        }
        controller?.loadComplete();
        return;
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        debugPrint(" ==> fetch ads fail: $failure");
        if (context != null && _onError != null) {
          _onError?.call(context, failure);
        }
      },
    );
  }

  Future<void> payment(
    BuildContext context, {
    required VoidCallback onSuccess,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isPaymentLoading: true);
    if ((state.payments?[state.selectPayment].tag ?? "") == 'wallet') {
      final num walletPrice = _getWalletPrice?.call() ?? 0;
      final num orderPrice = state.list[state.selectSubscribe].price ?? 0;
      if (walletPrice < orderPrice) {
        if (_onError != null && _getTranslation != null) {
          _onError?.call(
            context,
            _getTranslation?.call(TrKeys.notEnoughMoney) ?? "Not enough money",
          );
        }
        state = state.copyWith(isPaymentLoading: false);
        return;
      }

      final res = await _subscriptionRepository.purchaseSubscription(
        id: state.list[state.selectSubscribe].id ?? 0,
        paymentId: state.payments?[state.selectPayment].id ?? 0,
      );
      res.when(
        success: (success) async {
          final response = await _subscriptionRepository.createTransaction(
            id: success,
            paymentId: state.payments?[state.selectPayment].id ?? 0,
          );
          response.when(
            success: (success) {
              onSuccess.call();
              state = state.copyWith(isPaymentLoading: false);
            },
            failure: (failure, status) {
              state = state.copyWith(isPaymentLoading: false);
            },
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isPaymentLoading: false);
          if (_onError != null) {
            _onError?.call(context, failure);
          }
        },
      );
    } else {
      final res = await _paymentsRepo.paymentSubscriptionWebView(
        name: state.payments?[state.selectPayment].tag ?? "",
        subscriptionId: state.list[state.selectSubscribe].id ?? 0,
      );
      res.when(
        success: (data) async {
          state = state.copyWith(isPaymentLoading: false);
          if (_onNavigateToWebView != null) {
            await _onNavigateToWebView!
                .call(context, data)
                .whenComplete(() => onSuccess());
          }
        },
        failure: (failure, status) {
          state = state.copyWith(isPaymentLoading: false);
          if (_onError != null) {
            _onError?.call(context, failure);
          }
        },
      );
    }
  }

  Future<void> fetchPayments({required BuildContext context}) async {
    final res = await _paymentsRepo.getPaymentMethods();
    res.when(
      success: (data) {
        final list =
            data.where((method) => method.tag != "cash").toList();
        state = state.copyWith(payments: list, selectPayment: 0);
      },
      failure: (failure, status) {
        if (_onError != null) {
          _onError?.call(context, failure);
        }
      },
    );
  }

  void selectPayment({required int index}) {
    state = state.copyWith(selectPayment: index);
  }

  void selectSubscribe({required int index}) {
    state = state.copyWith(selectSubscribe: index);
  }
}

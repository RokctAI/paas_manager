import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'order_payment_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class OrderPaymentNotifier extends StateNotifier<OrderPaymentState> {
  final OrdersInterface _ordersRepository;

  OrderPaymentNotifier(this._ordersRepository)
      : super(const OrderPaymentState());

  void setSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void clearSelectedPaymentInfo() {
    state = state.copyWith(selectedIndex: 0);
  }

  void setSelectedPayment(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void clearAll() {
    state = state.copyWith(orderCalculate: null);
  }

  Future<void> fetchPayments(String type) async {
    state = state.copyWith(isLoading: true);
    final response = await _ordersRepository.getPayments();
    response.when(
      success: (data) {
        List<PaymentData> payments = data.data ?? [];
        List<PaymentData> filtered = [];
        for (final payment in payments) {
          if (type != TrKeys.delivery && payment.tag?.toLowerCase() == 'cash') {
            filtered.add(payment);
            break;
          } else {
            if (payment.tag?.toLowerCase() == 'wallet' ||
                payment.tag?.toLowerCase() == 'cash') {
              filtered.add(payment);
            }
          }
        }
        state = state.copyWith(
          payments: filtered,
          selectedIndex: 0,
          isLoading: false,
        );
      },
      failure: (error, status) {
        debugPrint('====> fetch payments fail $error');
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> createTransaction(
      BuildContext context, int orderId, int? paymentId) async {
    var response = await _ordersRepository.createTransaction(
        orderId: orderId, paymentId: paymentId ?? 0);
    response.when(
      success: (data) {},
      failure: (error, status) {
        debugPrint('====> fetch payments fail $error');
        AppHelpers.showCheckTopSnackBar(context,
            text: error, type: SnackBarType.error);
      },
    );
  }

  Future<void> getCalculate({
    required List<Stock> stocks,
    required String type,
    LocationData? location,
  }) async {
    state = state.copyWith(isCalculateLoading: true);
    final response = await _ordersRepository.getCalculate(
      stocks: stocks,
      type: type,
      location: location,
    );
    response.when(
      success: (data) {
        state = state.copyWith(
          orderCalculate: data.data,
          isCalculateLoading: false,
        );
      },
      failure: (error, status) {
        debugPrint('====> get calculate fail $error');
        state = state.copyWith(isCalculateLoading: false);
      },
    );
  }
}

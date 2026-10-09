// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:base_sdk/src/di/injection.dart';
import 'package:base_sdk/src/domain/interface/payments.dart';
import 'package:base_sdk/src/models/models.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:base_sdk/src/handlers/platform_gateway.dart';
import 'package:base_sdk/src/models/data/saved_card.dart';

class PaymentsRepository implements PaymentsRepositoryFacade {
  /// Universal platform gateway: every call POSTs `{"cmd", "payload"}` to
  /// the one gateway path. `cmd` is the wallet frappe manifest's
  /// whitelisted-method key with the app prefix stripped
  /// (`{app_name}.api.payment.*` -> `api.payment.*`).
  static const _gateway = PlatformGateway();

  /// FrappeResponseInterceptor already unwraps the top-level `message`
  /// envelope on 2xx; tolerate both shapes for overridden clients.
  static dynamic _unwrap(dynamic body) =>
      body is Map && body.containsKey('message') && body.length == 1
      ? body['message']
      : body;

  @override
  Future<ApiResult<PaymentsResponse>> getPayments() async {
    try {
      // get_payment_gateways returns a bare list of gateway rows.
      final data = _unwrap(
        await _gateway.tenant('api.payment.get_payment_gateways'),
      );
      return ApiResult.success(
        data: PaymentsResponse.fromJson(data is List ? {'data': data} : data),
      );
    } catch (e) {
      debugPrint('==> get payments failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<TransactionsResponse>> createTransaction({
    required String orderId,
    required String paymentId,
  }) async {
    try {
      // create_transaction returns {timestamp, status, message, data}.
      final data = await _gateway.tenant('api.payment.create_transaction', {
        'order_id': orderId,
        'payment_id': paymentId,
      });
      return ApiResult.success(data: TransactionsResponse.fromJson(data));
    } catch (e) {
      debugPrint('==> create transaction failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<List<SavedCardModel>>> getSavedCards() async {
    try {
      // get_saved_cards returns a bare list of Saved Card rows
      // (name/gateway/last_four/card_type/expiry_date/card_holder_name).
      final data = _unwrap(await _gateway.tenant('api.payment.get_saved_cards'));
      final rows = data is List ? data : const [];
      return ApiResult.success(
        data: rows
            .whereType<Map>()
            .map(
              (e) => SavedCardModel(
                id: (e['id'] ?? e['name'])?.toString() ?? '',
                lastFour: e['last_four']?.toString() ?? '',
                cardType: e['card_type']?.toString() ?? 'Card',
                expiryDate: e['expiry_date']?.toString() ?? '',
                cardHolderName: e['card_holder_name']?.toString() ?? '',
              ),
            )
            .toList(),
      );
    } catch (e) {
      debugPrint('==> get saved cards failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  // Implementing Card specific methods first
  @override
  Future<ApiResult<String>> tokenizeCard({
    required String cardNumber,
    required String cardName,
    required String expiryDate,
    required String cvc,
  }) async {
    try {
      final data = _unwrap(
        await _gateway.tenant('api.payment.tokenize_card', {
          'card_number': cardNumber,
          'card_holder': cardName,
          'expiry_date': expiryDate,
          'cvc': cvc,
        }),
      );
      // The gateway reuse credential stays on the server. tokenize_card
      // returns {name, last_four, card_type, expiry_date}; `name` is the
      // Saved Card docname the charge endpoints take.
      final name = data is Map ? data['name']?.toString() : null;
      if (name == null || name.isEmpty) {
        throw StateError('tokenize_card returned no Saved Card name');
      }
      return ApiResult.success(data: name);
    } catch (e) {
      debugPrint('==> tokenize card failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<String>> tokenizeAfterPayment(
    String cardNumber,
    String cardName,
    String expiryDate,
    String cvc, [
    String? token,
    String? lastFour,
    String? cardType,
  ]) async {
    // tokenize_card saves the card and returns its Saved Card docname. The
    // gateway reuse credential stays on the server and never reaches this
    // client.
    return tokenizeCard(
      cardNumber: cardNumber,
      cardName: cardName,
      expiryDate: expiryDate,
      cvc: cvc,
    );
  }

  @override
  Future<ApiResult<bool>> deleteCard(String cardId) async {
    try {
      await _gateway.tenant('api.payment.delete_card', {'card_name': cardId});
      return const ApiResult.success(data: true);
    } catch (e) {
      debugPrint('==> delete card failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<bool>> setDefaultCard(String cardId) async {
    // Intentional no-op: the backend has no default-card flag; the picker
    // keeps the selection locally.
    return const ApiResult.success(data: true);
  }

  /// The card endpoints charge an existing Order (they check ownership and
  /// read its total), but checkout hands this SDK the cart body. Create the
  /// order first and return its id.
  Future<String> _createOrderId(OrderBodyData orderData) async {
    final result = await ordersRepository.createOrder(orderData);
    String? orderId;
    String? error;
    result.when(
      success: (order) => orderId = order.id,
      failure: (e, _) => error = e,
    );
    if (orderId == null || orderId!.isEmpty) {
      throw StateError(error ?? 'Order could not be created');
    }
    return orderId!;
  }

  static String _transactionId(dynamic body, String fallback) {
    final data = _unwrap(body);
    if (data is Map && data['transaction_id'] != null) {
      return data['transaction_id'].toString();
    }
    return fallback;
  }

  @override
  Future<ApiResult<String>> processTokenPayment(
    OrderBodyData orderData,
    String savedCardId,
  ) async {
    try {
      final orderId = await _createOrderId(orderData);
      // `saved_card`, not `token`: the gateway reuse credential is
      // server-side only, so the card is named by its docname.
      final body = await _gateway.tenant('api.payment.process_token_payment', {
        'order_id': orderId,
        'saved_card': savedCardId,
      });
      return ApiResult.success(data: _transactionId(body, orderId));
    } catch (e) {
      debugPrint('==> token payment failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<String>> processDirectCardPayment(
    OrderBodyData orderBody,
    String cardNumber,
    String cardName,
    String expiryDate,
    String cvc,
  ) async {
    try {
      final orderId = await _createOrderId(orderBody);
      final body = await _gateway
          .tenant('api.payment.process_direct_card_payment', {
            'order_id': orderId,
            'card_number': cardNumber,
            'card_holder': cardName,
            'expiry_date': expiryDate,
            'cvc': cvc,
          });
      return ApiResult.success(data: _transactionId(body, orderId));
    } catch (e) {
      debugPrint('==> direct card payment failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

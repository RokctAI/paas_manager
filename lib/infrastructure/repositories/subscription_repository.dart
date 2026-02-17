import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'package:venderfoodyman/domain/handlers/api_result.dart';
import 'package:venderfoodyman/domain/handlers/network_exceptions.dart';
import 'package:venderfoodyman/domain/interface/subscription_facade.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import '../services/services.dart';

class SubscriptionsRepository implements SubscriptionsFacade {
  @override
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({
    required int page,
  }) async {
    final data = {'lang': LocalStorage.getLanguage()?.locale};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/subscriptions',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SubscriptionResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get subscription failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult> purchaseSubscription({
    required int id,
    required int paymentId,
  }) async {
    final data = {'payment_sys_id': paymentId};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/subscriptions/$id/attach',
        data: data,
      );
      return ApiResult.success(data: response.data['data']['id']);
    } catch (e) {
      debugPrint('==> purchase ads failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int id,
    required int paymentId,
  }) async {
    final data = {'payment_sys_id': paymentId};
    debugPrint('===> create transaction body: ${jsonEncode(data)}');
    debugPrint('===> create transaction subscriptions id: $id');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/payments/subscription/$id/transactions',
        data: data,
      );
      return ApiResult.success(
        data: TransactionsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create transaction failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

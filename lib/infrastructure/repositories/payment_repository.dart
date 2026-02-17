import 'package:flutter/material.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'package:venderfoodyman/domain/handlers/api_result.dart';
import 'package:venderfoodyman/domain/handlers/network_exceptions.dart';
import '../../domain/interface/payment_facade.dart';
import '../models/models.dart';
import '../services/services.dart';

class PaymentRepository implements PaymentsFacade {
  @override
  Future<ApiResult<PaymentsResponse>> getPayments() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/payments',
        queryParameters: {"lang": LocalStorage.getLanguage()?.locale ?? 'en'},
      );
      return ApiResult.success(data: PaymentsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get payments error: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<NonExistPaymentResponse>> getNonExistPayments() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shop-payments/shop-non-exist',
        queryParameters: {"lang": LocalStorage.getLanguage()?.locale ?? 'en'},
      );
      return ApiResult.success(
        data: NonExistPaymentResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get non exist payments error: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<String>> paymentWalletWebView({
    required String name,
    required num price,
  }) async {
    try {
      final data = {
        'wallet_id': LocalStorage.getUser()?.wallet?.uuid ?? 0,
        'total_price': price,
        "currency_id": LocalStorage.getSelectedCurrency()?.id,
      };

      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/user/$name-process',
        data: data,
      );

      return ApiResult.success(data: res.data["data"]["data"]["url"] ?? "");
    } catch (e) {
      debugPrint('==> web view wallet failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<MaksekeskusResponse>> paymentMaksekeskusView({
    num? price,
  }) async {
    try {
      final data = {
        'wallet_id': LocalStorage.getUser()?.wallet?.uuid,
        'total_price': price ?? 0,
        "currency_id": LocalStorage.getSelectedCurrency()?.id,
      };
      debugPrint('==> payment maksekeskus request: $data');
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/user/maksekeskus-process',
        data: data,
      );

      return ApiResult.success(
        data: MaksekeskusResponse.fromJson(res.data["data"]),
      );
    } catch (e) {
      debugPrint('==> payment maksekeskus  failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<String>> paymentSubscriptionWebView({
    required String name,
    required int subscriptionId,
  }) async {
    try {
      final data = {
        'subscription_id': subscriptionId,
        "currency_id": LocalStorage.getSelectedCurrency()?.id,
      };

      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/user/$name-process',
        data: data,
      );

      return ApiResult.success(data: res.data["data"]["data"]["url"] ?? "");
    } catch (e) {
      debugPrint('==> web view wallet failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<bool>> sendWallet({
    required String uuid,
    required num price,
  }) async {
    try {
      final data = {
        'uuid': uuid,
        'price': price,
        "currency_id": LocalStorage.getSelectedCurrency()?.id,
      };
      final client = dioHttp.client(requireAuth: true);
      await client.post('/api/v1/dashboard/user/wallet/send', data: data);
      return const ApiResult.success(data: true);
    } catch (e) {
      debugPrint('==> send wallet failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

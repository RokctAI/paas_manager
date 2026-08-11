import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:base_sdk/base_sdk.dart';
import 'package:base_sdk/src/database/app_database.dart';
import '../../domain/interface/subscription_facade.dart';
import '../models/data/subscriptions_data.dart';
import '../models/response/subscriptions_response.dart';
import '../models/response/transactions_response.dart';

class SubscriptionsRepository implements SubscriptionsFacade {
  final Dio _client;
  final AppDatabase _database;
  final String? Function()? _localeCallback;

  SubscriptionsRepository(this._client, this._database, {String? Function()? localeCallback})
    : _localeCallback = localeCallback;

  @override
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({
    required int page,
    String? locale,
  }) async {
    final activeLocale = locale ?? _localeCallback?.call();
    final data = {'lang': activeLocale};
    try {
      final response = await _client.get(
        '/api/v1/dashboard/seller/subscriptions',
        queryParameters: data,
      );
      final subResponse = SubscriptionResponse.fromJson(response.data);

      // Cache the active subscription (status + allowed subjects) locally so
      // offline consumers like BackgroundAssetOrchestrator can read it.
      if (subResponse.data != null && subResponse.data!.isNotEmpty) {
        final activeSub = subResponse.data!.firstWhere(
          (element) => element.active == true,
          orElse: () => subResponse.data!.first,
        );
        await _cacheActiveSubscription(activeSub);
      }

      return ApiResult.success(
        data: subResponse,
      );
    } catch (e, s) {
      debugPrint('==> get subscription failure: $e,$s');
      return ApiResult.failure(
        error: NetworkHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  /// Writes the active subscription into the shared database's generic
  /// 'user_subscriptions' box, keyed by
  /// the authenticated user. The user is persisted at login by auth_sdk and
  /// exposed through [LocalStorage.getUser]. If the API response omitted the
  /// subjects field, the last-known-good cached value is preserved instead of
  /// being overwritten. Failures are logged loudly but never break the
  /// network result the caller is waiting on.
  Future<void> _cacheActiveSubscription(SubscriptionData activeSub) async {
    final userId = LocalStorage.getUser()?.id?.toString();
    if (userId == null || userId.isEmpty) {
      debugPrint(
        '==> skipping subscription cache write: no authenticated user in session',
      );
      return;
    }

    try {
      final apiSubjects =
          activeSub.allowedSubjects ?? activeSub.subscription?.allowedSubjects;

      String subjectsJson;
      if (apiSubjects != null) {
        subjectsJson = jsonEncode(apiSubjects);
      } else {
        // Field missing from the response: keep the last-known-good value.
        final existing =
            await _database.getItem('user_subscriptions', userId);
        subjectsJson = existing?['allowedSubjects'] as String? ?? '[]';
      }

      await _database.putItem('user_subscriptions', userId, {
        'userId': userId,
        'status': activeSub.type ?? 'inactive',
        'active': activeSub.active ?? false,
        'expiryDate': activeSub.expiredAt?.toIso8601String(),
        'allowedSubjects': subjectsJson,
      });
    } catch (dbErr, st) {
      debugPrint('==> subscription local cache write failure: $dbErr\n$st');
    }
  }

  @override
  Future<ApiResult> purchaseSubscription({
    required int id,
    required int paymentId,
    String? beneficiaryUserId,
  }) async {
    final data = {
      'payment_sys_id': paymentId,
      // Delegated billing (see the facade doc): only sent when purchasing
      // for another account, so the self-purchase wire shape is unchanged.
      if (beneficiaryUserId != null) 'beneficiary_user_id': beneficiaryUserId,
    };
    try {
      final response = await _client.post(
        '/api/v1/dashboard/seller/subscriptions/$id/attach',
        data: data,
      );
      return ApiResult.success(data: response.data['data']['id']);
    } catch (e) {
      debugPrint('==> purchase ads failure: $e');
      return ApiResult.failure(
        error: NetworkHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<SubscriptionTransactionsResponse>> createTransaction({
    required int id,
    required int paymentId,
    String? beneficiaryUserId,
  }) async {
    final data = {
      'payment_sys_id': paymentId,
      if (beneficiaryUserId != null) 'beneficiary_user_id': beneficiaryUserId,
    };
    debugPrint('===> create transaction body: ${jsonEncode(data)}');
    debugPrint('===> create transaction subscriptions id: $id');
    try {
      final response = await _client.post(
        '/api/v1/payments/subscription/$id/transactions',
        data: data,
      );
      return ApiResult.success(
        data: SubscriptionTransactionsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create transaction failure: $e');
      return ApiResult.failure(
        error: NetworkHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

// Copyright (c) 2026 RokctAI
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


// compliance-ignore-file: flutter-http-timeout (Dio injected from base_sdk HttpService (see the DI), whose BaseOptions set connect/receive/send timeouts centrally)

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:base_sdk/base_sdk.dart';
import '../../domain/interface/subscription_facade.dart';
import '../models/data/subscriptions_data.dart';
import '../models/response/subscriptions_response.dart';
import '../models/response/transactions_response.dart';

/// Calls `agent/subscriptions/frappe`'s composed module over the app's
/// shared Dio client, through the universal platform gateway: every call is
/// a POST to [_gatewayPath] with a `{"cmd", "payload"}` body. Cmd names
/// mirror that module's `manifest.json` whitelisted-method aliases with the
/// `{app_name}` segment dropped (`api.subscription.*`), same as the sibling
/// SDK clients ([HttpLmsRepository], `FrappeStationsSource`) — the
/// Laravel-era `/api/v1/...` REST marketplace paths are not served by the
/// composed Frappe backend.
class SubscriptionsRepository implements SubscriptionsFacade {
  /// The universal platform gateway entry point. Kept on the injected
  /// [_client] (rather than base_sdk's [PlatformGateway]) so tests and
  /// non-standard hosts keep controlling the transport.
  static const _gatewayPath = '/api/v1/method/rokct.platform.api';

  /// Prefix-free cmd base: the old `paas.api.subscription.*` dotted
  /// endpoints with the leading app segment stripped.
  static const _cmd = 'api.subscription';

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
    // list_subscriptions returns the complete plan catalog in one response —
    // the composed backend has no server-side pagination. Later pages are
    // reported empty so load-more footers terminate instead of re-appending
    // the same rows.
    if (page > 1) {
      return ApiResult.success(data: SubscriptionResponse(data: const []));
    }
    final data = {'lang': activeLocale};
    try {
      final response = await _client.post(
        _gatewayPath,
        // Frappe drops kwargs the whitelisted method does not declare, so
        // `lang` is inert today; it stays on the wire to keep the facade's
        // locale contract when the composed backend grows translations.
        data: {'cmd': '$_cmd.list_subscriptions', 'payload': data},
      );
      final subResponse = _parseSubscriptionList(response.data);

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

  /// FrappeResponseInterceptor already unwraps `{'message': ...}` on 2xx;
  /// tolerate both shapes for overridden clients, plus the legacy
  /// `{data: [...]}` envelope, and map a bare Frappe row list into the
  /// response type the facade promises.
  SubscriptionResponse _parseSubscriptionList(dynamic body) {
    final message =
        body is Map && body.containsKey('message') ? body['message'] : body;
    if (message is List) {
      return SubscriptionResponse(
        data: message
            .whereType<Map>()
            .map((e) => SubscriptionData.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }
    if (message is Map) {
      return SubscriptionResponse.fromJson(Map<String, dynamic>.from(message));
    }
    return SubscriptionResponse(data: const []);
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
    String? ref,
    String? beneficiaryUserId,
  }) async {
    final data = {
      // subscribe_my_shop's own argument: the plan's Frappe document name
      // ([ref]) when the row carries one, falling back to the legacy
      // numeric id for stored rows that predate the composed backend.
      'subscription_id': ref ?? id,
      // Not consumed by subscribe_my_shop today (Frappe drops undeclared
      // kwargs); kept on the wire per decision log #23/#30 so the payment
      // integration that lands later can start reading it without a
      // client release.
      'payment_sys_id': paymentId,
      // Delegated billing (see the facade doc): only sent when purchasing
      // for another account, so the self-purchase wire shape is unchanged.
      if (beneficiaryUserId != null) 'beneficiary_user_id': beneficiaryUserId,
    };
    try {
      final response = await _client.post(
        _gatewayPath,
        data: {'cmd': '$_cmd.subscribe_my_shop', 'payload': data},
      );
      // subscribe_my_shop returns the new Shop Subscription document — its
      // Frappe `name` identifies the purchase. The legacy `{data: {id}}`
      // envelope is still tolerated for overridden clients.
      final body = response.data;
      final message =
          body is Map && body.containsKey('message') ? body['message'] : body;
      final dynamic identifier = message is Map
          ? (message['name'] ??
              (message['data'] is Map ? message['data']['id'] : null))
          : null;
      return ApiResult.success(data: identifier);
    } catch (e) {
      debugPrint('==> purchase ads failure: $e');
      return ApiResult.failure(
        error: NetworkHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  /// KNOWN LEGACY SEAM — deliberately NOT migrated to `paas.api.*`. The
  /// composed Frappe backend exposes no payment-transaction alias (see
  /// `agent/subscriptions/frappe/manifest.json`): `subscribe_my_shop` is the
  /// entire purchase, and decision log #30 records this transactions path as
  /// belonging to the external legacy marketplace backend. Pointing it at an
  /// invented `paas.api.subscription.*` path would fabricate a payment
  /// record, so it stays on the legacy path (and fails honestly) until the
  /// real payment integration (decision #33/#34 direction) lands.
  @override
  Future<ApiResult<SubscriptionTransactionsResponse>> createTransaction({
    required Object id,
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

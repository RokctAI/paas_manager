// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
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

import 'package:flutter/material.dart';

import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:base_sdk/src/handlers/platform_gateway.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:kitchen_sdk/src/manager/domain/interface/kitchen_orders.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/models/response/kitchen_orders_response.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_status.dart';

/// Gateway-riding implementation (this SDK's KitchensRepository
/// precedent): every call is a universal-gateway cmd, so the same code
/// runs against whatever backend the composed app's baseUrl points at.
class KitchenOrdersRepository implements KitchenOrdersRepositoryFacade {
  static const _gateway = PlatformGateway();

  static const int _pageLength = 20;

  ApiResult<T> _fail<T>(Object e, String label) {
    debugPrint('==> $label failure: $e');
    return ApiResult.failure(
      error: AppHelpers.errorHandler(e),
      statusCode: NetworkExceptions.getDioStatus(e),
    );
  }

  @override
  Future<ApiResult<KitchenOrdersResponse>> getKitchenOrders({
    KitchenStatus? status,
    String? search,
    int? page,
  }) async {
    try {
      final response = await _gateway.tenant('api.cook.get_kitchen_orders', {
        if (status != null) 'status': status.wire,
        if (search != null && search.isNotEmpty) 'search': search,
        if (page != null) 'limit_start': (page - 1) * _pageLength,
        'limit_page_length': _pageLength,
        'lang': LocalStorage.getLanguage()?.locale,
      });
      return ApiResult.success(
        data: KitchenOrdersResponse.fromJson(response),
      );
    } catch (e) {
      return _fail(e, 'get kitchen orders ${status?.wire ?? 'all'}');
    }
  }

  @override
  Future<ApiResult<void>> updateOrderStatus({
    required String orderId,
    required String wireStatus,
  }) async {
    try {
      await _gateway.tenant('api.seller_order.update_seller_order_status', {
        'order_id': orderId,
        'status': wireStatus,
      });
      return const ApiResult.success(data: null);
    } catch (e) {
      return _fail(e, 'update kitchen order status $wireStatus');
    }
  }

  @override
  Future<ApiResult<void>> updateDishStatus({
    required String orderId,
    required String dishId,
    required DishStatus status,
  }) async {
    try {
      await _gateway.tenant('api.cook.update_kitchen_dish_status', {
        'order_id': orderId,
        'item_id': dishId,
        'prep_status': status.wire,
      });
      return const ApiResult.success(data: null);
    } catch (e) {
      return _fail(e, 'update kitchen dish status ${status.wire}');
    }
  }
}

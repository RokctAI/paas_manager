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

import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/models/response/kitchen_orders_response.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_status.dart';

/// The manager Kitchen screen's data seam. Owned and implemented by
/// kitchen_sdk itself ([KitchenOrdersRepository]) — order data, so no host
/// adapter is involved (orders_sdk's SellerOrdersRepositoryFacade
/// precedent).
///
/// Every id is a Frappe hash docname string — never a numeric id.
abstract class KitchenOrdersRepositoryFacade {
  /// The kitchen queue (shop-scoped). [status] narrows to one chip;
  /// null is the All filter (every kitchen-relevant status). [search]
  /// narrows by order-number substring. [page] is 1-based.
  Future<ApiResult<KitchenOrdersResponse>> getKitchenOrders({
    KitchenStatus? status,
    String? search,
    int? page,
  });

  /// Order-level status transition, riding the EXISTING seller order
  /// status endpoint (`api.seller_order.update_seller_order_status`) —
  /// [wireStatus] is the legacy lowercase wire value; 'cooking',
  /// 'on_a_way' and 'delivered' are legal here beyond [KitchenStatus]
  /// because the hand-over routing leaves the kitchen vocabulary.
  Future<ApiResult<void>> updateOrderStatus({
    required String orderId,
    required String wireStatus,
  });

  /// One dish line's prep state
  /// (`api.cook.update_kitchen_dish_status`).
  Future<ApiResult<void>> updateDishStatus({
    required String orderId,
    required String dishId,
    required DishStatus status,
  });
}

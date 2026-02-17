import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../../domain/di/injection.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/interface/interfaces.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  @override
  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int orderId,
    required int paymentId,
  }) async {
    final data = {'payment_sys_id': paymentId};
    debugPrint('===> create transaction body: ${jsonEncode(data)}');
    debugPrint('===> create transaction order id: $orderId');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/payments/order/$orderId/transactions',
        data: data,
      );
      return ApiResult.success(
        data: TransactionsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create transaction failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<PaymentsResponse>> getPayments() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response =
          await client.get('/api/v1/dashboard/seller/shop-payments');
      return ApiResult.success(
        data: PaymentsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get payments error: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CreateOrderResponse>> createOrder({
    required DeliveryType deliveryType,
    required List<Stock> stocks,
    required String deliveryTime,
    required String address,
    UserData? user,
    LocationData? location,
    String? entrance,
    String? floor,
    String? house,
  }) async {
    List<Map<String, dynamic>> products = [];
    for (final stock in stocks) {
      List<Map<String, dynamic>> addons = [];
      for (AddonData addon
          in stock.addons?.where((e) => e.active ?? false) ?? []) {
        addons.add({
          'stock_id': addon.product?.stock?.id,
          'quantity': addon.quantity,
        });
      }
      products.add({
        'stock_id': stock.id,
        'quantity': stock.cartCount,
        if (addons.isNotEmpty) 'addons': addons,
      });
    }
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'rate': LocalStorage.getSelectedCurrency()?.rate,
      'shop_id': LocalStorage.getShop()?.id,
      'phone': user?.phone?.replaceAll('+', ""),
      'delivery_type':
          deliveryType == DeliveryType.delivery ? 'delivery' : 'pickup',
      'user_id': user?.id,
      'products': products,
      'delivery_date': deliveryTime,
      if (address.isNotEmpty && deliveryType == DeliveryType.delivery)
        'address': {
          'address': address,
          if (entrance != null) 'office': entrance,
          if (house != null) 'house': house,
          if (floor != null) 'floor': floor,
        },
      if (location != null && deliveryType == DeliveryType.delivery)
        'location': {
          'latitude': location.latitude,
          'longitude': location.longitude,
        },
    };
    debugPrint('===> create order body ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/orders',
        data: data,
      );
      return ApiResult.success(
        data: CreateOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create order failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<OrderStatusResponse>> updateOrderStatus({
    required OrderStatus status,
    int? orderId,
  }) async {
    String? statusText;
    switch (status) {
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
    }
    final data = {'status': statusText};
    debugPrint('===> update order status request ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/order/$orderId/status',
        data: data,
      );
      return ApiResult.success(
        data: OrderStatusResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update order status failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleOrderResponse>> getOrderDetails({int? orderId}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final data = {
        'lang': LocalStorage.getLanguage()?.locale,
      };
      final response = await client.get(
          '/api/v1/dashboard/seller/orders/$orderId',
          queryParameters: data);
      return ApiResult.success(
        data: SingleOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order details failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<OrdersPaginateResponse>> getOrders({
    OrderStatus? status,
    int? page,
    String? from,
    String? to,
  }) async {
    String? statusText;
    switch (status) {
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      default:
        statusText = null;
        break;
    }
    final data = {
      if (page != null) 'page': page,
      if (statusText != null) 'status': statusText,
      if (from != null) 'date_from': from,
      if (to != null) 'date_to': to,
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrdersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order $status failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<OrdersPaginateResponse>> getHistoryOrders({
    int? page,
    String? from,
    String? to,
  }) async {
    final data = {
      if (page != null) 'page': page,
      'statuses[0]': 'delivered',
      'statuses[1]': 'canceled',
      if (from != null) 'date_from': from,
      if (to != null) 'date_to': to,
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrdersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<OrderCalculate>> getCalculate({
    required List<Stock> stocks,
    required String type,
    required LocationData? location,
  }) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'shop_id': LocalStorage.getShop()?.id,
      for (int i = 0; i < stocks.length; i++)
        'products[$i][stock_id]': '${stocks[i].id}',
      for (int i = 0; i < stocks.length; i++)
        'products[$i][quantity]': '${stocks[i].cartCount}',
      'type': type,
      if (location != null) 'address[latitude]': location.latitude,
      if (location != null) 'address[longitude]': location.longitude
    };
    for (int i = 0; i < (stocks.length); i++) {
      data['products[$i][stock_id]'] = stocks[i].id;
      data['products[$i][quantity]'] = stocks[i].cartCount;
      final addons =
          stocks[i].addons?.where((e) => e.active ?? false).toList() ?? [];
      for (int j = 0; j < (addons.length); j++) {
        data['products[$i][addons][$j][stock_id]'] =
            addons[j].product?.stock?.id;
        data['products[$i][addons][$j][quantity]'] = addons[j].quantity;
      }
    }
    debugPrint('==> order calculate request: ${jsonEncode(data)}');

    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/order/products/calculate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderCalculate.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}

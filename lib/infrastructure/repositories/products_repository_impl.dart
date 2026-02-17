import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../../domain/di/injection.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/interface/interfaces.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  @override
  Future<ApiResult<void>> deleteExtrasGroup({int? groupId}) async {
    final data = {
      'ids': [groupId]
    };
    debugPrint('====> delete extras group request ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/extra/groups/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete extra group failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleExtrasGroupResponse>> updateExtrasGroup({
    required String title,
    int? groupId,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      'type': 'text',
    };
    debugPrint('===> update extras group ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/extra/groups/$groupId',
        data: data,
      );
      return ApiResult.success(
        data: SingleExtrasGroupResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update extra groups failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteExtrasItem({
    required int extrasId,
  }) async {
    final data = {
      'ids': [extrasId]
    };
    debugPrint('====> delete extras item request ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/extra/values/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete extra item failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CreateGroupExtrasResponse>> updateExtrasItem({
    required int extrasId,
    required int groupId,
    required String title,
  }) async {
    final data = {'value': title, 'extra_group_id': groupId};
    debugPrint('===> update extras item ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/extra/values/$extrasId',
        data: data,
      );
      return ApiResult.success(
        data: CreateGroupExtrasResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update extra item failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CreateGroupExtrasResponse>> createExtrasItem({
    required int groupId,
    required String title,
  }) async {
    final data = {'value': title, 'extra_group_id': groupId};
    debugPrint('===> create extras item ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/extra/values',
        data: data,
      );
      return ApiResult.success(
        data: CreateGroupExtrasResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create extra item failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleExtrasGroupResponse>> createExtrasGroup({
    required String title,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      'active': 1,
      'type': 'text',
    };
    debugPrint('===> create extras group ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/extra/groups',
        data: data,
      );
      return ApiResult.success(
        data: SingleExtrasGroupResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create extra groups failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CalculateResponse>> getProductsCalculation(
    List<Stock> stocks,
  ) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
    };
    for (int i = 0; i < stocks.length; i++) {
      data['products[$i][stock_id]'] = stocks[i].id;
      data['products[$i][quantity]'] = stocks[i].cartCount;
    }
    debugPrint('===> get calculation ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/order/products/calculate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CalculateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get calculations failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<GroupExtrasResponse>> getExtras({int? groupId}) async {
    final data = {'lang': LocalStorage.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/extra/groups/$groupId',
        queryParameters: data,
      );
      return ApiResult.success(
        data: GroupExtrasResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get extras failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> updateStocks({
    required List<Stock> stocks,
    required List<int> deletedStocks,
    String? uuid,
    bool isAddon = false,
  }) async {
    final List<Map<String, dynamic>> extras = [];
    for (final stock in stocks) {
      List<int> ids = [];
      List<int> addonsIds = [];
      if (stock.extras != null && (stock.extras?.isNotEmpty ?? false)) {
        for (final item in stock.extras!) {
          ids.add(item.id ?? 0);
        }
      }
      ids = ids.toSet().toList();
      if (stock.localAddons != null &&
          (stock.localAddons?.isNotEmpty ?? false)) {
        for (final item in stock.localAddons!) {
          addonsIds.add(item.product?.id ?? 0);
        }
      }
      addonsIds = addonsIds.toSet().toList();
      extras.add(
        {
          'price': stock.price,
          if (stock.sku?.isNotEmpty ?? false) 'sku': stock.sku,
          'quantity': stock.quantity,
          if (stock.id != -1 && stock.id != null) "stock_id": stock.id,
          'ids': ids,
          if (addonsIds.isNotEmpty) 'addons': addonsIds,
        },
      );
    }
    final data = {
      'extras': extras,
      if (isAddon) 'addon': 1,
      if (deletedStocks.isNotEmpty) 'delete_ids': deletedStocks,
    };
    debugPrint('===> update stocks request ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products/$uuid/stocks',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update stocks fail: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> updateProduct({
    required String title,
    required String description,
    required String tax,
    required String interval,
    required String minQty,
    required String maxQty,
    required bool active,
    String? qrcode,
    int? categoryId,
    int? unitId,
    int? kitchenId,
     List<String>? images,
    String? uuid,
    bool needAddons = false,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      'description': {
        LocalStorage.getSystemLanguage()?.locale ?? 'en': description
      },
      'tax': num.tryParse(tax),
      'interval': num.tryParse(interval),
      'min_qty': int.tryParse(minQty),
      'max_qty': int.tryParse(maxQty),
      'active': active ? 1 : 0,
      if (qrcode != null) 'bar_code': qrcode,
      if (categoryId != null) 'category_id': categoryId,
      if (kitchenId != null) 'kitchen_id': kitchenId,
      if (unitId != null) 'unit_id': unitId,
      if (images != null) 'images': images,
      if (needAddons) 'addon': 1,
    };
    debugPrint('===> update product ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/products/$uuid',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update product fail: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> updateExtras({
    required List<int> extrasIds,
    String? productUuid,
  }) async {
    final data = {'extras': extrasIds};
    debugPrint('===> update extras ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products/$productUuid/extras',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update extras failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ExtrasGroupsResponse>> getExtrasGroups({
    bool needOnlyValid = true,
  }) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
      if (needOnlyValid) 'valid': true,
      "perPage": 50
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/extra/groups',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ExtrasGroupsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get extras groups failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> createProduct({
    required String title,
    required String description,
    required String tax,
    required String interval,
    required String minQty,
    required String maxQty,
    required String qrcode,
    required bool active,
    int? categoryId,
    int? kitchenId,
    int? unitId,
    List<String>? images,
    bool isAddon = false,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      'description': {
        LocalStorage.getSystemLanguage()?.locale ?? 'en': description
      },
      'tax': num.tryParse(tax),
      'interval': num.tryParse(interval),
      'min_qty': num.tryParse(minQty),
      'max_qty': num.tryParse(maxQty),
      'active': active ? 1 : 0,
      if (qrcode.isNotEmpty) 'sku': qrcode,
      if (kitchenId != null) 'kitchen_id': kitchenId,
      if (categoryId != null) 'category_id': categoryId,
      if (unitId != null) 'unit_id': unitId,
      if (images != null) 'images': images,
      if (isAddon) 'addon': 1,
    };
    debugPrint('===> create product ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create product fail: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> getProductDetails(
    String uuid,
  ) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/products/$uuid',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get product details failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ProductsPaginateResponse>> getProducts({
    int? page,
    int? categoryId,
    String? query,
    ProductStatus? status,
    bool needAddons = false,
    bool active = false,
  }) async {
    String? statusText;
    if (status != null) {
      switch (status) {
        case ProductStatus.pending:
          statusText = 'pending';
          break;
        case ProductStatus.published:
          statusText = 'published';
          break;
        case ProductStatus.unpublished:
          statusText = 'unpublished';
          break;
        default:
          statusText = 'published';
          break;
      }
    }
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      if (page != null) 'page': page,
      if (categoryId != null) 'category_id': categoryId,
      if (query != null) 'search': query,
      if (statusText != null) 'status': statusText,
      if (needAddons) 'addon': 1,
      'perPage': 10,
      'addon_status': "published",
      if (active) "active": 1,
      if (active) "status": "published"
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/products/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}

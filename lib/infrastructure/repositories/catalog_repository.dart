import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/domain/handlers/handlers.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class CatalogRepository implements CatalogInterface {
  @override
  Future<ApiResult<UnitsPaginateResponse>> getUnits() async {
    final data = {'lang': LocalStorage.getLanguage()?.locale, 'perPage': 100};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/units/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UnitsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get units paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<KitchensPaginateResponse>> getKitchens() async {
    final data = {'lang': LocalStorage.getLanguage()?.locale, 'perPage': 100};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/kitchen/',
        queryParameters: data,
      );
      return ApiResult.success(
        data: KitchensPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get kitchens paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<void>> createCategory({
    required String title,
    int? input,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      'active': 1,
      'input': input,
      'type': 'main',
    };
    debugPrint('===> create category request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post('/api/v1/dashboard/seller/categories', data: data);
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> create category failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getCategories({
    int? page,
    String? query,
    String? type,
    bool hasProducts = false,
  }) async {
    final shopId = LocalStorage.getUser()?.shop?.id ?? 0;
    final data = {
      if (page != null) 'page': page,
      if (query != null) 'search': query,
      'perPage': 100,
      'lang': LocalStorage.getLanguage()?.locale,
      if (type != null) 'type': type,
      if (type == null) 'type': 'main',
      if (hasProducts) 'has_products': 1,
      if (hasProducts)
        if (type == 'combo') 'c_shop_id': shopId else 'p_shop_id': shopId,
      'active': '1',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getShopCategories({
    int? page,
    String? query,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (query != null) 'search': query,
      'perPage': 100,
      'lang': LocalStorage.getLanguage()?.locale,
      'type': 'main',
      "has_products": 1,
      "p_shop_id": LocalStorage.getUser()?.shop?.id ?? 0,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getCategoriesSub({
    int? page,
    String? query,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (query != null) 'search': query,
      'perPage': 100,
      'lang': LocalStorage.getLanguage()?.locale,
      'type': 'sub_shop',
      'active': '1',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult> deleteCategory({required int? id}) async {
    final data = {'ids[0]': id};
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/categories/delete',
        queryParameters: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete categories failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

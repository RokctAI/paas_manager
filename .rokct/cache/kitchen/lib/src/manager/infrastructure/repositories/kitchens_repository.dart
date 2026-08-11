import 'package:flutter/material.dart';
import 'package:base_sdk/src/di/injection.dart';
import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:kitchen_sdk/src/common/domain/interface/kitchens.dart';
import 'package:kitchen_sdk/src/common/infrastructure/models/response/kitchens_paginate_response.dart';

/// Port of `paas_manager`'s `getKitchens`, repointed from
/// `/api/v1/dashboard/seller/kitchen/` to its Frappe counterpart.
class KitchensRepository implements KitchensRepositoryFacade {
  @override
  Future<ApiResult<KitchensPaginateResponse>> getKitchens({int? perPage}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/method/paas.api.seller_operations.seller_operations.get_seller_kitchens',
        queryParameters: {
          'lang': LocalStorage.getLanguage()?.locale,
          'limit_page_length': perPage ?? 100,
        },
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
}

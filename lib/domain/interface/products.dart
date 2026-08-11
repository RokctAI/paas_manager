// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:manager/domain/handlers/handlers.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

abstract class ProductsInterface {
  Future<ApiResult<void>> deleteExtrasGroup({int? groupId});

  Future<ApiResult<SingleExtrasGroupResponse>> updateExtrasGroup({
    required String title,
    int? groupId,
  });

  Future<ApiResult<void>> deleteExtrasItem({
    required int extrasId,
  });

  Future<ApiResult<CreateGroupExtrasResponse>> updateExtrasItem({
    required int extrasId,
    required int groupId,
    required String title,
  });

  Future<ApiResult<CreateGroupExtrasResponse>> createExtrasItem({
    required int groupId,
    required String title,
  });

  Future<ApiResult<SingleExtrasGroupResponse>> createExtrasGroup({
    required String title,
  });

  Future<ApiResult<CalculateResponse>> getProductsCalculation(
    List<Stock> stocks,
  );

  Future<ApiResult<GroupExtrasResponse>> getExtras({int? groupId});

  Future<ApiResult<SingleProductResponse>> updateStocks({
    required List<Stock> stocks,
    required List<int> deletedStocks,
    String? uuid,
    bool isAddon = false,
  });

  Future<ApiResult<SingleProductResponse>> updateProduct({
    required Map<String, List<String>> titlesAndDescriptions,
    required String tax,
    required String interval,
    required String minQty,
    required String maxQty,
    required bool active,
    String? qrcode,
    int? categoryId,
    int? kitchenId,
    int? unitId,
    List<String>? images,
    String? uuid,
    bool needAddons = false,
  });

  Future<ApiResult<SingleProductResponse>> updateExtras({
    required List<int> extrasIds,
    String? productUuid,
  });

  Future<ApiResult<ExtrasGroupsResponse>> getExtrasGroups({
    bool needOnlyValid = true,
  });

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
  });

  Future<ApiResult<SingleProductResponse>> getProductDetails(String uuid);

  Future<ApiResult<ProductsPaginateResponse>> getProducts({
    int? page,
    int? categoryId,
    String? query,
    ProductStatus? status,
    bool needAddons = false,
    bool active = false,
  });
}

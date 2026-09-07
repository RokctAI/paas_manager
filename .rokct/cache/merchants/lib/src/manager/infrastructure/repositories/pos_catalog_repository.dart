// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:get_it/get_it.dart';
import 'package:base_sdk/src/domain/interface/categories.dart';
import 'package:base_sdk/src/domain/interface/products.dart';
import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:base_sdk/src/models/data/product_data.dart';
import 'package:base_sdk/src/models/response/categories_paginate_response.dart';
import 'package:base_sdk/src/models/response/products_paginate_response.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_catalog.dart';

/// Real POS catalog: delegates to the composed app's registered
/// [ProductsRepositoryFacade] and [CategoriesRepositoryFacade]
/// (products_sdk registers both in every manager compose - the foods tab
/// needs them - routed through the universal platform gateway). Resolved
/// lazily per call so registration order between SDK DI hooks doesn't
/// matter.
class PosCatalogRepository implements PosCatalogRepositoryFacade {
  @override
  Future<ApiResult<ProductsPaginateResponse>> searchProducts({
    required String text,
    int page = 1,
    String? categoryId,
  }) async {
    final products = GetIt.instance<ProductsRepositoryFacade>();
    if (categoryId == null) {
      return products.searchProducts(text: text, page: page);
    }
    // A tapped chip with nothing typed lists the category (chip 349) -
    // this shop's, where the kernel has cached it, never the market's;
    // base's text search takes no category, so with text the matches are
    // narrowed here by the category every ProductData already carries.
    if (text.isEmpty) {
      return products.getProductsPaginate(
        shopId: _ownShopId,
        categoryId: categoryId,
        page: page,
      );
    }
    final result = await products.searchProducts(text: text, page: page);
    return result.when(
      success: (data) => ApiResult.success(
        data: ProductsPaginateResponse(
          data: (data.data ?? const <ProductData>[])
              .where((product) => product.categoryId == categoryId)
              .toList(),
          meta: data.meta,
        ),
      ),
      failure: (error, statusCode) =>
          ApiResult.failure(error: error, statusCode: statusCode),
    );
  }

  /// The signed-in manager's own shop, as the kernel caches it
  /// (`LocalStorage.getShopJson()`); null until the hub has fetched it.
  static String? get _ownShopId {
    final shopId = LocalStorage.getShopJson()?['id']?.toString();
    return (shopId == null || shopId.isEmpty) ? null : shopId;
  }

  /// The manager's own shop's categories, the marketplace's first page
  /// when no shop is cached yet. A compose without a categories facade
  /// (no products_sdk) answers empty - the bar draws nothing, never a
  /// stand-in.
  @override
  Future<ApiResult<CategoriesPaginateResponse>> categories() async {
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<CategoriesRepositoryFacade>()) {
      return ApiResult.success(data: CategoriesPaginateResponse(data: []));
    }
    final categories = getIt<CategoriesRepositoryFacade>();
    final shopId = _ownShopId;
    if (shopId == null) {
      return categories.getAllCategories(page: 1);
    }
    return categories.getCategoriesByShop(shopId: shopId);
  }
}

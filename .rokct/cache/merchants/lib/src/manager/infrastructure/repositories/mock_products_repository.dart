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

import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:base_sdk/src/models/data/product_data.dart';
import 'package:base_sdk/src/models/data/translation.dart';
import 'package:base_sdk/src/models/response/categories_paginate_response.dart';
import 'package:base_sdk/src/models/response/products_paginate_response.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_catalog.dart';

/// Demo-mode POS catalog (`--dart-define=IS_DEMO=true` routes the till's
/// barcode lookup here, `ManagerMerchantsDependencies.register`): any
/// barcode or search text resolves to one "Flame-grilled beef burger" at
/// 150.00, the same demo identity products_sdk's mock serves — so headless
/// tours and the standalone test harness scan, cart and check out with zero
/// backend contact.
///
/// The categories (1.30.0, the Add Items pane's chip bar - approved frame
/// 11m, chip 349) are the SAME three products_sdk's demo seller catalog
/// seeds for the foods tab (Mains / Sides / Drinks), so the shop a demo
/// manager runs on the till and the shop the foods tab edits stay ONE shop;
/// the burger sits in Mains. A category filter answers honestly: Mains
/// (or no filter) lists the burger, any other category lists nothing.
class MockProductsRepository implements PosCatalogRepositoryFacade {
  static const String mainsCategoryId = '1';

  static final List<CategoryData> demoCategories = <CategoryData>[
    _category(mainsCategoryId, 'Mains'),
    _category('2', 'Sides'),
    _category('3', 'Drinks'),
  ];

  static CategoryData _category(String id, String title) => CategoryData(
    id: id,
    uuid: 'demo_category_$id',
    parentId: '0',
    type: 'main',
    active: true,
    translation: Translation(title: title, locale: 'en'),
  );

  static final ProductData demoProduct = ProductData(
    id: '1',
    uuid: 'demo_product_uuid',
    shopId: '1',
    categoryId: mainsCategoryId,
    active: true,
    translation: Translation(
      title: 'Flame-grilled beef burger',
      description: 'Flame-grilled beef patty, toasted bun, house sauce',
      locale: 'en',
    ),
    stocks: [Stocks(id: '1', price: 150, quantity: 100, totalPrice: 150)],
  );

  @override
  Future<ApiResult<ProductsPaginateResponse>> searchProducts({
    required String text,
    int page = 1,
    String? categoryId,
  }) async {
    final bool inCategory =
        categoryId == null || categoryId == demoProduct.categoryId;
    return ApiResult.success(
      data: ProductsPaginateResponse(
        data: inCategory ? [demoProduct] : const <ProductData>[],
      ),
    );
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> categories() async {
    return ApiResult.success(
      data: CategoriesPaginateResponse(data: demoCategories),
    );
  }
}

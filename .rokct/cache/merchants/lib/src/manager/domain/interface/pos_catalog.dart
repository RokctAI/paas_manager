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
import 'package:base_sdk/src/models/response/categories_paginate_response.dart';
import 'package:base_sdk/src/models/response/products_paginate_response.dart';

/// The POS till's product-lookup seam (barcode scans and the manual
/// "Add Items" lane both resolve through it).
///
/// Deliberately narrower than base_sdk's `ProductsRepositoryFacade`: the
/// till only ever searches, by text and - since 1.30.0, for the Add Items
/// pane's category chip bar (approved design strip frame 11m, chip 349) -
/// by category. The real implementation delegates to the composed app's
/// registered products and categories facades (products_sdk registers
/// both in every manager compose); the demo implementation
/// (`MockProductsRepository`, this SDK's) answers locally so headless
/// tours and the standalone test harness never touch a backend.
abstract class PosCatalogRepositoryFacade {
  /// Product search by free text or barcode — the same call the legacy
  /// Spazafy scanner made (`searchProducts(text: barcode)` → first match).
  ///
  /// [categoryId] narrows the answer to one category (chip 349): with
  /// text it filters the matches, with EMPTY text it lists the category -
  /// the pane shows a tapped chip's products before anything is typed.
  /// Null is every category, exactly the call the scanner makes.
  Future<ApiResult<ProductsPaginateResponse>> searchProducts({
    required String text,
    int page = 1,
    String? categoryId,
  });

  /// The shop's categories for the chip bar (349). An empty list is a
  /// valid answer - the bar draws nothing then, never an invented set.
  Future<ApiResult<CategoriesPaginateResponse>> categories();
}

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
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/adaptive/planes.dart';
import 'package:base_sdk/src/presentation/components/floating_nav/floating_nav_mode.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';

/// The approved revenue plane behaviour (frames 36a/36c, Ray 2026-08-30
/// 10:38Z "approve all remaining 3"): **THE DASHBOARD DECLARES ALL** — the
/// same call the orders board, kitchen and catalog made ("stuff you need to
/// see"); the flow's root claims [PlaneSpan.all] and spreads KPI / chart /
/// profit-by-product over the planes. Tapping a product row PUSHES its
/// profitability detail (chip 670) with the DEFAULT one-plane claim into
/// the LAST plane, so
///
///  * at three planes the dashboard compresses onto planes 1–2 (the 36c
///    mini-KPI rail + the product list, 12:26Z origin rule) with the detail
///    on plane 3;
///  * at two planes it is dashboard | detail;
///  * on a phone the flow hosts the dashboard alone — the detail is a REAL
///    pushed route with the corner pill (the kitchen 34c pattern).
///
/// Unlike the catalog's PERMANENT read pane, this detail is a PUSHED page
/// holding a plane, so the nav folds to the corner back pill while it is
/// open (the 12:36Z fold, exactly as frame 36c renders it) — the template
/// hides its full centered nav on the same signal.
class RevenuePlaneFlow extends StatelessWidget {
  /// The drilled-into product, if any — selection-driven (the notifier), so
  /// window refreshes keep an open detail current.
  final ProductProfit? selectedProduct;

  /// Builds the dashboard workspace (the flow's root, claiming ALL planes).
  final WidgetBuilder dashboardBuilder;

  /// Builds the pushed profitability detail (default claim: one plane).
  final Widget Function(BuildContext context, ProductProfit product)
      detailBuilder;

  /// Pops the detail (the corner back pill).
  final VoidCallback onCloseDetail;

  const RevenuePlaneFlow({
    super.key,
    required this.selectedProduct,
    required this.dashboardBuilder,
    required this.detailBuilder,
    required this.onCloseDetail,
  });

  @override
  Widget build(BuildContext context) {
    final product = selectedProduct;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool onePlane =
            PlaneHost.planeCountFor(constraints.maxWidth) == 1;
        final bool detailOpen = !onePlane && product != null;
        return PlaneHost(
          // A pushed page holds a plane -> the nav folds to the corner
          // pill (12:36Z; frame 36c). On the phone the detail is a real
          // pushed route carrying its own pill, so the flow never shows
          // one here.
          back: detailOpen
              ? FloatingNavBack(
                  icon: Remix.arrow_left_s_line,
                  label: AppHelpers.getTranslation(TrKeys.back),
                  onTap: onCloseDetail,
                )
              : null,
          stack: [
            PlanePage(
              name: 'revenue-dashboard',
              span: PlaneSpan.all,
              builder: dashboardBuilder,
            ),
            if (detailOpen)
              PlanePage(
                name: 'product-profit-detail',
                // Default claim — exactly one plane (the 33d/34a ruling).
                builder: (context) => KeyedSubtree(
                  key: ValueKey('profit-detail-${product.id}'),
                  child: detailBuilder(context, product),
                ),
              ),
          ],
        );
      },
    );
  }
}

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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/components/floating_nav/floating_bottom_nav.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:revenue_sdk/src/manager/application/profit/profit_dashboard_provider.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/product_profit_pane.dart';

/// The PHONE's pushed product-profitability detail: on a one-plane width a
/// product-row tap pushes this page as a REAL route — the 12:36Z nav-fold
/// moment; the corner [FloatingBackPill] is the one affordance left (the
/// kitchen 34c pattern). Content is the same [ProductProfitPane] the wide
/// layout puts in the last plane, kept live through the shared provider.
/// If the selection dies underneath (a window refresh dropped the product),
/// the page pops itself.
class RevenueDetailPage extends ConsumerWidget {
  final List<ProductVariantView>? Function(String productId)? variantsFor;
  final void Function(BuildContext context, String productId)? onEditCost;

  const RevenueDetailPage({super.key, this.variantsFor, this.onEditCost});

  /// Pushes the page over the whole shell (root navigator = the nav fold).
  static Future<void> push(
    BuildContext context, {
    List<ProductVariantView>? Function(String productId)? variantsFor,
    void Function(BuildContext context, String productId)? onEditCost,
  }) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => RevenueDetailPage(
          variantsFor: variantsFor,
          onEditCost: onEditCost,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product =
        ref.watch(profitDashboardProvider.select((s) => s.selectedProduct));
    ref.listen(profitDashboardProvider.select((s) => s.selectedProduct),
        (previous, next) {
      if (next == null && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      backgroundColor: AppStyle.surfaceDark,
      body: SafeArea(
        child: product == null
            ? const SizedBox.shrink()
            : Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 76),
                      child: ProductProfitPane(
                        product: product,
                        variants: variantsFor?.call(product.id),
                        onEditCost: onEditCost == null
                            ? null
                            : () => onEditCost!(context, product.id),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 16,
                    bottom: 16,
                    child: FloatingBackPill(
                      back: FloatingNavBack(
                        icon: Remix.arrow_left_s_line,
                        label: AppHelpers.getTranslation(TrKeys.back),
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

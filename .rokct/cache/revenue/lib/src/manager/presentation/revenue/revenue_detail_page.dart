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

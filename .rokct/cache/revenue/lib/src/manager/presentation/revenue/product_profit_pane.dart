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
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/profit_product_list.dart';

/// A per-variant margin row's view data (chip 672). revenue_sdk cannot
/// import products_sdk (ADR-005 — SDKs import only base), so the TEMPLATE
/// layer fetches the product's stocks through products_sdk's facade and
/// maps them to this plain shape. `cost` is the product-level cost — the
/// shipped schema has no per-variant cost, so every variant margins
/// against the same cost, honestly.
class ProductVariantView {
  final String title;
  final num? price;
  final num? cost;

  const ProductVariantView({required this.title, this.price, this.cost});
}

/// The product profitability drill-down pane (chip 670, frame 36c): the
/// canonical 35a Price/Cost/Margin strip full-size, the window's
/// Sold/Revenue/Profit, per-variant margins when the template has loaded
/// them, the cost-frozen-at-sale note (chip 673), and the ONE action —
/// "Edit cost price" (chip 674) jumping into the 35b product edit form
/// where cost lives (decision transfer, no new form).
class ProductProfitPane extends StatelessWidget {
  final ProductProfit product;

  /// Loaded asynchronously by the template (products_sdk fetch); null shows
  /// nothing, an empty list shows nothing — no skeleton theatre.
  final List<ProductVariantView>? variants;
  final VoidCallback? onEditCost;

  const ProductProfitPane({
    super.key,
    required this.product,
    this.variants,
    this.onEditCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppStyle.cardDark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppStyle.strokeDark),
                    ),
                    child: ProfitMarginStrip(product: product, large: true),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppHelpers.getTranslation('this_period').toUpperCase(),
                    style: AppStyle.interSemi(
                      size: 11,
                      color: AppStyle.textDarkSecondary,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _periodStats(),
                  if (variants != null && variants!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      AppHelpers.getTranslation('by_variant').toUpperCase(),
                      style: AppStyle.interSemi(
                        size: 11,
                        color: AppStyle.textDarkSecondary,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final variant in variants!) _variantRow(variant),
                  ],
                  const SizedBox(height: 16),
                  _frozenNote(),
                ],
              ),
            ),
          ),
          if (onEditCost != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: Material(
                color: AppStyle.primary,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: onEditCost,
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: Text(
                      AppHelpers.getTranslation('edit_cost_price'),
                      style: AppStyle.interSemi(
                        size: 15,
                        color: AppStyle.blackColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _header() {
    final words = product.name.trim().split(RegExp(r'\s+'));
    final initials =
        words.take(2).map((w) => w.isEmpty ? '' : w[0].toUpperCase()).join();
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppStyle.cardDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppStyle.strokeDarkSubtle),
          ),
          child: Text(
            initials.isEmpty ? '?' : initials,
            style:
                AppStyle.interSemi(size: 16, color: AppStyle.textDarkSecondary),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interBold(size: 18, color: AppStyle.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _periodStats() {
    final bool noProfit = product.costMissing && product.profit == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Row(
        children: [
          _stat(AppHelpers.getTranslation('sold'), '${product.sold}',
              AppStyle.textPrimary),
          _statDivider(),
          _stat(
            AppHelpers.getTranslation('revenue'),
            AppHelpers.numberFormat(number: product.revenue),
            AppStyle.textPrimary,
          ),
          _statDivider(),
          _stat(
            AppHelpers.getTranslation('profit'),
            noProfit ? '—' : AppHelpers.numberFormat(number: product.profit),
            noProfit
                ? AppStyle.textDarkFaint
                : (product.profit < 0 ? AppStyle.red : AppStyle.green),
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, Color color) => Expanded(
        child: Column(
          children: [
            Text(
              label,
              style: AppStyle.interNormal(
                size: 11,
                color: AppStyle.textDarkFaint,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.interSemi(size: 14, color: color),
            ),
          ],
        ),
      );

  Widget _statDivider() => Container(
        width: 1,
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: AppStyle.strokeDarkSubtle,
      );

  Widget _variantRow(ProductVariantView variant) {
    final num? price = variant.price;
    final num? cost = variant.cost;
    final bool usable =
        price != null && price > 0 && cost != null && cost > 0;
    final String marginText = usable
        ? '${((price - cost) / price * 100).round()}%'
        : '—';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              variant.title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.interSemi(
                size: 12,
                color: AppStyle.textPrimary,
              ),
            ),
          ),
          Text(
            price != null && price > 0
                ? AppHelpers.numberFormat(number: price)
                : '—',
            style: AppStyle.interNormal(
              size: 12,
              color: AppStyle.textDarkSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            marginText,
            style: AppStyle.interSemi(
              size: 12,
              color: usable ? AppStyle.green : AppStyle.textDarkFaint,
            ),
          ),
        ],
      ),
    );
  }

  /// Chip 673 — a SHIPPED FACT stated in the UI: order.py copies
  /// Product.cost onto the order line at sale; editing cost later never
  /// rewrites old orders.
  Widget _frozenNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Remix.lock_line, size: 15, color: AppStyle.textDarkSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppHelpers.getTranslation('as_sold_profit_uses_the_cost_frozen_on_each_order_line_at_sale_changing_cost_later_never_rewrites_old_orders'),
              style: AppStyle.interNormal(
                size: 11,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

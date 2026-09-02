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

/// One Profit-by-product row (chip 666): initials block, name,
/// "N sold · revenue", green profit — and the 35a Price/Cost/Margin strip
/// grammar underneath (canonical strip, chip 625 — 667 retired unused).
/// A row with no usable cost shows the approved "cost not set" state
/// (chip 668): grey cost, `—` profit, `—` margin — NEVER 100% margin.
class ProductProfitRow extends StatelessWidget {
  final ProductProfit product;
  final bool selected;
  final VoidCallback? onTap;
  final bool compact;

  const ProductProfitRow({
    super.key,
    required this.product,
    this.selected = false,
    this.onTap,
    this.compact = false,
  });

  /// The window aggregated no cost for this product's lines AND the current
  /// cost is unset — nothing honest to show but the dashes.
  bool get _noProfit => product.costMissing && product.profit == 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppStyle.cardDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppStyle.primary : AppStyle.strokeDarkSubtle,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _initialsBlock(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interSemi(
                          size: 14,
                          color: AppStyle.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${product.sold} ${AppHelpers.getTranslation('sold')}'
                        ' · ${AppHelpers.numberFormat(number: product.revenue)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interNormal(
                          size: 11,
                          color: AppStyle.textDarkSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _noProfit
                          ? '—'
                          : AppHelpers.numberFormat(number: product.profit),
                      style: AppStyle.interSemi(
                        size: 14,
                        color: _noProfit
                            ? AppStyle.textDarkFaint
                            : (product.profit < 0
                                ? AppStyle.red
                                : AppStyle.green),
                      ),
                    ),
                    Text(
                      AppHelpers.getTranslation('profit'),
                      style: AppStyle.interNormal(
                        size: 10,
                        color: AppStyle.textDarkFaint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (!compact) ...[
              const SizedBox(height: 10),
              ProfitMarginStrip(product: product),
            ],
          ],
        ),
      ),
    );
  }

  Widget _initialsBlock() {
    final words = product.name.trim().split(RegExp(r'\s+'));
    final initials = words
        .take(2)
        .map((w) => w.isEmpty ? '' : w[0].toUpperCase())
        .join();
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: AppStyle.interSemi(size: 13, color: AppStyle.textDarkSecondary),
      ),
    );
  }
}

/// The canonical 35a Price/Cost/Margin strip carried onto a profit row —
/// same three cells, same "cost not set" honesty, current price and cost.
class ProfitMarginStrip extends StatelessWidget {
  final ProductProfit product;

  /// Larger cells for the 36c detail header strip.
  final bool large;

  const ProfitMarginStrip({super.key, required this.product, this.large = false});

  @override
  Widget build(BuildContext context) {
    final bool costMissing = product.costMissing;
    final num margin = product.price - product.cost;
    final double marginPct =
        product.price > 0 ? margin / product.price * 100 : 0;
    return Row(
      children: [
        _cell(
          AppHelpers.getTranslation('price'),
          product.price > 0
              ? AppHelpers.numberFormat(number: product.price)
              : '—',
          AppStyle.textPrimary,
        ),
        _divider(),
        _cell(
          AppHelpers.getTranslation('cost'),
          costMissing
              ? AppHelpers.getTranslation('cost_not_set')
              : AppHelpers.numberFormat(number: product.cost),
          costMissing ? AppStyle.textDarkFaint : AppStyle.textPrimary,
        ),
        _divider(),
        _cell(
          AppHelpers.getTranslation('margin'),
          costMissing || product.price <= 0
              ? '—'
              : (large
                  ? '${AppHelpers.numberFormat(number: margin)} · '
                      '${marginPct.round()}%'
                  : '${marginPct.round()}%'),
          costMissing
              ? AppStyle.textDarkFaint
              : (margin < 0 ? AppStyle.red : AppStyle.green),
        ),
      ],
    );
  }

  Widget _cell(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.interNormal(
              size: large ? 12 : 10,
              color: AppStyle.textDarkFaint,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interSemi(
              size: large ? 15 : 12,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: large ? 32 : 24,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: AppStyle.strokeDarkSubtle,
      );
}

/// The amber unknown-cost bucket banner (chip 669): names EXACTLY what is
/// excluded — order count and revenue sold without a cost snapshot — and
/// offers "Set costs". Hard honesty rule: excluded, never counted as pure
/// profit. Renders nothing when the bucket is empty.
class UnknownBucketBanner extends StatelessWidget {
  final UnknownCostBucket bucket;
  final VoidCallback? onSetCosts;

  const UnknownBucketBanner({super.key, required this.bucket, this.onSetCosts});

  @override
  Widget build(BuildContext context) {
    if (bucket.isEmpty) return const SizedBox.shrink();
    final Color amber = AppStyle.rate;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: amber),
        color: amber.withValues(alpha: 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Remix.information_line, size: 16, color: amber),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${bucket.orders} '
                  '${AppHelpers.getTranslation('orders_excluded_from_profit')}'
                  ' — ${AppHelpers.getTranslation('no_cost_recorded_at_sale')}',
                  style: AppStyle.interSemi(size: 12, color: amber),
                ),
              ),
              if (onSetCosts != null)
                InkWell(
                  onTap: onSetCosts,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      AppHelpers.getTranslation('set_costs'),
                      style: AppStyle.interSemi(
                        size: 12,
                        color: AppStyle.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              '${AppHelpers.numberFormat(number: bucket.revenueExcluded)} '
              '${AppHelpers.getTranslation('of_revenue_sold_without_a_cost_price_it_is_left_out_of_profit_and_margin_never_counted_as_pure_profit')}',
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

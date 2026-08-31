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

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';

/// The payout strip (chip 662): the shipped restaurantRevenue-vs-fmRevenue
/// tile pair made honest as one flow — gross revenue → platform fee →
/// your payout. Data comes from the SHIPPED `get_order_report`
/// (total_price / fm_total_price over Delivered orders), so this strip
/// keeps working on a backend that predates the profit endpoint.
class PayoutStrip extends StatelessWidget {
  final num gross;
  final num payout;

  const PayoutStrip({super.key, required this.gross, required this.payout});

  @override
  Widget build(BuildContext context) {
    final num fee = gross - payout;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppStyle.cardDarkAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation('payout').toUpperCase(),
            style: AppStyle.interSemi(
              size: 11,
              color: AppStyle.textDarkSecondary,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          _row(
            AppHelpers.getTranslation('gross_revenue'),
            AppHelpers.numberFormat(number: gross),
            AppStyle.textPrimary,
          ),
          const SizedBox(height: 8),
          _row(
            AppHelpers.getTranslation('platform_fee'),
            '− ${AppHelpers.numberFormat(number: fee)}',
            AppStyle.textDarkSecondary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: AppStyle.strokeDarkSubtle),
          ),
          _row(
            AppHelpers.getTranslation('your_payout'),
            AppHelpers.numberFormat(number: payout),
            AppStyle.textPrimary,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, Color valueColor,
      {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.interNormal(
              size: 13,
              color: AppStyle.textDarkSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: bold
              ? AppStyle.interBold(size: 15, color: valueColor)
              : AppStyle.interSemi(size: 13, color: valueColor),
        ),
      ],
    );
  }
}

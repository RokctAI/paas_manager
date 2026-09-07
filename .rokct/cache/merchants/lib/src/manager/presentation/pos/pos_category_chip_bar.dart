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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_sdk/src/models/response/categories_paginate_response.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';

/// The Add Items pane's category chip bar - approved design strip frame
/// 11m, chip 349 (Ray 2026-08-29 10:52Z "11m looks good but no search for
/// items and no categories"; approved 13:53Z): "a horizontal pill row (All
/// / ...) in the dark till tokens, patterned on the paas_pos products-page
/// category chips". The dress is the foods page's own chip strip
/// (products_sdk FoodsBody._categoryChips, the 35a catalog): 34-high
/// horizontal row, All first, `primary` fill when active, `cardDark` on a
/// `strokeDark` hairline otherwise, 100 radius.
///
/// Pure presentation: the pane owns the state (posCartProvider's
/// categories / categoryId) and hands the tapped id back through
/// [onSelect] - null for All. With no categories the bar draws NOTHING
/// (an "All" alone would be a chip bar with nothing to choose).
class PosCategoryChipBar extends StatelessWidget {
  const PosCategoryChipBar({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  /// Widget key of the "All" chip; a category's chip is
  /// `Key('posCategoryChip-<id>')`.
  static const Key allChipKey = Key('posCategoryChip-all');

  static Key chipKey(String id) => Key('posCategoryChip-$id');

  final List<CategoryData> categories;
  final String? selectedId;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    final named = categories
        .where((c) => (c.id ?? '').isNotEmpty)
        .where((c) => (c.translation?.title ?? '').isNotEmpty)
        .toList();
    if (named.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 34.r,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _chip(
            key: allChipKey,
            label: AppHelpers.getTranslation(TrKeys.all),
            active: selectedId == null,
            onTap: () => onSelect(null),
          ),
          for (final category in named)
            _chip(
              key: chipKey(category.id!),
              label: category.translation!.title!,
              active: selectedId == category.id,
              onTap: () => onSelect(category.id),
            ),
        ],
      ),
    );
  }

  Widget _chip({
    required Key key,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: InkWell(
        key: key,
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: active ? AppStyle.primary : AppStyle.cardDark,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: active ? AppStyle.primary : AppStyle.strokeDark,
            ),
          ),
          child: Text(
            label,
            style: active
                ? AppStyle.interSemi(size: 13, color: AppStyle.textPrimary)
                : AppStyle.interNormal(
                    size: 13,
                    color: AppStyle.textDarkSecondary,
                  ),
          ),
        ),
      ),
    );
  }
}

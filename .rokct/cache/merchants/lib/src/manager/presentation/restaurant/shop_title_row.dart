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
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';

/// The shop title row at the head of the restaurant hub's shop-info
/// section (the installed restaurant_page.dart template's
/// `MerchantShopInfoSection`): title • ★ rating, then the promo and flash
/// badges and the shop-edit pencil trailing at the end edge.
///
/// The row used to be a bare `Row` with the title as a fixed-width `Text`
/// and a `Spacer` before the badges. At tablet density 240 dpi (a 1280x800
/// logical window: three planes, the hub capped at two, so each section
/// column is narrower than on the 320 dpi / 960x600 two-plane window) a
/// full-length title plus the three trailing controls no longer fit and
/// the row overflowed its column by 22 px (paas_manager guided tour
/// 33952102598). The title now rides a [Flexible] inside the leading
/// group, which takes the room the trailing controls leave — so the
/// title ellipsises instead of pushing the pencil off the edge, and the
/// badges keep their end-edge alignment on every width. No hardcoded
/// widths.
///
/// Lives in lib/ (not the template) so the widget test can pump it at both
/// geometries; the template only supplies the title, rating and edit tap.
class ShopTitleRow extends StatelessWidget {
  final String title;
  final String rating;
  final VoidCallback onEdit;

  const ShopTitleRow({
    super.key,
    required this.title,
    required this.rating,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // The leading group owns whatever the trailing controls leave;
        // inside it only the title gives way.
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  key: const Key('shopTitleRowTitle'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.interSemi(
                    size: 22.sp,
                    color: AppStyle.textPrimary,
                  ),
                ),
              ),
              Container(
                width: 4.w,
                height: 4.h,
                margin: REdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyle.textGrey,
                ),
              ),
              Icon(
                Remix.star_smile_fill,
                color: AppStyle.starColor,
                size: 20.r,
              ),
              4.horizontalSpace,
              Text(
                rating,
                key: const Key('shopTitleRowRating'),
                style: AppStyle.interNormal(
                  size: 12.sp,
                  color: AppStyle.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Container(
          key: const Key('shopTitleRowPromoBadge'),
          width: 22.w,
          height: 22.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppStyle.red,
          ),
          child: Icon(
            Remix.percent_fill,
            color: AppStyle.white,
            size: 12.r,
          ),
        ),
        14.horizontalSpace,
        Container(
          width: 22.w,
          height: 22.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppStyle.primary,
          ),
          child: Icon(Remix.flashlight_fill, size: 16.r),
        ),
        14.horizontalSpace,
        // The shop-edit pencil (approved fix 2026-08-28): it edits the
        // SHOP, so it rides the shop title row.
        IconButton(
          key: const Key('shopTitleRowEdit'),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Remix.pencil_line,
            size: 20.r,
            color: AppStyle.textPrimary,
          ),
          onPressed: onEdit,
        ),
      ],
    );
  }
}

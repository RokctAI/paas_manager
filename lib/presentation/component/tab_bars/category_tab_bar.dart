// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:manager/presentation/styles/style.dart';
import '../list_items/shop_tab_bar_item.dart';
import 'package:manager/infrastructure/services/services.dart';

class CategoryTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;
  final int index;
  final ValueChanged<int> onTap;

  const CategoryTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.onTap,
    this.index = 0,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.greyColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 16.r, end: 8.r),
            child: SvgPicture.asset(
              AppAssets.svgMenu,
              width: 22.r,
              height: 22.r,
            ),
          ),
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: onTap,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            isScrollable: true,
            indicatorPadding: EdgeInsets.zero,
            indicatorColor: Style.transparent,
            labelColor: Style.primary,
            unselectedLabelColor: Style.white,
            controller: tabController,
            tabs: [
              ...tabs.map(
                (e) => ShopTabBarItem(
                  title: e,
                  isActive: index == tabs.indexOf(e),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

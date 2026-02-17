import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/app_assets.dart';

import '../components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class CategoriesTabBar extends StatelessWidget {
  final List<CategoryData> categories;
  final int activeIndex;
  final Function(int) onChangeTab;
  final Function() onLoading;
  final RefreshController refreshController;

  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.activeIndex,
    required this.onChangeTab,
    required this.refreshController,
    required this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.r,
      child: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        enablePullDown: false,
        enablePullUp: true,
        controller: refreshController,
        onLoading: onLoading,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + 2,
          padding: REdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) {
            return index == 0
                ? Padding(
                    padding: EdgeInsetsDirectional.only(start: 8.r, end: 8.r),
                    child: SvgPicture.asset(
                      Assets.svgMenu,
                      width: 22.r,
                      height: 22.r,
                    ),
                  )
                : (index == 1
                      ? CategoryTabBarItem(
                          title: AppHelpers.getTranslation(TrKeys.popular),
                          isActive: activeIndex == 1,
                          onTap: () {
                            onChangeTab(1);
                          },
                        )
                      : CategoryTabBarItem(
                          title:
                              categories[index - 2].translation?.title ?? '--',
                          isActive: activeIndex == index,
                          onTap: () {
                            onChangeTab(index);
                          },
                        ));
          },
        ),
      ),
    );
  }
}

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
import 'package:flutter/rendering.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'foods/foods_body.dart';
import 'extras/extras_body.dart';
import 'addons/addons_body.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodsPage extends ConsumerStatefulWidget {
  const FoodsPage({super.key}) ;

  @override
  ConsumerState<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends ConsumerState<FoodsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late RefreshController _categoryController;
  late RefreshController _productController;
  late RefreshController _addonsController;
  late RefreshController _extrasController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () {
        if (!_tabController.indexIsChanging) {
          switch (_tabController.index) {
            case 0:
              ref.read(foodTabsProvider.notifier).setSelectedIndex(0);
              break;
            case 1:
              ref.read(foodTabsProvider.notifier).setSelectedIndex(1);
              break;
            case 2:
              ref.read(foodTabsProvider.notifier).setSelectedIndex(2);
              break;
            default:
              ref.read(foodTabsProvider.notifier).setSelectedIndex(0);
              break;
          }
        }
      },
    );
    _scrollController = ScrollController();
    _categoryController = RefreshController();
    _productController = RefreshController();
    _addonsController = RefreshController();
    _extrasController = RefreshController();
    _scrollController.addListener(
      () {
        final direction = _scrollController.position.userScrollDirection;
        if (direction == ScrollDirection.reverse) {
          ref.read(mainProvider.notifier).changeScrolling(true);
        } else {
          ref.read(mainProvider.notifier).changeScrolling(false);
        }
      },
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(foodCategoriesProvider.notifier).initialFetchCategories();
        ref.read(foodsProvider.notifier).initialFetchFoods();
        ref.read(addonsProvider.notifier).initialFetchAddons();
        ref.read(extrasProvider.notifier).fetchGroups();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    _categoryController.dispose();
    _productController.dispose();
    _addonsController.dispose();
    _extrasController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        backgroundColor: Style.greyColor,
        body: Column(
          children: [
            CustomAppBar(
              bottomPadding: 4.h,
              child: Consumer(
                builder: (context, ref, child) {
                  final foodsEvent = ref.read(foodsProvider.notifier);
                  final categoriesState = ref.watch(foodCategoriesProvider);
                  return SearchTextField(
                    onChanged: (value) => foodsEvent.setQuery(
                      query: value,
                      categoryId: categoriesState.activeIndex == 1
                          ? null
                          : categoriesState
                              .categories[categoriesState.activeIndex - 2].id,
                    ),
                    suffixIcon: ButtonsBouncingEffect(
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          FlutterRemix.equalizer_fill,
                          color: Style.blackColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (
                  BuildContext context,
                  bool innerBoxIsScrolled,
                ) {
                  return [
                    SliverAppBar(
                      floating: true,
                      backgroundColor: Style.transparent,
                      elevation: 0,
                      titleSpacing: 0,
                      toolbarHeight: 48.h,
                      title: Container(
                        padding: REdgeInsets.all(6),
                        margin: REdgeInsets.symmetric(horizontal: 16),
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Style.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Style.tabBarBorderColor),
                        ),
                        child: TabBar(
                          onTap: (index) {},
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Style.blackColor,
                          ),
                          labelColor: Style.white,
                          unselectedLabelColor: Style.textColor,
                          unselectedLabelStyle: Style.interRegular(size: 14.sp),
                          labelStyle: Style.interSemi(size: 14.sp),
                          tabs: [
                            Tab(
                              child: Text(AppHelpers.getTranslation(TrKeys.foods)),
                            ),
                            Tab(
                              child: Text(AppHelpers.getTranslation(TrKeys.addons)),
                            ),
                            Tab(
                              child: Text(AppHelpers.getTranslation(TrKeys.extras)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabController,
                  children: [
                    FoodsBody(
                      categoryController: _categoryController,
                      productController: _productController,
                    ),
                    AddonsBody(addonsController: _addonsController),
                    ExtrasBody(refreshController: _extrasController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

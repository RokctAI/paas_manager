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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/foods/edit/details/kitchen/edit_food_kitchens_provider.dart';

import '../edit/edit_product_modal.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodsBody extends StatelessWidget {
  final RefreshController categoryController;
  final RefreshController productController;

  const FoodsBody({
    super.key,
    required this.categoryController,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        Consumer(
          builder: (context, ref, child) {
            final categoriesState = ref.watch(foodCategoriesProvider);
            final categoriesEvent = ref.read(foodCategoriesProvider.notifier);
            final productsEvent = ref.read(foodsProvider.notifier);
            return categoriesState.isLoading
                ? const TabBarLoading()
                : SizedBox(
                    height: 36.h,
                    child: CategoriesTabBar(
                      categories: categoriesState.categories,
                      activeIndex: categoriesState.activeIndex,
                      refreshController: categoryController,
                      onChangeTab: (index) {
                        categoriesEvent.setActiveIndex(index);
                        if (index != categoriesState.activeIndex) {
                          productsEvent.fetchCategoryProducts(
                            categoryId: index == 1
                                ? null
                                : categoriesState.categories[index - 2].id,
                            refreshController: productController,
                          );
                        }
                      },
                      onLoading: () => categoriesEvent.fetchCategories(
                        context: context,
                        refreshController: categoryController,
                      ),
                    ),
                  );
          },
        ),
        8.verticalSpace,
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final productsState = ref.watch(foodsProvider);
              final productsEvent = ref.read(foodsProvider.notifier);
              return ProductsBody(
                itemSpacing: 10,
                isLoading: productsState.isLoading,
                products: productsState.foods,
                refreshController: productController,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                onRefreshing: () => productsEvent.refreshProducts(
                  refreshController: productController,
                ),
                onLoading: () => productsEvent.fetchMoreProducts(
                  refreshController: productController,
                ),
                onProductTap: (index) {
                  ref
                      .read(editFoodDetailsProvider.notifier)
                      .setFoodDetails(productsState.foods[index]);
                  ref
                      .read(editFoodUnitsProvider.notifier)
                      .setFoodUnit(productsState.foods[index].unit);
                  ref
                      .read(editFoodKitchensProvider.notifier)
                      .setFoodKitchen(productsState.foods[index].kitchen);
                  ref
                      .read(editFoodCategoriesProvider.notifier)
                      .setFoodCategory(productsState.foods[index].category);
                  AppHelpers.showCustomModalBottomSheet(
                    paddingTop: 60,
                    context: context,
                    modal: EditProductModal(
                      controller: ScrollController(),
                      product: productsState.foods[index],
                    ),
                    isDarkMode: false,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

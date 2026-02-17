import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/foods/edit/details/kitchen/edit_food_kitchens_provider.dart';

import '../edit/edit_product_modal.dart';
import '../../../../component/components.dart';
import '../../../../styles/style.dart';
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
            final productsState = ref.watch(foodsProvider);
            final productsEvent = ref.read(foodsProvider.notifier);
            final categoriesEvent = ref.read(categoriesProvider.notifier);
            return Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        productsEvent.setProductType(
                          'single',
                          refreshController: productController,
                        );
                        categoriesEvent.fetchCategories(
                          context,
                          controller: categoryController,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: productsState.productType == 'single'
                              ? AppStyle.blackColor
                              : AppStyle.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: productsState.productType == 'single'
                                ? AppStyle.blackColor
                                : AppStyle.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.product),
                            style: AppStyle.interSemi(
                              size: 14,
                              color: productsState.productType == 'single'
                                  ? AppStyle.white
                                  : AppStyle.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        productsEvent.setProductType(
                          'combo',
                          refreshController: productController,
                        );
                        categoriesEvent.fetchComboCategories(
                          context,
                          controller: categoryController,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: productsState.productType == 'combo'
                              ? AppStyle.blackColor
                              : AppStyle.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: productsState.productType == 'combo'
                                ? AppStyle.blackColor
                                : AppStyle.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.combo),
                            style: AppStyle.interSemi(
                              size: 14,
                              color: productsState.productType == 'combo'
                                  ? AppStyle.white
                                  : AppStyle.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        16.verticalSpace,
        Consumer(
          builder: (context, ref, child) {
            final categoriesState = ref.watch(categoriesProvider);
            final categoriesEvent = ref.read(categoriesProvider.notifier);
            final productsState = ref.watch(foodsProvider);
            final productsEvent = ref.read(foodsProvider.notifier);

            final isCombo = productsState.productType == 'combo';
            final currentCategories = isCombo
                ? categoriesState.comboCategories
                : categoriesState.categories;
            final currentActiveIndex = isCombo
                ? categoriesState.activeComboIndex
                : categoriesState.activeIndex;
            final isLoadingCategories = isCombo
                ? categoriesState.isComboLoading
                : categoriesState.isLoading;

            return isLoadingCategories
                ? const TabBarLoading()
                : SizedBox(
                    height: 36.h,
                    child: CategoriesTabBar(
                      categories: currentCategories,
                      activeIndex: currentActiveIndex,
                      refreshController: categoryController,
                      onChangeTab: (index) {
                        categoriesEvent.setActiveIndex(index, isCombo: isCombo);
                        if (index != currentActiveIndex) {
                          productsEvent.fetchCategoryProducts(
                            categoryId: index == 1
                                ? null
                                : currentCategories[index - 2].id,
                            refreshController: productController,
                          );
                        }
                      },
                      onLoading: () => isCombo
                          ? categoriesEvent.fetchComboCategories(
                              context,
                              controller: categoryController,
                            )
                          : categoriesEvent.fetchCategories(
                              context,
                              controller: categoryController,
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

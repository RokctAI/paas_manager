import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'details/food_details_modal.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

@RoutePage()
class CreateOrderPage extends ConsumerStatefulWidget {
  const CreateOrderPage({super.key}) ;

  @override
  ConsumerState<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends ConsumerState<CreateOrderPage> {
  late RefreshController _categoryController;
  late RefreshController _productController;

  @override
  void initState() {
    super.initState();
    _categoryController = RefreshController();
    _productController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(orderProductsProvider.notifier).fetchProducts(
              categoryId: null,
              isRefresh: ref.watch(productCategoriesProvider).activeIndex != 1
                  ? true
                  : false,
              isOpeningPage: true,
              cartStocks: ref.watch(orderCartProvider).stocks,
            );
        ref.read(productCategoriesProvider.notifier).initialFetchCategories();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
    _productController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDisable(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Style.greyColor,
          body: Column(
            children: [
              CustomAppBar(
                bottomPadding: 4.h,
                child: Consumer(
                  builder: (context, ref, child) {
                    final productsEvent =
                        ref.read(orderProductsProvider.notifier);
                    final categoriesState =
                        ref.watch(productCategoriesProvider);
                    return SearchTextField(
                      onChanged: (value) => productsEvent.setQuery(
                        query: value,
                        categoryId: categoriesState.activeIndex == 1
                            ? null
                            : categoriesState
                                .categories[categoriesState.activeIndex - 2].id,
                        cartStocks: ref.watch(orderCartProvider).stocks,
                      ),
                      suffixIcon: Icon(
                        FlutterRemix.equalizer_fill,
                        color: Style.blackColor,
                        size: 20.r,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    24.verticalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        final categoriesState =
                            ref.watch(productCategoriesProvider);
                        final categoriesEvent =
                            ref.read(productCategoriesProvider.notifier);
                        final productsEvent =
                            ref.read(orderProductsProvider.notifier);
                        return categoriesState.isLoading
                            ? const TabBarLoading()
                            : SizedBox(
                                height: 36.h,
                                child: CategoriesTabBar(
                                  categories: categoriesState.categories,
                                  activeIndex: categoriesState.activeIndex,
                                  refreshController: _categoryController,
                                  onChangeTab: (index) {
                                    categoriesEvent.setActiveIndex(index);
                                    if (index != categoriesState.activeIndex) {
                                      productsEvent.fetchProducts(
                                        refreshController: _productController,
                                        categoryId: index == 1
                                            ? null
                                            : categoriesState
                                                .categories[index - 2].id,
                                        isRefresh: true,
                                        cartStocks:
                                            ref.watch(orderCartProvider).stocks,
                                      );
                                    }
                                  },
                                  onLoading: () =>
                                      categoriesEvent.fetchMoreCategories(
                                    refreshController: _categoryController,
                                  ),
                                ),
                              );
                      },
                    ),
                    8.verticalSpace,
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final productsState =
                              ref.watch(orderProductsProvider);
                          final categoriesState =
                              ref.watch(productCategoriesProvider);
                          final productsEvent =
                              ref.read(orderProductsProvider.notifier);
                          return ProductsBody(
                            loadingHeight: 130,
                            isOrderFoods: true,
                            isLoading: productsState.isLoading,
                            products: productsState.products,
                            refreshController: _productController,
                            onRefreshing: () => productsEvent.fetchProducts(
                              cartStocks: ref.watch(orderCartProvider).stocks,
                              refreshController: _productController,
                              isRefresh: true,
                              categoryId: categoriesState.activeIndex == 1
                                  ? null
                                  : categoriesState
                                      .categories[
                                          categoriesState.activeIndex - 2]
                                      .id,
                            ),
                            onLoading: () => productsEvent.fetchProducts(
                              refreshController: _productController,
                              cartStocks: ref.watch(orderCartProvider).stocks,
                              categoryId: categoriesState.activeIndex == 1
                                  ? null
                                  : categoriesState
                                      .categories[
                                          categoriesState.activeIndex - 2]
                                      .id,
                            ),
                            onProductTap: (index) =>
                                AppHelpers.showCustomModalBottomDragSheet(
                              paddingTop: 60,
                              context: context,
                              maxChildSize: 0.8,
                              initSize: 0.6,
                              modal: (c) => FoodDetailsModal(
                                controller: c,
                                product: productsState.products[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: Padding(
            padding: REdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const PopButton(heroTag: AppConstants.heroTagAddOrderButton),
                Consumer(
                  builder: (context, ref, child) {
                    final cartState = ref.watch(orderCartProvider);
                    return cartState.stocks.isNotEmpty
                        ? ButtonsBouncingEffect(
                            child: GestureDetector(
                              onTap: () =>
                                  context.pushRoute(const OrderRoute()),
                              child: Container(
                                height: 48.r,
                                decoration: BoxDecoration(
                                  color: Style.primary,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: REdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(TrKeys.ordering),
                                      style: Style.interSemi(
                                        size: 16.sp,
                                        color: Style.blackColor,
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    Container(
                                      height: 32.r,
                                      padding:
                                          REdgeInsets.symmetric(horizontal: 14),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Style.blackColor,
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                      ),
                                      child: Text(
                                        AppHelpers.numberFormat(
                                            cartState.totalPrice),
                                        style: Style.interSemi(
                                          size: 16.sp,
                                          color: Style.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

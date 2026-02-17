import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/food_extras.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'widgets/food_price_widget.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'widgets/w_ingredient.dart';

class FoodDetailsModal extends ConsumerStatefulWidget {
  final ProductData product;
  final ScrollController controller;

  const FoodDetailsModal({
    super.key,
    required this.product,
    required this.controller,
  });

  @override
  ConsumerState<FoodDetailsModal> createState() => _FoodDetailsModalState();
}

class _FoodDetailsModalState extends ConsumerState<FoodDetailsModal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(productsProvider.notifier)
          .setProductDetails(
            product: widget.product,
            cartStocks: ref.watch(orderCartProvider).stocks,
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: SingleChildScrollView(
        controller: widget.controller,
        physics: const BouncingScrollPhysics(),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(productsProvider);
            final event = ref.read(productsProvider.notifier);
            final cartEvent = ref.read(orderCartProvider.notifier);
            final productsEvent = ref.read(orderProductsProvider.notifier);
            return Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ModalDrag(),
                      CommonImage(
                        url: widget.product.img,
                        radius: 16,
                        errorRadius: 16,
                        fit: BoxFit.fitWidth,
                        height: 212,
                        width: double.infinity,
                      ),
                      22.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.translation?.title ?? '',
                              style: AppStyle.interNormal(
                                size: 14,
                                color: AppStyle.blackColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          FoodPriceWidget(
                            product: widget.product,
                            stock: state.selectedStock,
                          ),
                        ],
                      ),
                      6.verticalSpace,
                      Text(
                        '${widget.product.translation?.description}',
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      24.verticalSpace,
                      if (ref.watch(productsProvider).typedExtras.isNotEmpty)
                        Padding(
                          padding: REdgeInsets.only(bottom: 24),
                          child: const FoodExtras(),
                        ),
                      WIngredientScreen(
                        list: state.selectedStock?.addons ?? [],
                        onChange: (int value) {
                          event.updateIngredient(context, value);
                        },
                        add: (int value) {
                          event.addIngredient(context, value);
                        },
                        remove: (int value) {
                          event.removeIngredient(context, value);
                        },
                      ),
                      16.verticalSpace,
                    ],
                  ),
                ),
                Container(
                  color: AppStyle.white,
                  padding: REdgeInsets.only(
                    bottom: Platform.isIOS ? 40 : 20,
                    top: 20,
                  ),
                  child: state.stockCount > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 56.w,
                              height: 50.r,
                              decoration: BoxDecoration(
                                color: AppStyle.primary,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${state.stockCount * (state.productData?.interval ?? 1)} ${state.productData?.unit?.translation?.title ?? ""}',
                                style: AppStyle.interSemi(
                                  size: 15,
                                  color: AppStyle.blackColor,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ButtonsBouncingEffect(
                                  child: GestureDetector(
                                    onTap: () => event.decreaseStockCount(
                                      updateCart: (count) =>
                                          cartEvent.addStockToCart(
                                            count: count,
                                            product: state.productData,
                                            stock: state.selectedStock,
                                            updateProducts: (stocks) =>
                                                productsEvent.updateProducts(
                                                  cartStocks: stocks,
                                                ),
                                          ),
                                    ),
                                    child: Container(
                                      height: 50.r,
                                      width: 100.r,
                                      decoration: BoxDecoration(
                                        color: AppStyle.discountColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        FlutterRemix.subtract_line,
                                        size: 24.r,
                                        color: AppStyle.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                                1.horizontalSpace,
                                ButtonsBouncingEffect(
                                  child: GestureDetector(
                                    onTap: () => event.increaseStockCount(
                                      updateCart: (count) =>
                                          cartEvent.addStockToCart(
                                            count: count,
                                            product: state.productData,
                                            stock: state.selectedStock,
                                            updateProducts: (stocks) =>
                                                productsEvent.updateProducts(
                                                  cartStocks: stocks,
                                                ),
                                          ),
                                    ),
                                    child: Container(
                                      height: 50.r,
                                      width: 100.r,
                                      decoration: BoxDecoration(
                                        color: AppStyle.addCountColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16.r),
                                          bottomRight: Radius.circular(16.r),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        FlutterRemix.add_line,
                                        size: 24.r,
                                        color: AppStyle.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            36.horizontalSpace,
                          ],
                        )
                      : Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          child: CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.toBuy),
                            onPressed: () {
                              event.increaseStockCount(
                                updateCart: (count) {
                                  cartEvent.addStockToCart(
                                    count: count,
                                    product: state.productData,
                                    stock: state.selectedStock,
                                    updateProducts: (stocks) => productsEvent
                                        .updateProducts(cartStocks: stocks),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

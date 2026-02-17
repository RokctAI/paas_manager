import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'create_food_addons_modal.dart';
import 'create_food_edit_extras_modal.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class CreateFoodStocksBody extends ConsumerStatefulWidget {
  const CreateFoodStocksBody({super.key});

  @override
  ConsumerState<CreateFoodStocksBody> createState() =>
      _CreateFoodStocksBodyState();
}

class _CreateFoodStocksBodyState extends ConsumerState<CreateFoodStocksBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(createFoodStocksProvider.notifier).setInitialStocks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(createFoodStocksProvider);
          final event = ref.read(createFoodStocksProvider.notifier);
          final foodsEvent = ref.read(foodsProvider.notifier);
          final categoriesState = ref.watch(categoriesProvider);
          final detailsState = ref.watch(createFoodDetailsProvider);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              SizedBox(
                height: 60.r,
                child: ListView.builder(
                  itemCount: state.groups.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ExtrasItem(
                    extras: state.groups[index],
                    onTap: () {
                      AppHelpers.showCustomModalBottomSheet(
                        paddingTop: MediaQuery.paddingOf(context).top + 150,
                        context: context,
                        radius: 12,
                        modal: CreateFoodEditExtrasModal(groupIndex: index),
                        isDarkMode: false,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView.builder(
                    itemCount: state.stocks.length,
                    shrinkWrap: true,
                    padding: REdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EditableFoodStockItem(
                        key: UniqueKey(),
                        isDeletable: index != 0,
                        stock: state.stocks[index],
                        onDeleteStock: () => event.deleteStock(index),
                        onPriceChange: (value) =>
                            event.setPrice(value: value, index: index),
                        onQuantityChange: (value) =>
                            event.setQuantity(value: value, index: index),
                        onAddonTap: (context) =>
                            AppHelpers.showCustomModalBottomSheet(
                              paddingTop:
                                  MediaQuery.paddingOf(context).top + 150,
                              context: context,
                              radius: 12,
                              modal: CreateFoodAddonsModal(
                                stock: state.stocks[index],
                                onSave: (addons) =>
                                    event.setStockAddons(addons, index),
                              ),
                              isDarkMode: true,
                            ),
                        onSkuChange: (value) {
                          event.setSku(value: value, index: index);
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  isLoading: state.isSaving,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      event.updateStocks(
                        context,
                        uuid: detailsState.createdProduct?.uuid,
                        updated: () {
                          foodsEvent.fetchProducts(
                            isRefresh: true,
                            categoryId: categoriesState.activeIndex == 1
                                ? null
                                : categoriesState
                                      .categories[categoriesState.activeIndex -
                                          2]
                                      .id,
                          );
                          AppHelpers.showCheckTopSnackBar(
                            context,
                            type: SnackBarType.success,
                            text: AppHelpers.getTranslation(
                              TrKeys.successfullyUpdated,
                            ),
                          );
                          context.maybePop();
                        },
                        failed: () => AppHelpers.showCheckTopSnackBar(
                          context,
                          type: SnackBarType.error,
                          text: AppHelpers.getTranslation(TrKeys.updateFailed),
                        ),
                      );
                    }
                  },
                ),
              ),
              20.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}

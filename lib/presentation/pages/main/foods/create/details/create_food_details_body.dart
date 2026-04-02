import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/foods/create/details/kitchens/create_food_kitchens_provider.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/presentation/pages/main/foods/create/details/create_food_kitchens_modal.dart';
import 'food_categories_modal.dart';
import 'create_food_units_modal.dart';

class CreateFoodDetailsBody extends StatefulWidget {
  final Function() onSave;

  const CreateFoodDetailsBody({super.key, required this.onSave});

  @override
  State<CreateFoodDetailsBody> createState() => _CreateFoodDetailsBodyState();
}

class _CreateFoodDetailsBodyState extends State<CreateFoodDetailsBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(createFoodDetailsProvider);
              final categoryState = ref.watch(allCategoriesProvider);
              final unitState = ref.watch(createFoodUnitsProvider);
              final kitchenState = ref.watch(createFoodKitchensProvider);
              final event = ref.read(createFoodDetailsProvider.notifier);
              final foodsEvent = ref.read(foodsProvider.notifier);
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    24.verticalSpace,
                    MultiImagePicker(
                      imageUrls: state.listOfUrls,
                      listOfImages: state.images,
                      onImageChange: event.setImageFile,
                      onDelete: event.deleteImage,
                    ),
                    24.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => event.setProductType('single'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: state.productType == 'single'
                                    ? AppStyle.primary
                                    : AppStyle.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: state.productType == 'single'
                                      ? AppStyle.primary
                                      : AppStyle.borderColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppHelpers.getTranslation(TrKeys.product),
                                  style: AppStyle.interSemi(
                                    size: 14,
                                    color: state.productType == 'single'
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
                            onTap: () => event.setProductType('combo'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: state.productType == 'combo'
                                    ? AppStyle.primary
                                    : AppStyle.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: state.productType == 'combo'
                                      ? AppStyle.primary
                                      : AppStyle.borderColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Combo',
                                  style: AppStyle.interSemi(
                                    size: 14,
                                    color: state.productType == 'combo'
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
                    24.verticalSpace,
                    UnderlinedTextField(
                      label:
                          '${AppHelpers.getTranslation(TrKeys.productTitle)}*',
                      inputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      onTap: () {
                        AppHelpers.showCustomModalBottomSheet(
                          context: context,
                          modal: MultiTranslationInputModal(
                            model: AiTranslationModel.product,
                            label: AppHelpers.getTranslation(
                              TrKeys.productTitle,
                            ),
                            inputs: state.titleTranslations,
                            save: (translations) {
                              event.setTitleTranslations(translations);
                            },
                          ),
                          isDarkMode: false,
                        );
                      },
                      textController: TextEditingController(text: state.title),
                      validator: AppValidators.emptyCheck,
                      suffixIcon: Icon(
                        FlutterRemix.translate,
                        color: AppStyle.blackColor,
                        size: 20.r,
                      ),
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label:
                          '${AppHelpers.getTranslation(TrKeys.description)}*',
                      inputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      onTap: () {
                        AppHelpers.showCustomModalBottomSheet(
                          context: context,
                          modal: MultiTranslationInputModal(
                            model: AiTranslationModel.product,
                            label: AppHelpers.getTranslation(
                              TrKeys.description,
                            ),
                            inputs: state.descriptionTranslations,
                            save: (translations) {
                              event.setDescriptionTranslations(translations);
                            },
                          ),
                          isDarkMode: false,
                        );
                      },
                      textController: TextEditingController(
                        text: state.description,
                      ),
                      validator: AppValidators.emptyCheck,
                      suffixIcon: Icon(
                        FlutterRemix.translate,
                        color: AppStyle.blackColor,
                        size: 20.r,
                      ),
                    ),
                    24.verticalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        return UnderlinedTextField(
                          textController: categoryState.categoryController,
                          label:
                              '${AppHelpers.getTranslation(TrKeys.productCategory)}*',
                          suffixIcon: Icon(
                            FlutterRemix.arrow_down_s_line,
                            color: AppStyle.blackColor,
                            size: 18.r,
                          ),
                          readOnly: true,
                          validator: AppValidators.emptyCheck,
                          onTap: () => AppHelpers.showCustomModalBottomSheet(
                            paddingTop:
                                MediaQuery.paddingOf(context).top + 100.h,
                            context: context,
                            modal: FoodCategoriesModal(type: state.productType),
                            isDarkMode: false,
                          ),
                        );
                      },
                    ),
                    24.verticalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        return UnderlinedTextField(
                          textController: unitState.unitController,
                          label: '${AppHelpers.getTranslation(TrKeys.units)}*',
                          suffixIcon: Icon(
                            FlutterRemix.arrow_down_s_line,
                            color: AppStyle.blackColor,
                            size: 18.r,
                          ),
                          readOnly: true,
                          validator: AppValidators.emptyCheck,
                          onTap: () => AppHelpers.showCustomModalBottomSheet(
                            paddingTop:
                                MediaQuery.paddingOf(context).top + 300.h,
                            context: context,
                            modal: const CreateFoodUnitsModal(),
                            isDarkMode: false,
                          ),
                        );
                      },
                    ),
                    24.verticalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        return UnderlinedTextField(
                          textController: kitchenState.kitchenController,
                          label: AppHelpers.getTranslation(TrKeys.kitchen),
                          suffixIcon: Icon(
                            FlutterRemix.arrow_down_s_line,
                            color: AppStyle.blackColor,
                            size: 18.r,
                          ),
                          readOnly: true,
                          onTap: () => AppHelpers.showCustomModalBottomSheet(
                            paddingTop:
                                MediaQuery.paddingOf(context).top + 300.h,
                            context: context,
                            modal: const CreateFoodKitchensModal(),
                            isDarkMode: false,
                          ),
                        );
                      },
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label: '${AppHelpers.getTranslation(TrKeys.interval)}*',
                      inputType: TextInputType.number,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      onChanged: event.setInterval,
                      validator: AppValidators.minQtyCheck,
                    ),
                    24.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnderlinedTextField(
                            label:
                                '${AppHelpers.getTranslation(TrKeys.minQuantity)}*',
                            inputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: event.setMinQty,
                            validator: (value) =>
                                AppValidators.minQtyCheck(value),
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: UnderlinedTextField(
                            label:
                                '${AppHelpers.getTranslation(TrKeys.maxQuantity)}*',
                            inputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: event.setMaxQty,
                            validator: (value) =>
                                AppValidators.maxQtyCheck(value, state.minQty),
                          ),
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label: '${AppHelpers.getTranslation(TrKeys.tax)}*',
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: event.setTax,
                      validator: AppValidators.emptyCheck,
                    ),
                    24.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.showProduct),
                          style: AppStyle.interNormal(
                            size: 14,
                            letterSpacing: -0.3,
                            color: AppStyle.blackColor,
                          ),
                        ),
                        CustomToggle(
                          controller: ValueNotifier<bool>(state.active),
                          onChange: event.setActive,
                        ),
                      ],
                    ),
                    40.verticalSpace,
                    CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.save),
                      isLoading: state.isCreating,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          event.createProduct(
                            context,
                            categoryId: categoryState
                                .categories[categoryState.activeIndex]
                                .id,
                            unitId: unitState.units[unitState.activeIndex].id,
                            kitchenId: kitchenState.kitchens.isNotEmpty
                                ? kitchenState
                                      .kitchens[kitchenState.activeIndex]
                                      .id
                                : null,
                            created: () {
                              widget.onSave();
                              AppHelpers.showCheckTopSnackBar(
                                context,
                                text: AppHelpers.getTranslation(
                                  TrKeys.successfullyCreated,
                                ),
                                type: SnackBarType.success,
                              );
                              foodsEvent.fetchProducts(
                                isRefresh: true,
                                categoryId: categoryState.activeIndex == 1
                                    ? null
                                    : categoryState
                                          .categories[categoryState
                                                  .activeIndex -
                                              2]
                                          .id,
                              );
                            },
                            onError: () {},
                          );
                        }
                      },
                    ),
                    20.verticalSpace,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'add_food_categories_state.freezed.dart';

@freezed
class AddFoodCategoriesState with _$AddFoodCategoriesState {
  const factory AddFoodCategoriesState({
    @Default([]) List<CategoryData> categories,
    @Default([]) List<CategoryData> categoriesSub,
    @Default(1) int activeIndex,
    @Default(1) int activeSubIndex,
    TextEditingController? categoryController,
    TextEditingController? categorySubController,
  }) = _AddFoodCategoriesState;

  const AddFoodCategoriesState._();
}

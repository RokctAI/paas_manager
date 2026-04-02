import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_categories_state.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class EditFoodCategoriesNotifier
    extends StateNotifier<EditFoodCategoriesState> {
  EditFoodCategoriesNotifier()
    : super(
        EditFoodCategoriesState(categoriesController: TextEditingController()),
      );

  void setCategories(List<CategoryData> list) {
    List<CategoryData> categories = List.from(list);
    int? index;
    if (state.foodCategory != null) {
      for (int i = 0; i < categories.length; i++) {
        if (state.foodCategory?.id == categories[i].id) {
          index = i;
        }
      }
      if (index == null) {
        categories.insert(0, state.foodCategory!);
      }
    }
    state = state.copyWith(
      categories: categories,
      activeIndex: index ?? 0,
      foodCategory: categories.isEmpty ? null : categories[index ?? 0],
    );
    state.categoriesController?.text =
        state.foodCategory?.translation?.title ?? '';
  }

  void setFoodCategory(CategoryData? category) {
    state = state.copyWith(foodCategory: category);
    state.categoriesController?.text = category?.translation?.title ?? '';
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    final newCategory = state.categories[index];
    state = state.copyWith(activeIndex: index, foodCategory: newCategory);
    state.categoriesController?.text = newCategory.translation?.title ?? '';
  }
}

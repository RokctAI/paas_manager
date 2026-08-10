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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_categories_state.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class EditFoodCategoriesNotifier
    extends StateNotifier<EditFoodCategoriesState> {
  EditFoodCategoriesNotifier()
      : super(
          EditFoodCategoriesState(
            categoriesController: TextEditingController(),
          ),
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

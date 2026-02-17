import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'all_categories_state.freezed.dart';

@freezed
abstract class AllCategoriesState with _$AllCategoriesState {
  const factory AllCategoriesState({
    @Default([]) List<CategoryData> categories,
    @Default([]) List<CategoryData> comboCategories,
    @Default([]) List<CategoryData> categoriesSub,
    @Default([]) List<CategoryData> comboCategoriesSub,
    @Default(1) int activeIndex,
    @Default(1) int activeSubIndex,
    @Default(1) int activeComboIndex,
    @Default(1) int activeComboSubIndex,
    TextEditingController? categoryController,
    TextEditingController? categorySubController,
    @Default(false) bool isLoading,
  }) = _AllCategoriesState;

  const AllCategoriesState._();
}

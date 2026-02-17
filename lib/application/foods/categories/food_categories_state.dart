import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'food_categories_state.freezed.dart';

@freezed
class FoodCategoriesState with _$FoodCategoriesState {
  const factory FoodCategoriesState({
    @Default(false) bool isLoading,
    @Default([]) List<CategoryData> categories,
    @Default(1) int activeIndex,
  }) = _FoodCategoriesState;

  const FoodCategoriesState._();
}

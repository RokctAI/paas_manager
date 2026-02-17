import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'edit_food_addons_state.freezed.dart';

@freezed
abstract class EditFoodAddonsState with _$EditFoodAddonsState {
  const factory EditFoodAddonsState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductData> addons,
  }) = _EditFoodAddonsState;

  const EditFoodAddonsState._();
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'edit_food_kitchens_state.freezed.dart';

@freezed
abstract class EditFoodKitchensState with _$EditFoodKitchensState {
  const factory EditFoodKitchensState({
    @Default(false) bool isLoading,
    @Default([]) List<KitchenModel> kitchens,
    @Default(0) int activeIndex,
    TextEditingController? kitchenController,
    KitchenModel? foodKitchen,
  }) = _EditFoodKitchensState;

  const EditFoodKitchensState._();
}

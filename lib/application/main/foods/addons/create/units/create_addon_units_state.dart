import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../infrastructure/models/models.dart';

part 'create_addon_units_state.freezed.dart';

@freezed
class CreateAddonUnitsState with _$CreateAddonUnitsState {
  const factory CreateAddonUnitsState({
    @Default(false) bool isLoading,
    @Default([]) List<UnitData> units,
    @Default(0) int activeIndex,
    TextEditingController? unitController,
  }) = _CreateAddonUnitsState;

  const CreateAddonUnitsState._();
}

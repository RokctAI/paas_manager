import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../infrastructure/models/models.dart';

part 'edit_addon_units_state.freezed.dart';

@freezed
class EditAddonUnitsState with _$EditAddonUnitsState {
  const factory EditAddonUnitsState({
    @Default(false) bool isLoading,
    @Default([]) List<UnitData> units,
    @Default(0) int activeIndex,
    TextEditingController? unitController,
    UnitData? foodUnit,
  }) = _EditAddonUnitsState;

  const EditAddonUnitsState._();
}

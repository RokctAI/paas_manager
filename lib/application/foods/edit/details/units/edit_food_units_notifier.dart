import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_units_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class EditFoodUnitsNotifier extends StateNotifier<EditFoodUnitsState> {
  final CatalogInterface _catalogRepository;

  EditFoodUnitsNotifier(this._catalogRepository)
      : super(EditFoodUnitsState(unitController: TextEditingController()));

  void setFoodUnit(UnitData? unit) {
    state = state.copyWith(foodUnit: unit);
    state.unitController?.text = unit?.translation?.title ?? '';
  }

  Future<void> fetchUnits() async {
    if (state.units.isNotEmpty) {
      List<UnitData> units = List.from(state.units);
      int? index;
      for (int i = 0; i < units.length; i++) {
        if (state.foodUnit?.id == units[i].id) {
          index = i;
        }
      }
      if (index == null) {
        if (state.foodUnit != null) {
          units.insert(0, state.foodUnit!);
        }
        state =
            state.copyWith(units: units, activeIndex: 0, foodUnit: units[0]);
        state.unitController?.text = units[0].translation?.title ?? '';
      } else {
        state = state.copyWith(
          units: units,
          activeIndex: index,
          foodUnit: units[index],
        );
        state.unitController?.text = units[index].translation?.title ?? '';
      }
      return;
    }
    List<UnitData> units = [];
    if (state.foodUnit != null) {
      units.insert(0, state.foodUnit!);
    }
    state = state.copyWith(
      isLoading: true,
      units: units,
      activeIndex: 0,
      foodUnit: units.isEmpty ? null : units[0],
    );
    final response = await _catalogRepository.getUnits();
    response.when(
      success: (data) {
        List<UnitData> units = List.from(state.units);
        final List<UnitData> newUnits = data.data ?? [];
        for (final newUnit in newUnits) {
          bool isNew = true;
          for (final oldUnit in state.units) {
            if (newUnit.id == oldUnit.id) {
              isNew = false;
            }
          }
          if (isNew) {
            units.add(newUnit);
          }
        }
        state = state.copyWith(
          units: units,
          isLoading: false,
          foodUnit: units[state.activeIndex],
        );
        if (units.isNotEmpty) {
          state.unitController?.text =
              units[state.activeIndex].translation?.title ?? '';
        }
      },
      failure: (failure,status) {

        state = state.copyWith(isLoading: false);
        debugPrint('====> fetch units fail $failure');
      },
    );
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    final newUnit = state.units[index];
    state = state.copyWith(activeIndex: index, foodUnit: newUnit);
    state.unitController?.text = newUnit.translation?.title ?? '';
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_addon_units_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import '../../../../../../../infrastructure/models/models.dart';

class CreateAddonUnitsNotifier extends StateNotifier<CreateAddonUnitsState> {
  final CatalogInterface _catalogRepository;

  CreateAddonUnitsNotifier(this._catalogRepository)
    : super(CreateAddonUnitsState(unitController: TextEditingController()));

  Future<void> fetchUnits() async {
    if (state.units.isNotEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final response = await _catalogRepository.getUnits();
    response.when(
      success: (data) {
        final List<UnitData> units = data.data ?? [];
        state = state.copyWith(units: units, isLoading: false);
        if (units.isNotEmpty) {
          state.unitController?.text =
              units[state.activeIndex].translation?.title ?? '';
        }
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        debugPrint('====> fetch units fail $failure');
      },
    );
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    state = state.copyWith(activeIndex: index);
    state.unitController?.text = state.units[index].translation?.title ?? '';
  }
}

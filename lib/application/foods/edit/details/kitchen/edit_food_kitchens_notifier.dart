import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_kitchens_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class EditFoodKitchensNotifier extends StateNotifier<EditFoodKitchensState> {
  final CatalogInterface _catalogRepository;

  EditFoodKitchensNotifier(this._catalogRepository)
      : super(EditFoodKitchensState(kitchenController: TextEditingController()));

  void setFoodKitchen(KitchenModel? unit) {
    state = state.copyWith(foodKitchen: unit);
    state.kitchenController?.text = unit?.translation?.title ?? '';
  }

  Future<void> fetchKitchens() async {
    if (state.kitchens.isNotEmpty) {
      List<KitchenModel> kitchens = List.from(state.kitchens);
      int? index;
      for (int i = 0; i < kitchens.length; i++) {
        if (state.foodKitchen?.id == kitchens[i].id) {
          index = i;
        }
      }
      if (index == null) {
        if (state.foodKitchen != null) {
          kitchens.insert(0, state.foodKitchen!);
        }
        state =
            state.copyWith(kitchens: kitchens, activeIndex: 0, foodKitchen: kitchens[0]);
        state.kitchenController?.text = kitchens[0].translation?.title ?? '';
      } else {
        state = state.copyWith(
          kitchens: kitchens,
          activeIndex: index,
          foodKitchen: kitchens[index],
        );
        state.kitchenController?.text = kitchens[index].translation?.title ?? '';
      }
      return;
    }
    List<KitchenModel> kitchens = [];
    if (state.foodKitchen != null) {
      kitchens.insert(0, state.foodKitchen!);
    }
    state = state.copyWith(
      isLoading: true,
      kitchens: kitchens,
      activeIndex: 0,
      foodKitchen: kitchens.isEmpty ? null : kitchens[0],
    );
    final response = await _catalogRepository.getKitchens();
    response.when(
      success: (data) {
        List<KitchenModel> kitchens = List.from(state.kitchens);
        final List<KitchenModel> newKitchens = data.data ?? [];
        for (final newUnit in newKitchens) {
          bool isNew = true;
          for (final oldUnit in state.kitchens) {
            if (newUnit.id == oldUnit.id) {
              isNew = false;
            }
          }
          if (isNew) {
            kitchens.add(newUnit);
          }
        }
        state = state.copyWith(
          kitchens: kitchens,
          isLoading: false,
          foodKitchen: kitchens[state.activeIndex],
        );
        if (kitchens.isNotEmpty) {
          state.kitchenController?.text =
              kitchens[state.activeIndex].translation?.title ?? '';
        }
      },
      failure: (failure,status) {

        state = state.copyWith(isLoading: false);
        debugPrint('====> fetch kitchens fail $failure');
      },
    );
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    final newUnit = state.kitchens[index];
    state = state.copyWith(activeIndex: index, foodKitchen: newUnit);
    state.kitchenController?.text = newUnit.translation?.title ?? '';
  }
}

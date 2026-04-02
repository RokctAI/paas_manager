import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_food_kitchens_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class CreateFoodKitchensNotifier
    extends StateNotifier<CreateFoodKitchensState> {
  final CatalogInterface _catalogRepository;

  CreateFoodKitchensNotifier(this._catalogRepository)
    : super(
        CreateFoodKitchensState(kitchenController: TextEditingController()),
      );

  Future<void> fetchKitchens(BuildContext context) async {
    if (state.kitchens.isNotEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final response = await _catalogRepository.getKitchens();
    response.when(
      success: (data) {
        final List<KitchenModel> kitchens = data.data ?? [];
        state = state.copyWith(kitchens: kitchens, isLoading: false);
        if (kitchens.isNotEmpty) {
          state.kitchenController?.text =
              kitchens[state.activeIndex].translation?.title ?? '';
        }
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
          context,
          text: failure,
          type: SnackBarType.error,
        );
        debugPrint('====> fetch kitchens fail $failure');
      },
    );
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    state = state.copyWith(activeIndex: index);
    state.kitchenController?.text =
        state.kitchens[index].translation?.title ?? '';
  }
}

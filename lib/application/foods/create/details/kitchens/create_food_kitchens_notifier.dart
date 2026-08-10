// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/infrastructure/models/data/kitchen_data.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_food_kitchens_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class CreateFoodKitchensNotifier extends StateNotifier<CreateFoodKitchensState> {
  final CatalogInterface _catalogRepository;

  CreateFoodKitchensNotifier(this._catalogRepository)
      : super(CreateFoodKitchensState(kitchenController: TextEditingController()));

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
      failure: (failure,status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
            context,
            text: failure,
            type: SnackBarType.error
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
    state.kitchenController?.text = state.kitchens[index].translation?.title ?? '';
  }
}

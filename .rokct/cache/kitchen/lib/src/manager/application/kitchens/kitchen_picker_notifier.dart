// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';
import 'package:base_sdk/src/handlers/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_sdk/src/manager/application/kitchens/kitchen_picker_state.dart';
import 'package:kitchen_sdk/src/common/domain/interface/kitchens.dart';
import 'package:kitchen_sdk/src/common/infrastructure/models/data/kitchen_data.dart';

/// One kitchen picker, parameterised — not a create copy and an edit copy.
///
/// `paas_manager` carried `CreateFoodKitchensNotifier` and
/// `EditFoodKitchensNotifier`. Comparing them, the edit behaviour is a strict
/// superset: it seeds the list with the product's currently-assigned kitchen,
/// then merges the fetched page in without duplicating it. Create is exactly
/// that with nothing pre-selected. So per the one-page-parameterised rule this
/// is a single implementation and [initialise] takes the difference as an
/// argument.
class KitchenPickerNotifier extends StateNotifier<KitchenPickerState> {
  KitchenPickerNotifier(this._repository)
      : super(KitchenPickerState(kitchenController: TextEditingController()));

  final KitchensRepositoryFacade _repository;

  /// Seed with the product's current kitchen, if it has one. Creating a
  /// product passes nothing.
  void initialise({KitchenModel? selected}) {
    if (selected == null) return;
    state = state.copyWith(
      kitchens: [selected],
      activeIndex: 0,
      selected: selected,
    );
    state.kitchenController?.text = selected.title;
  }

  Future<void> fetchKitchens() async {
    if (state.kitchens.length > 1) return;
    state = state.copyWith(isLoading: true);

    final response = await _repository.getKitchens();
    response.when(
      success: (data) {
        // Start from anything seeded by initialise() so the current selection
        // survives, then append only kitchens not already present. Ids are
        // Kitchen docname strings; two null ids are NOT the same kitchen —
        // fall back to the display title only when both ids are missing.
        final List<KitchenModel> kitchens = List.from(state.kitchens);
        for (final fetched in data.data ?? <KitchenModel>[]) {
          final bool alreadyListed = kitchens.any((existing) {
            if (existing.id != null && fetched.id != null) {
              return existing.id == fetched.id;
            }
            if (existing.id == null && fetched.id == null) {
              return existing.title.isNotEmpty &&
                  existing.title == fetched.title;
            }
            return false;
          });
          if (!alreadyListed) kitchens.add(fetched);
        }
        if (kitchens.isEmpty) {
          state = state.copyWith(isLoading: false);
          return;
        }
        final int index =
            state.activeIndex < kitchens.length ? state.activeIndex : 0;
        state = state.copyWith(
          kitchens: kitchens,
          isLoading: false,
          activeIndex: index,
          selected: kitchens[index],
        );
        state.kitchenController?.text = kitchens[index].title;
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false, error: failure);
        debugPrint('====> fetch kitchens fail $failure');
      },
    );
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index || index >= state.kitchens.length) return;
    final KitchenModel selected = state.kitchens[index];
    state = state.copyWith(activeIndex: index, selected: selected);
    state.kitchenController?.text = selected.title;
  }
}

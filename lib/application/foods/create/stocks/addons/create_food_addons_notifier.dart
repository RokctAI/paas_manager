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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_food_addons_state.dart';

class CreateFoodAddonsNotifier extends StateNotifier<CreateFoodAddonsState> {
  final ProductsInterface _productsRepository;
  int _page = 0;
  bool _hasMore = true;

  CreateFoodAddonsNotifier(this._productsRepository)
      : super(const CreateFoodAddonsState());

  void toggleAddonSelection(int index) {
    List<ProductData> addons = List.from(state.addons);
    addons[index] = addons[index]
        .copyWith(isSelectedAddon: !(addons[index].isSelectedAddon ?? false));
    state = state.copyWith(addons: addons);
  }

  Future<void> fetchMoreAddons(BuildContext context,{RefreshController? refreshController}) async {
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    final response = await _productsRepository.getProducts(
      page: ++_page,
      needAddons: true,
      status: ProductStatus.published,
    );
    response.when(
      success: (data) {
        List<ProductData> addons = List.from(state.addons);
        final List<ProductData> newAddons = data.data ?? [];
        addons.addAll(newAddons);
        _hasMore = newAddons.length >= 10;
        refreshController?.loadComplete();
        state = state.copyWith(addons: addons);
      },
      failure: (fail,status) {
        debugPrint('===> fetch more addons fail $fail');
        AppHelpers.showCheckTopSnackBar(
            context,
            text: fail,
            type: SnackBarType.error
        );
        refreshController?.loadFailed();
      },
    );
  }

  Future<void> initialFetchAddons(BuildContext context,Stock stock) async {
    if (state.addons.isNotEmpty) {
      List<ProductData> addons = List.from(state.addons);
      for (int i = 0; i < addons.length; i++) {
        addons[i] = addons[i].copyWith(isSelectedAddon: false);
      }
      final List<AddonData> productAddons = stock.localAddons ?? [];
      for (final productAddon in productAddons) {
        for (int i = 0; i < addons.length; i++) {
          if (addons[i].id == productAddon.product?.id) {
            addons[i] = addons[i].copyWith(isSelectedAddon: true);
          }
        }
      }
      state = state.copyWith(addons: addons);
      return;
    }
    _page = 0;
    _hasMore = true;
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getProducts(
      page: ++_page,
      needAddons: true,
      status: ProductStatus.published,
    );
    response.when(
      success: (data) {
        List<ProductData> addons = data.data ?? [];
        _hasMore = addons.length >= 10;
        for (int i = 0; i < addons.length; i++) {
          addons[i] = addons[i].copyWith(isSelectedAddon: false);
        }
        final List<AddonData> productAddons = stock.addons ?? [];
        for (final productAddon in productAddons) {
          for (int i = 0; i < addons.length; i++) {
            if (addons[i].id == productAddon.product?.id) {
              addons[i] = addons[i].copyWith(isSelectedAddon: true);
            }
          }
        }
        state = state.copyWith(isLoading: false, addons: addons);
      },
      failure: (fail,status) {
        debugPrint('===> fetch addons fail $fail');
        AppHelpers.showCheckTopSnackBar(
            context,
            text: fail,
            type: SnackBarType.error
        );
        state = state.copyWith(isLoading: false, addons: []);
      },
    );
  }
}

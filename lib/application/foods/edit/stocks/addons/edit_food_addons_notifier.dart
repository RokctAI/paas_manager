import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_addons_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class EditFoodAddonsNotifier extends StateNotifier<EditFoodAddonsState> {
  final ProductsInterface _productsRepository;
  int _page = 0;
  bool _hasMore = true;

  EditFoodAddonsNotifier(this._productsRepository)
      : super(const EditFoodAddonsState());

  void toggleAddonSelection(int index) {
    List<ProductData> addons = List.from(state.addons);
    addons[index] = addons[index]
        .copyWith(isSelectedAddon: !(addons[index].isSelectedAddon ?? false));
    state = state.copyWith(addons: addons);
  }

  Future<void> fetchMoreAddons({RefreshController? refreshController}) async {
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
        refreshController?.loadFailed();
      },
    );
  }

  Future<void> initialFetchAddons(Stock stock) async {
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
        state = state.copyWith(isLoading: false, addons: []);
      },
    );
  }
}

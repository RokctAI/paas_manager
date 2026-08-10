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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'food_categories_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class FoodCategoriesNotifier extends StateNotifier<FoodCategoriesState> {
  final CatalogInterface _catalogRepository;
  int _page = 0;
  bool _hasMore = true;

  FoodCategoriesNotifier(this._catalogRepository)
      : super(const FoodCategoriesState());

  Future<void> initialFetchCategories() async {
    _page = 0;
    _hasMore = true;
    state = state.copyWith(activeIndex: 1, categories: [], isLoading: true);
    final response = await _catalogRepository.getCategories(page: ++_page);
    response.when(
      success: (data) {
        final List<CategoryData> categories = data.data ?? [];
        _hasMore = categories.length >= 10;
        state = state.copyWith(categories: categories, isLoading: false);
      },
      failure: (failure, status) {
        debugPrint('====> initial fetch categories fail $failure');
        _page--;
        state = state.copyWith(isLoading: false);
      },
    );
  }

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    state = state.copyWith(activeIndex: index);
  }

  Future<void> fetchCategories({
    required BuildContext context,
    RefreshController? refreshController,
    bool openingPage = false,
  }) async {
    if (openingPage) {
      if (state.activeIndex != 1) {
        state = state.copyWith(activeIndex: 1);
      }
      if (state.categories.isNotEmpty) {
        return;
      }
    }
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    if (_page == 0) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _catalogRepository.getCategories(page: ++_page);
    response.when(
      success: (data) {
        List<CategoryData> categories = List.from(state.categories);
        final List<CategoryData> newCategories = data.data ?? [];
        categories.addAll(newCategories);
        _hasMore = newCategories.length >= 10;
        if (_page == 1) {
          state = state.copyWith(isLoading: false, categories: categories);
        } else {
          state = state.copyWith(categories: categories);
        }
        refreshController?.loadComplete();
      },
      failure: (failure, status) {
        debugPrint('====> fetch categories fail $failure');
        _page--;
        if (_page == 0) {
          state = state.copyWith(isLoading: false);
        }
        AppHelpers.showCheckTopSnackBar(
          context,
          text: failure,
          type: SnackBarType.error
        );
        refreshController?.loadFailed();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

import '../../../infrastructure/services/services.dart';
import 'categories_state.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  CategoriesNotifier() : super(const CategoriesState());

  int _page = 0;
  int _comboPage = 0;

  Future<void> fetchCategories(
    BuildContext context, {
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(categories: [], isLoading: true);
    }
    final res = await catalogRepository.getCategories(
      page: ++_page,
      hasProducts: true,
    );
    res.when(
      success: (data) {
        List<CategoryData> list = List.from(state.categories);
        list.addAll(data.data ?? []);
        state = state.copyWith(isLoading: false, categories: list);
        if (isRefresh ?? false) {
          controller?.refreshCompleted();
          return;
        } else if (data.data?.isEmpty ?? true) {
          controller?.loadNoData();
          return;
        }
        controller?.loadComplete();
        return;
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.errorSnackBar(context, text: failure);
      },
    );
  }

  Future<void> fetchComboCategories(
    BuildContext context, {
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _comboPage = 0;
      state = state.copyWith(comboCategories: [], isComboLoading: true);
    }
    final res = await catalogRepository.getCategories(
      page: ++_comboPage,
      type: 'combo',
      hasProducts: true,
    );
    res.when(
      success: (data) {
        List<CategoryData> list = List.from(state.comboCategories);
        list.addAll(data.data ?? []);
        state = state.copyWith(isComboLoading: false, comboCategories: list);
        if (isRefresh ?? false) {
          controller?.refreshCompleted();
          return;
        } else if (data.data?.isEmpty ?? true) {
          controller?.loadNoData();
          return;
        }
        controller?.loadComplete();
        return;
      },
      failure: (failure, status) {
        state = state.copyWith(isComboLoading: false);
        AppHelpers.errorSnackBar(context, text: failure);
      },
    );
  }

  void setActiveIndex(int index, {bool isCombo = false}) {
    if (isCombo) {
      if (state.activeComboIndex == index) {
        return;
      }
      state = state.copyWith(activeComboIndex: index);
    } else {
      if (state.activeIndex == index) {
        return;
      }
      state = state.copyWith(activeIndex: index);
    }
  }
}

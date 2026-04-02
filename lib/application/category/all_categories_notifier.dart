import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'all_categories_state.dart';

class AllCategoriesNotifier extends StateNotifier<AllCategoriesState> {
  int _page = 0;

  AllCategoriesNotifier()
    : super(AllCategoriesState(categoryController: TextEditingController()));

  Future<void> updateCategories(
    BuildContext context, {
    RefreshController? controller,
    String? type,
  }) async {
    if (controller == null) {
      _page = 0;
    }

    final response = await catalogRepository.getCategories(
      page: ++_page,
      type: type,
    );
    response.when(
      success: (data) {
        final bool isCombo = type == 'combo';
        List<CategoryData> categories = isCombo
            ? List.from(state.comboCategories)
            : List.from(state.categories);
        final List<CategoryData> newCategories = data.data ?? [];
        for (final category in newCategories) {
          bool contains = false;
          for (final oldCategory in categories) {
            if (category.id == oldCategory.id) {
              contains = true;
            }
          }
          if (!contains) {
            categories.insert(0, category);
          }
        }

        if (isCombo) {
          state = state.copyWith(
            comboCategories: categories,
            activeComboIndex: 0,
          );
          if (categories.isNotEmpty) {
            state.categoryController?.text =
                state.comboCategories[0].translation?.title ?? '';
          }
        } else {
          state = state.copyWith(categories: categories, activeIndex: 0);
          if (categories.isNotEmpty) {
            state.categoryController?.text =
                state.categories[0].translation?.title ?? '';
          }
        }

        controller?.loadComplete();

        if (data.data?.isEmpty ?? true) {
          controller?.loadNoData();
        }
      },
      failure: (failure, status) {
        debugPrint('====> fetch categories fail $failure');
        _page--;
        AppHelpers.showCheckTopSnackBar(
          context,
          text: failure,
          type: SnackBarType.error,
        );
      },
    );
  }

  Future<void> updateCategoriesSub(
    BuildContext context, {
    RefreshController? controller,
  }) async {
    if (controller == null) {
      _page = 0;
    }

    final response = await catalogRepository.getCategoriesSub(page: ++_page);
    response.when(
      success: (data) {
        List<CategoryData> categories = List.from(state.categoriesSub);
        final List<CategoryData> newCategories = data.data ?? [];
        for (final category in newCategories) {
          bool contains = false;
          for (final oldCategory in categories) {
            if (category.id == oldCategory.id) {
              contains = true;
            }
          }
          if (!contains) {
            categories.insert(0, category);
          }
        }
        state = state.copyWith(categoriesSub: categories, activeIndex: 0);
        if (categories.isNotEmpty) {
          state.categorySubController?.text =
              state.categoriesSub[0].translation?.title ?? '';
        }

        controller?.loadComplete();

        if (data.data?.isEmpty ?? true) {
          controller?.loadNoData();
        }
      },
      failure: (failure, status) {
        debugPrint('====> fetch categories fail $failure');
        _page--;
        AppHelpers.showCheckTopSnackBar(
          context,
          text: failure,
          type: SnackBarType.error,
        );
      },
    );
  }

  void setActiveIndex(int index, {bool isCombo = false}) {
    if (isCombo) {
      if (state.activeComboIndex == index) {
        return;
      }
      state = state.copyWith(activeComboIndex: index);
      state.categoryController?.text =
          state.comboCategories[index].translation?.title ?? '';
    } else {
      if (state.activeIndex == index) {
        return;
      }
      state = state.copyWith(activeIndex: index);
      state.categoryController?.text =
          state.categories[index].translation?.title ?? '';
    }
  }

  void setActiveIndexSub(int index) {
    if (state.activeSubIndex == index) {
      return;
    }

    state = state.copyWith(
      activeSubIndex: index,
      categorySubController: TextEditingController(
        text: state.categoriesSub[index].translation?.title ?? '',
      ),
    );
  }

  void setCategories(List<CategoryData> categories) {
    if (state.categories.isEmpty) {
      _page = 0;
      state = state.copyWith(categories: categories, activeIndex: 0);
      if (categories.isNotEmpty) {
        state.categoryController?.text =
            state.categories[0].translation?.title ?? '';
      }
    }
  }

  Future<void> deleteCategories(CategoryData category) async {
    final res = await catalogRepository.deleteCategory(id: category.id);
    res.when(
      success: (success) {
        final List<CategoryData> list = List.from(state.categories);
        list.remove(category);
        state = state.copyWith(categories: list, activeIndex: 0);
      },
      failure: (failure, s) {
        debugPrint("delete categories fail: $failure");
      },
    );
  }

  void setCategoriesSub(List<CategoryData> categories) {
    if (state.categoriesSub.isEmpty) {
      _page = 0;
      state = state.copyWith(categoriesSub: categories, activeSubIndex: 0);
      if (categories.isNotEmpty) {
        state.categorySubController?.text =
            state.categoriesSub[0].translation?.title ?? '';
      }
    }
  }

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
}

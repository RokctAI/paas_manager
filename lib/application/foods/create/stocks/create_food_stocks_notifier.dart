import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_food_stocks_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class CreateFoodStocksNotifier extends StateNotifier<CreateFoodStocksState> {
  final ProductsInterface _productsRepository;
  List<Stock> _localStocks = [];
  List<Stock> _oldStocks = [];

  CreateFoodStocksNotifier(this._productsRepository)
    : super(const CreateFoodStocksState());

  void setStockAddons(List<ProductData> addons, int stockIndex) {
    List<AddonData> checkedAddons = [];
    for (final addon in addons) {
      if (addon.isSelectedAddon ?? false) {
        checkedAddons.add(AddonData(addonId: addon.id, product: addon));
      }
    }
    _localStocks[stockIndex] = _localStocks[stockIndex].copyWith(
      localAddons: checkedAddons,
    );
    state = state.copyWith(stocks: _localStocks);
    debugPrint(
      '===> set selected addon ${_localStocks[stockIndex].localAddons?.length}',
    );
  }

  void toggleCheckedGroup(int groupIndex) {
    List<Group> groups = List.from(state.groups);
    final bool check = state.selectGroups.containsKey(
      groups[groupIndex].id.toString(),
    );
    groups[groupIndex] = groups[groupIndex].copyWith(isChecked: check);
    state = state.copyWith(groups: groups);
  }

  List<Group> _checkGroupsChecked(List<Group> groups) {
    for (int i = 0; i < groups.length; i++) {
      groups[i] = groups[i].copyWith(isChecked: false);
    }
    if (state.stocks.isNotEmpty) {
      final List<Extras> stockExtras = state.stocks.first.extras ?? [];
      for (int i = 0; i < groups.length; i++) {
        for (final extras in stockExtras) {
          if (extras.extraGroupId == groups[i].id) {
            groups[i] = groups[i].copyWith(isChecked: true);
          }
        }
      }
    }
    return groups;
  }

  Future<void> fetchGroups() async {
    if (state.groups.isNotEmpty) {
      List<Group> groups = List.from(state.groups);
      groups = _checkGroupsChecked(groups);
      state = state.copyWith(groups: groups);
      return;
    }
    state = state.copyWith(isFetchingGroups: true);
    final response = await _productsRepository.getExtrasGroups();
    response.when(
      success: (data) {
        List<Group> groups = data.data ?? [];
        state = state.copyWith(
          groups: _checkGroupsChecked(groups),
          isFetchingGroups: false,
        );
      },
      failure: (fail, status) {
        state = state.copyWith(isFetchingGroups: false);
      },
    );
  }

  Future<void> setActiveExtrasIndex({
    required int itemIndex,
    required int groupIndex,
  }) async {
    String key = state.groups[groupIndex].id.toString();
    Extras extras = state.groups[groupIndex].fetchedExtras![itemIndex];
    Map<String, List<Extras?>> selectGroups = Map.from(state.selectGroups);
    if (selectGroups.containsKey(key)) {
      List<Extras?> list = selectGroups[key] ?? [];
      if (list.any((element) => element?.id == extras.id)) {
        list.removeWhere((element) => element?.id == extras.id);
        list.isEmpty ? selectGroups.remove(key) : selectGroups[key] = list;
      } else {
        list.add(state.groups[groupIndex].fetchedExtras![itemIndex]);
        selectGroups[key] = list;
      }
    } else {
      selectGroups[key] = [state.groups[groupIndex].fetchedExtras![itemIndex]];
    }
    state = state.copyWith(selectGroups: selectGroups);
    toggleCheckedGroup(groupIndex);
    combination();
    state = state.copyWith(stocks: _localStocks);
  }

  void combination() {
    List<Stock> stocks = [];
    if (state.selectGroups.values.isNotEmpty) {
      List<List<Extras>> list = AppHelpers.cartesian(
        List.from(state.selectGroups.values),
      );
      stocks = List.generate(
        list.length,
        (index) => Stock(extras: list[index]),
      );
    } else {
      stocks = [Stock()];
    }
    for (int i = 0; i < _oldStocks.length; i++) {
      if (i < stocks.length) {
        stocks[i] = stocks[i].copyWith(
          price: _oldStocks[i].price,
          quantity: _oldStocks[i].quantity,
        );
      }
    }

    _localStocks = stocks;
  }

  Future<void> fetchGroupExtras(
    BuildContext context, {
    required int groupIndex,
    VoidCallback? onSuccess,
  }) async {
    if (state.groups[groupIndex].fetchedExtras?.isNotEmpty ?? false) {
      state = state.copyWith(
        activeGroupExtras: state.groups[groupIndex].fetchedExtras ?? [],
      );
      return;
    }
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getExtras(
      groupId: state.groups[groupIndex].id,
    );
    response.when(
      success: (data) {
        final List<Extras> fetchedExtras = data.data?.extraValues ?? <Extras>[];
        List<Group> activeGroups = List.from(state.groups);
        activeGroups[groupIndex] = activeGroups[groupIndex].copyWith(
          fetchedExtras: fetchedExtras,
        );

        /// save fetched extras to groups
        List<Group> groups = List.from(state.groups);
        int mainGroupIndex = 0;
        for (int i = 0; i < groups.length; i++) {
          if (groups[i].id == activeGroups[groupIndex].id) {
            mainGroupIndex = i;
          }
        }
        groups[mainGroupIndex] = groups[mainGroupIndex].copyWith(
          fetchedExtras: fetchedExtras,
        );
        state = state.copyWith(
          isLoading: false,
          activeGroupExtras: fetchedExtras,
          groups: groups,
          stocks: _localStocks,
        );
      },
      failure: (fail, status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
          context,
          text: fail,
          type: SnackBarType.error,
        );
        debugPrint('===> group extras fetching failed $fail');
      },
    );
  }

  void deleteStock(int index) {
    _localStocks.removeAt(index);
    state = state.copyWith(stocks: _localStocks);
  }

  void setQuantity({required String value, required int index}) {
    _localStocks[index] = _localStocks[index].copyWith(
      quantity: int.tryParse(value.trim()),
    );
  }

  void setSku({required String value, required int index}) {
    _localStocks[index] = _localStocks[index].copyWith(sku: value.trim());
  }

  void setPrice({required String value, required int index}) {
    _localStocks[index] = _localStocks[index].copyWith(
      price: num.tryParse(value.trim()),
    );
  }

  Future<void> updateStocks(
    BuildContext context, {
    String? uuid,
    VoidCallback? updated,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isSaving: true);
    final response = await _productsRepository.updateStocks(
      deletedStocks: [],
      stocks: _localStocks,
      uuid: uuid,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isSaving: false);
        updated?.call();
      },
      failure: (fail, status) {
        state = state.copyWith(isSaving: false);
        AppHelpers.showCheckTopSnackBar(
          context,
          text: fail,
          type: SnackBarType.error,
        );
        failed?.call();
      },
    );
  }

  void addEmptyStock() {
    List<Extras>? extras = _localStocks.last.extras;
    extras = extras?.map((e) => e.copyWith(value: null)).toList();
    _localStocks.add(
      _localStocks.last.copyWith(isInitial: true, extras: extras),
    );
    state = state.copyWith(stocks: _localStocks);
  }

  void setInitialStocks() {
    final List<Stock> stocks = [Stock()];
    state = state.copyWith(stocks: stocks, selectGroups: {});
    _localStocks = stocks;
    _oldStocks = stocks;
    fetchGroups();
  }
}

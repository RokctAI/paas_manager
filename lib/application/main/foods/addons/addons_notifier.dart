import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'addons_state.dart';

class AddonsNotifier extends StateNotifier<AddonsState> {
  final ProductsInterface _productsRepository;
  int _page = 0;
  bool _hasMore = true;
  Timer? _timer;
  String _query = '';

  AddonsNotifier(this._productsRepository) : super(const AddonsState());

  Future<void> _search() async {
    _hasMore = true;
    _page = 0;
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getProducts(
      page: ++_page,
      query: _query.isEmpty ? null : _query.trim(),
      needAddons: true,
    );
    response.when(
      success: (data) {
        final List<ProductData> addons = data.data ?? [];
        _hasMore = addons.length >= 10;
        state = state.copyWith(addons: addons, isLoading: false);
      },
      failure: (fail, status) {
        debugPrint('===> search addon fail $fail');
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> fetchMoreAddons({RefreshController? refreshController}) async {
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    final response = await _productsRepository.getProducts(
      page: ++_page,
      query: _query.isEmpty ? null : _query.trim(),
      needAddons: true,
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
      failure: (fail, status) {
        debugPrint('===> fetch more addons fail $fail');
        refreshController?.loadFailed();
      },
    );
  }

  Future<void> initialFetchAddons() async {
    if (state.addons.isNotEmpty) {
      return;
    }
    _page = 0;
    _hasMore = true;
    _query = '';
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getProducts(
      page: ++_page,
      needAddons: true,
    );
    response.when(
      success: (data) {
        List<ProductData> addons = data.data ?? [];
        _hasMore = addons.length >= 10;
        state = state.copyWith(isLoading: false, addons: addons);
      },
      failure: (fail, status) {
        debugPrint('===> fetch addons fail $fail');
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> refreshAddons({RefreshController? refreshController}) async {
    refreshController?.resetNoData();
    _hasMore = true;
    _page = 0;
    final response = await _productsRepository.getProducts(
      page: ++_page,
      query: _query.isEmpty ? null : _query.trim(),
      needAddons: true,
    );
    response.when(
      success: (data) {
        final List<ProductData> addons = data.data ?? [];
        state = state.copyWith(addons: addons);
        _hasMore = addons.length >= 10;
        refreshController?.refreshCompleted();
      },
      failure: (error, status) {
        debugPrint('===> refresh addons fail $error');
        refreshController?.refreshFailed();
      },
    );
  }

  void updateSingleAddon(ProductData? addon) {
    List<ProductData> addons = List.from(state.addons);
    int? index;
    for (int i = 0; i < addons.length; i++) {
      if (addon?.id == addons[i].id) {
        index = i;
      }
    }
    if (index != null && addon != null) {
      addons[index] = addon;
      state = state.copyWith(addons: addons);
    }
  }

  void setQuery(String text) {
    if (_query == text) {
      return;
    }
    _query = text.trim();
    if (_query.isNotEmpty) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(const Duration(milliseconds: 500), () => _search());
    } else {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(const Duration(milliseconds: 500), () => _search());
    }
  }
}

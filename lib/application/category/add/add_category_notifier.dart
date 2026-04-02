import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'add_category_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class AddCategoryNotifier extends StateNotifier<AddCategoryState> {
  final CatalogInterface _catalogRepository;
  String _title = '';
  String _input = '';

  AddCategoryNotifier(this._catalogRepository)
    : super(const AddCategoryState());

  Future<void> createCategory(
    BuildContext context, {
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _catalogRepository.createCategory(
      title: _title,
      input: int.tryParse(_input),
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (fail, status) {
        debugPrint('===> create category fail $fail');
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
          context,
          text: fail,
          type: SnackBarType.error,
        );
      },
    );
  }

  void setTitle(String value) {
    _title = value.trim();
  }

  void setInput(String value) {
    _input = value.trim();
  }
}

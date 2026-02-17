import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'edit_extras_item_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class EditExtrasItemNotifier extends StateNotifier<EditExtrasItemState> {
  final ProductsInterface _productsRepository;
  String _title = '';

  EditExtrasItemNotifier(this._productsRepository)
      : super(const EditExtrasItemState());

  Future<void> updateExtrasItem(BuildContext context,{
    VoidCallback? success,
    int? groupId,
    int? extrasId,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.updateExtrasItem(
      extrasId: extrasId ?? 0,
      title: _title,
      groupId: groupId ?? 0,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (fail,status) {
        debugPrint('===> update extras item fail $fail');
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
            context,
            text: fail,
            type: SnackBarType.error
        );
      },
    );
  }

  void setTitle(String value) {
    _title = value.trim();
  }
}

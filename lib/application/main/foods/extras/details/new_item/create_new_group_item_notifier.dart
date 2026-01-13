import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_new_group_item_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class CreateNewGroupItemNotifier
    extends StateNotifier<CreateNewGroupItemState> {
  final ProductsInterface _productsRepository;
  String _title = '';

  CreateNewGroupItemNotifier(this._productsRepository)
      : super(const CreateNewGroupItemState());

  Future<void> createExtrasItem(BuildContext context,{VoidCallback? success, int? groupId}) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.createExtrasItem(
      title: _title,
      groupId: groupId ?? 0,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (fail,status) {
        debugPrint('===> create extras item fail $fail');
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

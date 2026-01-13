import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'extras_group_details_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class ExtrasGroupDetailsNotifier
    extends StateNotifier<ExtrasGroupDetailsState> {
  final ProductsInterface _productsRepository;

  ExtrasGroupDetailsNotifier(this._productsRepository)
      : super(const ExtrasGroupDetailsState());

  Future<void> fetchGroupExtras({int? groupId}) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getExtras(groupId: groupId);
    response.when(
      success: (data) {
        state = state.copyWith(
          extras: data.data?.extraValues ?? [],
          isLoading: false,
        );
      },
      failure: (fail,status) {
        debugPrint('===> fetch extras fail $fail');
        state = state.copyWith(isLoading: false);
      },
    );
  }
}

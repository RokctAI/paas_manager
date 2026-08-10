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

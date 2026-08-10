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

import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'create_extras_group_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';

class CreateExtrasGroupNotifier extends StateNotifier<CreateExtrasGroupState> {
  final ProductsInterface _productsRepository;
  String _title = '';

  CreateExtrasGroupNotifier(this._productsRepository)
      : super(const CreateExtrasGroupState());

  Future<void> createExtrasGroup(BuildContext context,{VoidCallback? success}) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.createExtrasGroup(title: _title);
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (fail,status) {
        debugPrint('===> create extras group fail $fail');
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

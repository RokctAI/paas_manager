import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'working_days_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class WorkingDaysNotifier extends StateNotifier<WorkingDaysState> {
  final UsersInterface _usersRepository;

  WorkingDaysNotifier(this._usersRepository) : super(const WorkingDaysState());

  Future<void> updateWorkingDays({
    required List<ShopWorkingDays> days,
    String? shopUuid,
    VoidCallback? updateSuccess,
  }) async {
    state = state.copyWith(isLoading: true, workingDays: days);
    final response = await _usersRepository.updateShopWorkingDays(
      workingDays: days,
      uuid: shopUuid,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        updateSuccess?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> error update working days $failure');
      },
    );
  }

  void setShopWorkingDays(List<ShopWorkingDays> workingDays) async {
    state = state.copyWith(workingDays: workingDays);
  }

  void changeIndex(ShopWorkingDays? day) {
    int index = 0;
    if (day != null) {
      for (int i = 0; i < state.workingDays.length; i++) {
        if (state.workingDays[i].id == day.id) {
          index = i;
        }
      }
    }
    state = state.copyWith(currentIndex: index);
  }
}

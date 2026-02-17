import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'working_days_state.freezed.dart';

@freezed
abstract class WorkingDaysState with _$WorkingDaysState {
  const factory WorkingDaysState({
    @Default(false) bool isLoading,
    @Default(0) int currentIndex,
    @Default([]) List<ShopWorkingDays> workingDays,
  }) = _WorkingDaysState;

  const WorkingDaysState._();
}

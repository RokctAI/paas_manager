import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'addons_state.freezed.dart';

@freezed
class AddonsState with _$AddonsState {
  const factory AddonsState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductData> addons,
  }) = _AddonsState;

  const AddonsState._();
}

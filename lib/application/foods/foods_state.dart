import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'foods_state.freezed.dart';

@freezed
class FoodsState with _$FoodsState {
  const factory FoodsState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductData> foods,
  }) = _FoodsState;

  const FoodsState._();
}

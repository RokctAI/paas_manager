import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'order_details_state.freezed.dart';

@freezed
abstract class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    OrderData? order,
  }) = _OrderDetailsState;

  const OrderDetailsState._();
}

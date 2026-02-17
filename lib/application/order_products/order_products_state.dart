import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'order_products_state.freezed.dart';

@freezed
abstract class OrderProductsState with _$OrderProductsState {
  const factory OrderProductsState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductData> products,
    @Default('single') String productType,
  }) = _OrderProductsState;

  const OrderProductsState._();
}

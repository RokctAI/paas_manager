import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'foods_filter_state.freezed.dart';

@freezed
class FoodsFilterState with _$FoodsFilterState {
  const factory FoodsFilterState({
    // @Default(null) FilterModel? filterModel,
    @Default(false) bool checked,
    @Default(0) int shopCount,
    @Default(100) double endPrice,
    @Default(false) bool isLoading,
    @Default(false) bool isTagLoading,
    @Default(true) bool isShopLoading,
    @Default(true) bool isRestaurantLoading,
    @Default(RangeValues(1, 100)) RangeValues rangeValues,
    // @Default([]) List<ShopData> shops,
    @Default([]) List<String> tags,
    @Default([]) List<int> prices,
    // @Default([]) List<ShopData> restaurant,
  }) = _FoodsFilterState;

  const FoodsFilterState._();
}

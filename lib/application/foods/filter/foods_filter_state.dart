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

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

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'create_food_details_state.freezed.dart';

@freezed
class CreateFoodDetailsState with _$CreateFoodDetailsState {
  const factory CreateFoodDetailsState({
    @Default('') String title,
    @Default('') String description,
    @Default('') String tax,
    @Default('') String minQty,
    @Default('') String maxQty,
    @Default('') String qrcode,
    @Default('') String interval,
    @Default(true) bool active,
    @Default(false) bool isCreating,
    @Default([]) List<String> images,
    @Default([]) List<Galleries> listOfUrls,
    ProductData? createdProduct,
  }) = _CreateFoodDetailsState;

  const CreateFoodDetailsState._();
}

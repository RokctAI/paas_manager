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

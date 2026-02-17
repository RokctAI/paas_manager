import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'edit_food_details_state.freezed.dart';

@freezed
abstract class EditFoodDetailsState with _$EditFoodDetailsState {
  const factory EditFoodDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool active,
    @Default('') String title,
    @Default('') String interval,
    @Default('') String description,
    @Default({}) Map<String, String> titleTranslations,
    @Default({}) Map<String, String> descriptionTranslations,
    @Default('') String minQty,
    @Default('') String maxQty,
    @Default('') String tax,
    @Default('') String barcode,
    ProductData? product,
    @Default([]) List<String> images,
    @Default([]) List<Galleries> listOfUrls,
    @Default({}) Map<String, List<String>> mapOfDesc,
    LanguageData? language,
  }) = _EditFoodDetailsState;

  const EditFoodDetailsState._();
}

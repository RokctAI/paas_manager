import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'create_food_stocks_state.freezed.dart';

@freezed
abstract class CreateFoodStocksState with _$CreateFoodStocksState {
  const factory CreateFoodStocksState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isFetchingGroups,
    @Default([]) List<Group> groups,
    @Default([]) List<Stock> stocks,
    @Default([]) List<Extras> activeGroupExtras,
    @Default({}) Map<String, List<Extras?>> selectGroups,
  }) = _CreateFoodStocksState;

  const CreateFoodStocksState._();
}

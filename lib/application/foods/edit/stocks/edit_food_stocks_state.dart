import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'edit_food_stocks_state.freezed.dart';

@freezed
class EditFoodStocksState with _$EditFoodStocksState {
  const factory EditFoodStocksState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isFetchingGroups,
    @Default([]) List<int> deleteStocks,
    @Default([]) List<Group> groups,
    @Default([]) List<Stock> stocks,
    @Default([]) List<Extras> activeGroupExtras,
    @Default({}) Map<String,List<Extras?>> selectGroups,
  }) = _EditFoodStocksState;

  const EditFoodStocksState._();
}
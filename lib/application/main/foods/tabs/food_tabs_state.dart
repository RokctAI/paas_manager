import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_tabs_state.freezed.dart';

@freezed
class FoodTabsState with _$FoodTabsState {
  const factory FoodTabsState({@Default(0) int selectedIndex}) = _FoodTabsState;

  const FoodTabsState._();
}

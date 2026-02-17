import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_category_state.freezed.dart';

@freezed
abstract class AddCategoryState with _$AddCategoryState {
  const factory AddCategoryState({@Default(false) bool isLoading}) =
      _AddCategoryState;

  const AddCategoryState._();
}

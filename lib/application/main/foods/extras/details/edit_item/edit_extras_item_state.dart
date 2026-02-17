import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_extras_item_state.freezed.dart';

@freezed
class EditExtrasItemState with _$EditExtrasItemState {
  const factory EditExtrasItemState({@Default(false) bool isLoading}) =
      _EditExtrasItemState;

  const EditExtrasItemState._();
}

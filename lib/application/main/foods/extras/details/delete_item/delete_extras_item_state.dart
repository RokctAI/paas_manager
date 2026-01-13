import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_extras_item_state.freezed.dart';

@freezed
class DeleteExtrasItemState with _$DeleteExtrasItemState {
  const factory DeleteExtrasItemState({@Default(false) bool isLoading}) =
      _DeleteExtrasItemState;

  const DeleteExtrasItemState._();
}

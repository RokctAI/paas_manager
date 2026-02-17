import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_new_group_item_state.freezed.dart';

@freezed
class CreateNewGroupItemState with _$CreateNewGroupItemState {
  const factory CreateNewGroupItemState({@Default(false) bool isLoading}) =
      _CreateNewGroupItemState;

  const CreateNewGroupItemState._();
}

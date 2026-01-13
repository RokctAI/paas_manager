import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_extras_group_state.freezed.dart';

@freezed
class DeleteExtrasGroupState with _$DeleteExtrasGroupState {
  const factory DeleteExtrasGroupState({@Default(false) bool isLoading}) =
      _DeleteExtrasGroupState;

  const DeleteExtrasGroupState._();
}

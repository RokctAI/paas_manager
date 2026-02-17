import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_extras_group_state.freezed.dart';

@freezed
class CreateExtrasGroupState with _$CreateExtrasGroupState {
  const factory CreateExtrasGroupState({@Default(false) bool isLoading}) =
      _CreateExtrasGroupState;

  const CreateExtrasGroupState._();
}

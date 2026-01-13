import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_extras_group_state.freezed.dart';

@freezed
class UpdateExtrasGroupState with _$UpdateExtrasGroupState {
  const factory UpdateExtrasGroupState({@Default(false) bool isLoading}) =
      _UpdateExtrasGroupState;

  const UpdateExtrasGroupState._();
}

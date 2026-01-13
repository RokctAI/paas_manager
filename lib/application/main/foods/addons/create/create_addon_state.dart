import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_addon_state.freezed.dart';

@freezed
class CreateAddonState with _$CreateAddonState {
  const factory CreateAddonState({@Default(false) bool isLoading}) =
      _CreateAddonState;

  const CreateAddonState._();
}

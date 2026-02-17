import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_addon_state.freezed.dart';

@freezed
abstract class EditAddonState with _$EditAddonState {
  const factory EditAddonState({
    @Default(false) bool isLoading,
    @Default({}) Map<String, List<String>> mapOfDesc,
  }) = _EditAddonState;

  const EditAddonState._();
}

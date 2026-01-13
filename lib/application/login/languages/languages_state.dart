import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../infrastructure/models/models.dart';

part 'languages_state.freezed.dart';

@freezed
class LanguagesState with _$LanguagesState {
  const factory LanguagesState({
    @Default([]) List<LanguageData> languages,
    @Default(0) int index,
    @Default(true) bool isLoading,
    @Default(true) bool isSelectLanguage,
  }) = _LanguagesState;

  const LanguagesState._();
}

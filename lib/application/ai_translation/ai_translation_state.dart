import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/models/models.dart';

part 'ai_translation_state.freezed.dart';

@freezed
abstract class AiTranslationState with _$AiTranslationState {
  const factory AiTranslationState({
    @Default(false) bool isLoading,
    @Default(false) bool translatedUsingAi,
    LanguageData? selectedLanguage,
  }) = _AiTranslationState;

  const AiTranslationState._();
}

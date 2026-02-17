import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/di/dependency_manager.dart';
import '../../infrastructure/models/models.dart';
import 'ai_translation_state.dart';

class AiTranslationNotifier extends StateNotifier<AiTranslationState> {
  AiTranslationNotifier() : super(const AiTranslationState());

  Future<void> getAiTranslation({
    required AiTranslationRequest model,
    ValueChanged<String?>? onSuccess,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await settingsRepository.getAiTranslation(
      model: model,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false, translatedUsingAi: true);
        onSuccess?.call(data.data?.title);
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  void setLanguage(LanguageData language) {
    if (state.selectedLanguage == language) return;
    state = state.copyWith(
      selectedLanguage: language,
      translatedUsingAi: false,
    );
  }

  void setTranslatedUsingAi(bool value) {
    if (state.translatedUsingAi == value) return;
    state = state.copyWith(translatedUsingAi: value);
  }
}

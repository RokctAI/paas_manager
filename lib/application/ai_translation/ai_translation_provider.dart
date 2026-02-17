import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ai_translation_notifier.dart';
import 'ai_translation_state.dart';

final aiTranslationProvider =
    StateNotifierProvider.autoDispose<
      AiTranslationNotifier,
      AiTranslationState
    >((ref) => AiTranslationNotifier());

import '../../services/services.dart';
import '../data/language.dart';

class AiTranslationRequest {
  final AiTranslationModel model;
  final int? modelId;
  final LanguageData? lang;
  final String? content;

  AiTranslationRequest({
    required this.model,
    required this.modelId,
    required this.lang,
    this.content,
  });

  Map<String, Object?> toJson() {
    return {
      'model_type': model.type,
      if (modelId != null) 'model_id': modelId,
      'content': content,
      'lang': lang?.locale,
    };
  }
}

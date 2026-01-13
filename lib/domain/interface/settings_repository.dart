import 'package:venderfoodyman/infrastructure/models/data/generate_image_model.dart';

import '../handlers/handlers.dart';
import '../../infrastructure/models/models.dart';
import '../../infrastructure/services/services.dart';

abstract class SettingsRepository {
  Future<ApiResult<GalleryUploadResponse>> uploadImage(
    String filePath,
    UploadType uploadType,
  );

  Future<ApiResult<MultiGalleryUploadResponse>> uploadMultiImage(
      List<String?> filePaths,
      UploadType uploadType,
      );

  Future<ApiResult<CurrenciesResponse>> getCurrencies();

  Future<ApiResult<SettingsResponse>> getGlobalSettings();

  Future<ApiResult<TranslationsResponse>> getTranslations();

  Future<ApiResult<LanguagesResponse>> getLanguages();

  Future<ApiResult<GenerateImageModel>> getGenerateImage(String name);
}

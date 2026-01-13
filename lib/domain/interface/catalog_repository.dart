import '../handlers/handlers.dart';
import '../../infrastructure/models/models.dart';

abstract class CatalogRepository {
  Future<ApiResult<UnitsPaginateResponse>> getUnits();

  Future<ApiResult<KitchensPaginateResponse>> getKitchens();

  Future<ApiResult<void>> createCategory({
    required String title,
    int? input,
  });

  Future<ApiResult<CategoriesPaginateResponse>> getCategories({
    int? page,
    String? query,
  });

  Future<ApiResult<CategoriesPaginateResponse>> getCategoriesSub({
    int? page,
    String? query,
  });

  Future<ApiResult> deleteCategory({required int? id});
}

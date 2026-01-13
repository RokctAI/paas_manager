import '../handlers/handlers.dart';
import '../../infrastructure/models/models.dart';
import '../../infrastructure/services/services.dart';

abstract class ProductsRepository {
  Future<ApiResult<void>> deleteExtrasGroup({int? groupId});

  Future<ApiResult<SingleExtrasGroupResponse>> updateExtrasGroup({
    required String title,
    int? groupId,
  });

  Future<ApiResult<void>> deleteExtrasItem({
    required int extrasId,
  });

  Future<ApiResult<CreateGroupExtrasResponse>> updateExtrasItem({
    required int extrasId,
    required int groupId,
    required String title,
  });

  Future<ApiResult<CreateGroupExtrasResponse>> createExtrasItem({
    required int groupId,
    required String title,
  });

  Future<ApiResult<SingleExtrasGroupResponse>> createExtrasGroup({
    required String title,
  });

  Future<ApiResult<CalculateResponse>> getProductsCalculation(
    List<Stock> stocks,
  );

  Future<ApiResult<GroupExtrasResponse>> getExtras({int? groupId});

  Future<ApiResult<SingleProductResponse>> updateStocks({
    required List<Stock> stocks,
    required List<int> deletedStocks,
    String? uuid,
    bool isAddon = false,
  });

  Future<ApiResult<SingleProductResponse>> updateProduct({
    required String title,
    required String description,
    required String tax,
    required String interval,
    required String minQty,
    required String maxQty,
    required bool active,
    String? qrcode,
    int? categoryId,
    int? kitchenId,
    int? unitId,
    List<String>? images,
    String? uuid,
    bool needAddons = false,
  });

  Future<ApiResult<SingleProductResponse>> updateExtras({
    required List<int> extrasIds,
    String? productUuid,
  });

  Future<ApiResult<ExtrasGroupsResponse>> getExtrasGroups({
    bool needOnlyValid = true,
  });

  Future<ApiResult<SingleProductResponse>> createProduct({
    required String title,
    required String description,
    required String tax,
    required String interval,
    required String minQty,
    required String maxQty,
    required String qrcode,
    required bool active,
    int? categoryId,
    int? kitchenId,
    int? unitId,
    List<String>? images,
    bool isAddon = false,
  });

  Future<ApiResult<SingleProductResponse>> getProductDetails(String uuid);

  Future<ApiResult<ProductsPaginateResponse>> getProducts({
    int? page,
    int? categoryId,
    String? query,
    ProductStatus? status,
    bool needAddons = false,
    bool active = false,
  });
}

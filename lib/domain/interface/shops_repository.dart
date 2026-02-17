import '../../domain/handlers/handlers.dart';
import '../../infrastructure/models/data/address_data.dart';

abstract class ShopsRepository {
  Future<ApiResult<void>> createShop({
    required double tax,
    required double deliveryTo,
    required double deliveryFrom,
    required String deliveryType,
    required String phone,
    required String name,
    required num category,
    required String description,
    required double startPrice,
    required double perKm,
    required AddressData address,
    String? logoImage,
    String? backgroundImage,
  });
}

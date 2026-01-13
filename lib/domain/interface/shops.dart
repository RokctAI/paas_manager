import 'package:venderfoodyman/domain/handlers/handlers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

abstract class ShopsInterface {
  Future<ApiResult<void>> createShop({
    required double tax,
    required List<String> documents,
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

import 'package:flutter/material.dart';
import '../../domain/di/injection.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/interface/interfaces.dart';
import '../models/data/address_data.dart';
import '../services/services.dart';

class ShopsRepositoryImpl implements ShopsRepository {


  @override
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
  }) async {
    final data = {
      "price_per_km": perKm,
      'tax': tax,
      //'categories[0]': category,
      'delivery_time_type': deliveryType,
      'location': address.location?.toJson(),
      'phone': phone.replaceAll('+',""),
      'delivery_time_from': deliveryFrom,
      'delivery_time_to': deliveryTo,
      'title': {LocalStorage.getLanguage()?.locale ?? "": name},
      'description': {LocalStorage.getLanguage()?.locale ?? "": description},
      'price': startPrice,
      'address': {
        LocalStorage.getLanguage()?.locale ?? "":
        "${address.title}, ${address.address}"
      },
      if (logoImage != null) 'images[0]': logoImage,
      if (backgroundImage != null) "images[1]": backgroundImage,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/shops',
        queryParameters: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> create shop failure: $e');
      return ApiResult.failure(  error: AppHelpers.errorHandler(e), statusCode: NetworkExceptions.getDioStatus(e));

    }
  }


}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:venderfoodyman/infrastructure/models/response/statistics_order_response.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../../domain/di/injection.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/interface/interfaces.dart';

class UsersRepositoryImpl implements UsersRepository {
  @override
  Future<ApiResult<ProfileResponse>> createUser({
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
  }) async {
    final data = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone.replaceAll("+", ""),
      'role': 'user',
    };
    debugPrint('===> create user ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response =
          await client.post('/api/v1/dashboard/seller/users', data: data);
      return ApiResult.success(data: ProfileResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('===> create user fail $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<StatisticsResponse>> getStatistics(
      {required DateTime startTime, required DateTime endTime}) async {
    try {
      final data = {
        "date_from":
            endTime.toString().substring(0, endTime.toString().indexOf(" ")),
        "date_to": startTime
            .toString()
            .substring(0, startTime.toString().indexOf(" ")),
        "type": "day"
      };
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('/api/v1/dashboard/seller/order/report',
          queryParameters: data);
      return ApiResult.success(
        data: StatisticsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('===> get statistics error $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<StatisticsOrderResponse>> getStatisticsOrder(
      {DateTime? startTime, DateTime? endTime, int? page, int? perPage}) async {
    try {
      final data = {
        if (endTime != null)
          "date_from":
              endTime.toString().substring(0, endTime.toString().indexOf(" ")),
        if (startTime != null)
          "date_to": startTime
              .toString()
              .substring(0, startTime.toString().indexOf(" ")),
        "page": page,
        "perPage": perPage ?? 10
      };
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
          '/api/v1/dashboard/seller/orders/report/paginate',
          queryParameters: data);
      return ApiResult.success(
        data: StatisticsOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('===> get statistics order error $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> updateDeliveryZones({
    required List<LatLng> points,
  }) async {
    List<Map<String, dynamic>> tapped = [];
    for (final point in points) {
      final location = {'0': point.latitude, '1': point.longitude};
      tapped.add(location);
    }
    final data = {
      'shop_id': LocalStorage.getShop()?.id,
      'address': tapped,
    };
    debugPrint('====> update delivery zone ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/delivery-zones',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update delivery zones failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone() async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'perPage': 1,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/delivery-zones',
        queryParameters: data,
      );
      return ApiResult.success(
        data: DeliveryZonePaginate.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('===> error get delivery zone $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> updateShopWorkingDays({
    required List<ShopWorkingDays> workingDays,
    String? uuid,
  }) async {
    List<Map<String, dynamic>> days = [];
    for (final workingDay in workingDays) {
      final data = {
        'day': workingDay.day,
        'from': workingDay.from,
        'to': workingDay.to,
        'disabled': workingDay.disabled
      };
      days.add(data);
    }
    final data = {'dates': days};
    debugPrint('====> update working days ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.put(
        '/api/v1/dashboard/seller/shop-working-days/${uuid ?? LocalStorage.getShop()?.uuid}',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update shop working days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> updateShop({
    String? tax,
    num? percentage,
    String? phone,
    String? type,
    num? pricePerKm,
    String? minAmount,
    num? price,
    String? backImg,
    String? orderPayment,
    String? logoImg,
    List<CategoryData>? categories,
    DeliveryTime? deliveryTime,
    Translation? translation,
    List<ShopTag>? tags,
  }) async {
    List<int> categoryIds = [];
    List<int> tagIds = [];
    if (categories != null && categories.isNotEmpty) {
      for (int i = 0; i < categories.length; i++) {
        categoryIds.add(categories[i].id ?? 0);
      }
    }
    if (tags != null && tags.isNotEmpty) {
      for (int i = 0; i < tags.length; i++) {
        tagIds.add(tags[i].id ?? 0);
      }
    }
    categoryIds = categoryIds.toSet().toList();
    tagIds = tagIds.toSet().toList();
    final data = {
      'tax': tax,
      if (percentage != null) 'percentage': percentage,
      'phone': phone?.replaceAll("+", ""),
      'type': type,
      if (pricePerKm != null) 'price_per_km': pricePerKm,
      if (orderPayment != null) 'order_payment': orderPayment,
      'min_amount': minAmount,
      if (price != null) 'price': price,
      'title': {
        LocalStorage.getSystemLanguage()?.locale ?? 'en': translation?.title
      },
      'description': {
        LocalStorage.getSystemLanguage()?.locale ?? 'en':
            translation?.description
      },
      'address': {
        LocalStorage.getSystemLanguage()?.locale ?? 'en': translation?.address
      },
      'images': [logoImg, backImg],
      // 'categories': categoryIds,
      //   'tags': tagIds,
      'delivery_time_type': deliveryTime?.type,
      'delivery_time_from': deliveryTime?.from,
      'delivery_time_to': deliveryTime?.to,
    };
    debugPrint('====> update shop ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/shops',
        data: data,
      );
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update shop failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<UsersPaginateResponse>> searchUsers({
    String? query,
    int? page,
  }) async {
    final data = {
      if (query != null) 'search': query,
      'perPage': 14,
      if (page != null) 'page': page,
      'sort': 'desc',
      'column': 'created_at',
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/users/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search users failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> getMyShop() async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shops',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('===> error fetching my shop $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> setOnlineOffline() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/shops/working/status',
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      debugPrint('===> error switch shop online $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> getProfileDetails() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/profile/show',
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> editProfile({
    required EditProfile? user,
  }) async {
    final data = user?.toJson();
    debugPrint('===> update general info data ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/user/profile/update',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update profile details failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> updateProfileImage({
    required String firstName,
    required String imageUrl,
  }) async {
    final data = {
      'firstname': firstName,
      'images': [imageUrl],
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/user/profile/update',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update profile image failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> updatePassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    final data = {
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/profile/password/update',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update password failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> updateFirebaseToken(String? token) async {
    final data = {if (token != null) 'firebase_token': token};
    debugPrint('===> update firebase token ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/profile/firebase/token/update',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update firebase token failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> deleteAccount() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/user/profile/delete',
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}

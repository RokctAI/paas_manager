// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:manager/infrastructure/models/response/statistics_order_response.dart';

import '../handlers/handlers.dart';
import '../../infrastructure/models/models.dart';

abstract class UsersRepository {
  Future<ApiResult<ProfileResponse>> createUser({
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
  });

  Future<ApiResult<StatisticsResponse>> getStatistics(
      {required DateTime startTime, required DateTime endTime});

  Future<ApiResult<StatisticsOrderResponse>> getStatisticsOrder(
      {DateTime? startTime, DateTime? endTime, int? page, int? perPage});

  Future<ApiResult<void>> updateDeliveryZones({
    required List<LatLng> points,
  });

  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone();

  Future<ApiResult<void>> updateShopWorkingDays({
    required List<ShopWorkingDays> workingDays,
    String? uuid,
  });

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
    List<ShopTag>? tags,
    DeliveryTime? deliveryTime,
    Translation? translation,
  });

  Future<ApiResult<UsersPaginateResponse>> searchUsers({
    String? query,
    int? page,
  });

  Future<ApiResult<SingleShopResponse>> getMyShop();

  Future<ApiResult<dynamic>> setOnlineOffline();

  Future<ApiResult<ProfileResponse>> getProfileDetails();

  Future<ApiResult<ProfileResponse>> editProfile({required EditProfile? user});

  Future<ApiResult<ProfileResponse>> updateProfileImage({
    required String firstName,
    required String imageUrl,
  });

  Future<ApiResult<ProfileResponse>> updatePassword({
    required String password,
    required String passwordConfirmation,
  });

  Future<ApiResult<void>> updateFirebaseToken(String? token);

  Future<ApiResult<dynamic>> deleteAccount();
}

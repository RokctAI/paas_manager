import 'package:flutter/material.dart';
import 'package:base_sdk/src/di/injection.dart';
import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_order_response.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_response.dart';

/// Straight port of `paas_manager`'s statistics calls, repointed from the
/// legacy `/api/v1/dashboard/seller/...` paths to their Frappe counterparts in
/// the merchants app. Query parameters follow Frappe's `from_date`/`to_date`
/// naming rather than the old `date_from`/`date_to`.
///
/// `get_order_report` currently returns a flat order list rather than the
/// statistics shape this client expects; that gap is recorded in
/// `docs/frappe-endpoint-contract.md` for the backend workstream, not worked
/// around here.
class SellerStatisticsRepository implements SellerStatisticsRepositoryFacade {
  @override
  Future<ApiResult<StatisticsResponse>> getStatistics({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/method/paas.api.seller_report.seller_report.get_order_report',
        queryParameters: {
          'from_date': _date(endTime),
          'to_date': _date(startTime),
          'type': 'day',
        },
      );
      return ApiResult.success(
        data: StatisticsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('===> get statistics error $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<StatisticsOrderResponse>> getStatisticsOrder({
    DateTime? startTime,
    DateTime? endTime,
    int? page,
    int? perPage,
  }) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/method/paas.api.seller_report.seller_report.get_order_report_paginate',
        queryParameters: {
          if (endTime != null) 'from_date': _date(endTime),
          if (startTime != null) 'to_date': _date(startTime),
          'page': page,
          'per_page': perPage ?? 10,
        },
      );
      return ApiResult.success(
        data: StatisticsOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('===> get statistics order error $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  /// The legacy client sliced `DateTime.toString()` at the first space; this is
  /// the same `yyyy-MM-dd` result without the string surgery.
  String _date(DateTime value) => value.toIso8601String().substring(0, 10);
}

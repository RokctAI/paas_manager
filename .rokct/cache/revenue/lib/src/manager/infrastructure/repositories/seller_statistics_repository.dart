// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:base_sdk/src/handlers/platform_gateway.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';
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
  /// Prefix-free cmd base for the universal platform gateway: the merchants
  /// module's `manifest.json` whitelisted-method keys
  /// (`{app_name}.api.seller_report.*`) with the app segment dropped.
  static const _cmd = 'api.seller_report';

  static const _gateway = PlatformGateway();

  @override
  Future<ApiResult<StatisticsResponse>> getStatistics({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      // Routed through the universal platform gateway; the prefix-free cmd
      // mirrors the merchants manifest whitelisted-method key
      // `api.seller_report.get_order_report`.
      final response = await _gateway.tenant(
        '$_cmd.get_order_report',
        {
          'from_date': _date(endTime),
          'to_date': _date(startTime),
          'type': 'day',
        },
      );
      return ApiResult.success(
        data: StatisticsResponse.fromJson(response),
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
      // Routed through the universal platform gateway; the prefix-free cmd
      // mirrors the merchants manifest whitelisted-method key
      // `api.seller_report.get_order_report_paginate`.
      final response = await _gateway.tenant(
        '$_cmd.get_order_report_paginate',
        {
          if (endTime != null) 'from_date': _date(endTime),
          if (startTime != null) 'to_date': _date(startTime),
          'page': page,
          'per_page': perPage ?? 10,
        },
      );
      return ApiResult.success(
        data: StatisticsOrderResponse.fromJson(response),
      );
    } catch (e) {
      debugPrint('===> get statistics order error $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfitReportResponse>> getProfitReport({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      // Routed through the universal platform gateway; the prefix-free cmd
      // mirrors the merchants manifest whitelisted-method key
      // `api.seller_report.get_seller_profit_report`. Until a backend
      // carrying merchants >= 1.15.0 is deployed the gateway answers with
      // an unknown-cmd error — surfaced as the failure branch, which the
      // dashboard renders as its honest error state (never fake zeros).
      final response = await _gateway.tenant(
        '$_cmd.get_seller_profit_report',
        {
          'from_date': _date(from),
          'to_date': _date(to),
        },
      );
      return ApiResult.success(
        data: ProfitReportResponse.fromJson(response),
      );
    } catch (e) {
      debugPrint('===> get profit report error $e');
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

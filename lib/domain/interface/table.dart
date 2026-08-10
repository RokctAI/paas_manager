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

import 'package:venderfoodyman/domain/handlers/api_result.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

abstract class TableInterface {

  Future<ApiResult<ShopSection>> createNewSection(
      {required String name, required num area});

  Future<ApiResult<ShopSectionResponse>> getSection({
    int? page,
    String? query,
  });

  Future<ApiResult<dynamic>> createNewTable({required TableModel tableModel});

  Future<ApiResult<TableResponse>> getTables({
    int? page,
    String? query,
    int? shopSectionId,
    String? type,
    DateTime? from,
    DateTime? to,
  });

  Future<ApiResult<TableBookingResponse>> getTableOrders({
    int? page,
    int? id,
    String? type,
    DateTime? from,
    DateTime? to,
  });

  Future<ApiResult<TableInfoResponse>> getTableInfo(int id);

  Future<ApiResult<TableResponse>> deleteSection(int id);

  Future<ApiResult<TableResponse>> deleteTable(int id);

  Future<ApiResult<List<DisableDates>>> disableDates({
    required DateTime dateTime,
    required int? id,
  });

  Future<ApiResult<BookingsResponse>> getBookings({int? page});

  Future<ApiResult<dynamic>> setBookings({
    int? bookingId,
    int? tableId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<ApiResult<WorkingDayResponse>> getWorkingDay();

  Future<ApiResult<CloseDayResponse>> getCloseDay();

  Future<ApiResult<dynamic>> changeOrderStatus(
      {required String status, required int id});

  Future<ApiResult<TableStatisticResponse>> getStatistic({
    DateTime? from,
    DateTime? to,
  });
}

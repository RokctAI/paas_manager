import 'package:venderfoodyman/domain/handlers/api_result.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

abstract class TableInterface {
  Future<ApiResult<ShopSection>> createNewSection({
    required String name,
    required num area,
  });

  Future<ApiResult<ShopSectionResponse>> getSection({int? page, String? query});

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

  Future<ApiResult<dynamic>> changeOrderStatus({
    required String status,
    required int id,
  });

  Future<ApiResult<TableStatisticResponse>> getStatistic({
    DateTime? from,
    DateTime? to,
  });
}

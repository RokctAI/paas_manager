import 'package:venderfoodyman/domain/handlers/api_result.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

abstract class NotificationInterface {
  Future<ApiResult<NotificationResponse>> getNotifications({int? page});

  Future<ApiResult<NotificationResponse>> getAllNotifications();

  Future<ApiResult<dynamic>> readOne({int? id});

  Future<ApiResult<NotificationResponse>> readAll();

  Future<ApiResult<CountNotificationModel>> getCount();
}

import '../handlers/handlers.dart';
import '../../infrastructure/models/models.dart';
import '../../infrastructure/services/services.dart';

abstract class OrdersRepository {
  Future<ApiResult<OrderCalculate>> getCalculate({
    required List<Stock> stocks,
    required LocationData? location,
    required String type,
  });

  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int orderId,
    required int paymentId,
  });

  Future<ApiResult<PaymentsResponse>> getPayments();

  Future<ApiResult<CreateOrderResponse>> createOrder({
    required DeliveryType deliveryType,
    UserData? user,
    required List<Stock> stocks,
    required String deliveryTime,
    required String address,
    String? entrance,
    String? floor,
    String? house,
    LocationData? location,
  });

  Future<ApiResult<OrderStatusResponse>> updateOrderStatus({
    required OrderStatus status,
    int? orderId,
  });

  Future<ApiResult<SingleOrderResponse>> getOrderDetails({int? orderId});

  Future<ApiResult<OrdersPaginateResponse>> getOrders({
    OrderStatus? status,
    int? page,
    String? from,
    String? to,
  });

  Future<ApiResult<OrdersPaginateResponse>> getHistoryOrders({
    int? page,
    String? from,
    String? to,
  });
}

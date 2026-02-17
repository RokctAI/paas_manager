import 'package:venderfoodyman/infrastructure/models/models.dart';
import '../handlers/handlers.dart';

abstract class PaymentsFacade {
  Future<ApiResult<PaymentsResponse>> getPayments();

  Future<ApiResult<NonExistPaymentResponse>> getNonExistPayments();

  Future<ApiResult<String>> paymentWalletWebView({
    required String name,
    required num price,
  });

  Future<ApiResult<MaksekeskusResponse>> paymentMaksekeskusView({num? price});

  Future<ApiResult<String>> paymentSubscriptionWebView({
    required String name,
    required int subscriptionId,
  });

  Future<ApiResult<bool>> sendWallet({
    required String uuid,
    required num price,
  });
}

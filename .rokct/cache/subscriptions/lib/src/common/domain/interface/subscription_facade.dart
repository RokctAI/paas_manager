import 'package:base_sdk/base_sdk.dart';
import '../../infrastructure/models/response/subscriptions_response.dart';
import '../../infrastructure/models/response/transactions_response.dart';

abstract class SubscriptionsFacade {
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({
    required int page,
    String? locale,
  });

  /// [beneficiaryUserId] enables delegated billing: purchase this
  /// subscription FOR another account (e.g. an accountability partner
  /// paying for a linked student — the subscription stays the student's,
  /// only who gets charged changes). Null (the default, and every
  /// pre-existing call) means the caller purchases for themselves. The
  /// backend authorizes the delegation — the client only carries the fact.
  Future<ApiResult> purchaseSubscription({
    required int id,
    required int paymentId,
    String? beneficiaryUserId,
  });

  Future<ApiResult<SubscriptionTransactionsResponse>> createTransaction({
    required int id,
    required int paymentId,
    String? beneficiaryUserId,
  });
}

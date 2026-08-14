import 'package:base_sdk/base_sdk.dart';
import '../../infrastructure/models/response/subscriptions_response.dart';
import '../../infrastructure/models/response/transactions_response.dart';

abstract class SubscriptionsFacade {
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({
    required int page,
    String? locale,
  });

  /// [ref] is the plan's Frappe document name on the composed backend
  /// (plan rows are hash-named, so the legacy numeric [id] is null for
  /// them); when present it identifies the plan on the wire, with [id] as
  /// the fallback for stored rows that still carry one.
  ///
  /// [beneficiaryUserId] enables delegated billing: purchase this
  /// subscription FOR another account (e.g. an accountability partner
  /// paying for a linked student — the subscription stays the student's,
  /// only who gets charged changes). Null (the default, and every
  /// pre-existing call) means the caller purchases for themselves. The
  /// backend authorizes the delegation — the client only carries the fact.
  Future<ApiResult> purchaseSubscription({
    required int id,
    required int paymentId,
    String? ref,
    String? beneficiaryUserId,
  });

  /// [id] is whatever identifier [purchaseSubscription] returned — the
  /// legacy backend used an int, the composed backend a Frappe document
  /// name (String) — so it is deliberately untyped.
  Future<ApiResult<SubscriptionTransactionsResponse>> createTransaction({
    required Object id,
    required int paymentId,
    String? beneficiaryUserId,
  });
}

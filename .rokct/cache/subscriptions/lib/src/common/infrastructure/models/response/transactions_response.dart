/// Response of the subscription transaction-creation endpoint.
///
/// Owned by subscriptions_sdk so the facade carries no compile dependency on
/// wallet_sdk. The purchase flow currently only branches on the request's
/// success/failure; the raw `data` payload is kept available for callers
/// that need transaction details.
class SubscriptionTransactionsResponse {
  final Map<String, dynamic>? data;

  SubscriptionTransactionsResponse({this.data});

  factory SubscriptionTransactionsResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return SubscriptionTransactionsResponse();
    }
    final data = json['data'];
    return SubscriptionTransactionsResponse(
      data: data is Map<String, dynamic> ? data : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data};
}

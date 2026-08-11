import 'package:base_sdk/base_sdk.dart';

import 'package:subscriptions_sdk/src/common/infrastructure/models/data/subscriptions_data.dart';

/// Typed view over the merchant shop's active subscription, read from the
/// kernel's untyped shop JSON ([LocalStorage.getShopJson]).
///
/// Replaces the retired core_sdk manager `LocalStorage.getShop()` surface
/// that the subscriptions template pages used to consume.
class ShopSubscriptionStore {
  ShopSubscriptionStore._();

  /// The shop's subscription wrapper (`shop.subscription`), or null when no
  /// shop is stored or it has no subscription.
  static SubscriptionData? shopSubscription() {
    final sub = LocalStorage.getShopJson()?['subscription'];
    if (sub is! Map<String, dynamic>) return null;
    return SubscriptionData.fromJson(sub);
  }
}

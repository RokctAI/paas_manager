import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../pages/pages.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    CupertinoRoute(path: '/', page: SplashRoute.page),
    CupertinoRoute(path: '/main', page: MainRoute.page),
    CupertinoRoute(path: '/auth', page: AuthRoute.page),
    CupertinoRoute(path: '/order', page: OrderRoute.page),
    CupertinoRoute(path: '/income', page: IncomeRoute.page),
    CupertinoRoute(path: '/select-user', page: SelectUserRoute.page),
    CupertinoRoute(path: '/delivery-time', page: DeliveryTimeRoute.page),
    CupertinoRoute(path: '/order-history', page: OrderHistoryRoute.page),
    CupertinoRoute(path: '/delivery-zone', page: DeliveryZoneRoute.page),
    CupertinoRoute(path: '/no-connection', page: NoConnectionRoute.page),
    CupertinoRoute(path: '/select-address', page: SelectAddressRoute.page),
    CupertinoRoute(path: '/order-products', page: CreateOrderRoute.page),
    CupertinoRoute(path: '/shipping-address', page: ShippingAddressRoute.page),
    CupertinoRoute(
      path: '/list-notification',
      page: NotificationListRoute.page,
    ),
    CupertinoRoute(path: '/view_map', page: ViewMapRoute.page),
    CupertinoRoute(path: '/become_seller', page: CreateShopRoute.page),
    CupertinoRoute(path: '/search_map', page: MapSearchRoute.page),
    MaterialRoute(path: '/select-section', page: SelectSectionRoute.page),
    MaterialRoute(path: '/select-table', page: SelectTableRoute.page),
    MaterialRoute(path: '/webview', page: WebViewRoute.page),
    MaterialRoute(path: '/subscription', page: SubscriptionsRoute.page),
  ];
}

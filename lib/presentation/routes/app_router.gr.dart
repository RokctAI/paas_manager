// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthPage();
    },
  );
}

/// generated route for
/// [CreateOrderPage]
class CreateOrderRoute extends PageRouteInfo<void> {
  const CreateOrderRoute({List<PageRouteInfo>? children})
    : super(CreateOrderRoute.name, initialChildren: children);

  static const String name = 'CreateOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateOrderPage();
    },
  );
}

/// generated route for
/// [CreateShopPage]
class CreateShopRoute extends PageRouteInfo<void> {
  const CreateShopRoute({List<PageRouteInfo>? children})
    : super(CreateShopRoute.name, initialChildren: children);

  static const String name = 'CreateShopRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateShopPage();
    },
  );
}

/// generated route for
/// [DeliveryTimePage]
class DeliveryTimeRoute extends PageRouteInfo<void> {
  const DeliveryTimeRoute({List<PageRouteInfo>? children})
    : super(DeliveryTimeRoute.name, initialChildren: children);

  static const String name = 'DeliveryTimeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DeliveryTimePage();
    },
  );
}

/// generated route for
/// [DeliveryZonePage]
class DeliveryZoneRoute extends PageRouteInfo<void> {
  const DeliveryZoneRoute({List<PageRouteInfo>? children})
    : super(DeliveryZoneRoute.name, initialChildren: children);

  static const String name = 'DeliveryZoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DeliveryZonePage();
    },
  );
}

/// generated route for
/// [IncomePage]
class IncomeRoute extends PageRouteInfo<void> {
  const IncomeRoute({List<PageRouteInfo>? children})
    : super(IncomeRoute.name, initialChildren: children);

  static const String name = 'IncomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IncomePage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [MapSearchPage]
class MapSearchRoute extends PageRouteInfo<void> {
  const MapSearchRoute({List<PageRouteInfo>? children})
    : super(MapSearchRoute.name, initialChildren: children);

  static const String name = 'MapSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MapSearchPage();
    },
  );
}

/// generated route for
/// [NoConnectionPage]
class NoConnectionRoute extends PageRouteInfo<void> {
  const NoConnectionRoute({List<PageRouteInfo>? children})
    : super(NoConnectionRoute.name, initialChildren: children);

  static const String name = 'NoConnectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NoConnectionPage();
    },
  );
}

/// generated route for
/// [NotificationListPage]
class NotificationListRoute extends PageRouteInfo<void> {
  const NotificationListRoute({List<PageRouteInfo>? children})
    : super(NotificationListRoute.name, initialChildren: children);

  static const String name = 'NotificationListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationListPage();
    },
  );
}

/// generated route for
/// [OrderHistoryPage]
class OrderHistoryRoute extends PageRouteInfo<void> {
  const OrderHistoryRoute({List<PageRouteInfo>? children})
    : super(OrderHistoryRoute.name, initialChildren: children);

  static const String name = 'OrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderHistoryPage();
    },
  );
}

/// generated route for
/// [OrderPage]
class OrderRoute extends PageRouteInfo<void> {
  const OrderRoute({List<PageRouteInfo>? children})
    : super(OrderRoute.name, initialChildren: children);

  static const String name = 'OrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderPage();
    },
  );
}

/// generated route for
/// [SelectAddressPage]
class SelectAddressRoute extends PageRouteInfo<void> {
  const SelectAddressRoute({List<PageRouteInfo>? children})
    : super(SelectAddressRoute.name, initialChildren: children);

  static const String name = 'SelectAddressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectAddressPage();
    },
  );
}

/// generated route for
/// [SelectSectionPage]
class SelectSectionRoute extends PageRouteInfo<void> {
  const SelectSectionRoute({List<PageRouteInfo>? children})
    : super(SelectSectionRoute.name, initialChildren: children);

  static const String name = 'SelectSectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectSectionPage();
    },
  );
}

/// generated route for
/// [SelectTablePage]
class SelectTableRoute extends PageRouteInfo<SelectTableRouteArgs> {
  SelectTableRoute({
    Key? key,
    required int? sectionId,
    List<PageRouteInfo>? children,
  }) : super(
         SelectTableRoute.name,
         args: SelectTableRouteArgs(key: key, sectionId: sectionId),
         initialChildren: children,
       );

  static const String name = 'SelectTableRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectTableRouteArgs>();
      return SelectTablePage(key: args.key, sectionId: args.sectionId);
    },
  );
}

class SelectTableRouteArgs {
  const SelectTableRouteArgs({this.key, required this.sectionId});

  final Key? key;

  final int? sectionId;

  @override
  String toString() {
    return 'SelectTableRouteArgs{key: $key, sectionId: $sectionId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SelectTableRouteArgs) return false;
    return key == other.key && sectionId == other.sectionId;
  }

  @override
  int get hashCode => key.hashCode ^ sectionId.hashCode;
}

/// generated route for
/// [SelectUserPage]
class SelectUserRoute extends PageRouteInfo<void> {
  const SelectUserRoute({List<PageRouteInfo>? children})
    : super(SelectUserRoute.name, initialChildren: children);

  static const String name = 'SelectUserRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectUserPage();
    },
  );
}

/// generated route for
/// [ShippingAddressPage]
class ShippingAddressRoute extends PageRouteInfo<void> {
  const ShippingAddressRoute({List<PageRouteInfo>? children})
    : super(ShippingAddressRoute.name, initialChildren: children);

  static const String name = 'ShippingAddressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShippingAddressPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [SubscriptionsPage]
class SubscriptionsRoute extends PageRouteInfo<void> {
  const SubscriptionsRoute({List<PageRouteInfo>? children})
    : super(SubscriptionsRoute.name, initialChildren: children);

  static const String name = 'SubscriptionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SubscriptionsPage();
    },
  );
}

/// generated route for
/// [ViewMapPage]
class ViewMapRoute extends PageRouteInfo<ViewMapRouteArgs> {
  ViewMapRoute({
    required VoidCallback onChanged,
    Key? key,
    bool isShopLocation = false,
    int? shopId,
    List<PageRouteInfo>? children,
  }) : super(
         ViewMapRoute.name,
         args: ViewMapRouteArgs(
           onChanged: onChanged,
           key: key,
           isShopLocation: isShopLocation,
           shopId: shopId,
         ),
         initialChildren: children,
       );

  static const String name = 'ViewMapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewMapRouteArgs>();
      return ViewMapPage(
        args.onChanged,
        key: args.key,
        isShopLocation: args.isShopLocation,
        shopId: args.shopId,
      );
    },
  );
}

class ViewMapRouteArgs {
  const ViewMapRouteArgs({
    required this.onChanged,
    this.key,
    this.isShopLocation = false,
    this.shopId,
  });

  final VoidCallback onChanged;

  final Key? key;

  final bool isShopLocation;

  final int? shopId;

  @override
  String toString() {
    return 'ViewMapRouteArgs{onChanged: $onChanged, key: $key, isShopLocation: $isShopLocation, shopId: $shopId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ViewMapRouteArgs) return false;
    return onChanged == other.onChanged &&
        key == other.key &&
        isShopLocation == other.isShopLocation &&
        shopId == other.shopId;
  }

  @override
  int get hashCode =>
      onChanged.hashCode ^
      key.hashCode ^
      isShopLocation.hashCode ^
      shopId.hashCode;
}

/// generated route for
/// [WebViewPage]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({Key? key, required String url, List<PageRouteInfo>? children})
    : super(
        WebViewRoute.name,
        args: WebViewRouteArgs(key: key, url: url),
        initialChildren: children,
      );

  static const String name = 'WebViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return WebViewPage(key: args.key, url: args.url);
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({this.key, required this.url});

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WebViewRouteArgs) return false;
    return key == other.key && url == other.url;
  }

  @override
  int get hashCode => key.hashCode ^ url.hashCode;
}

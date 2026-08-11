// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CalculatorPage]
class CalculatorRoute extends PageRouteInfo<void> {
  const CalculatorRoute({List<PageRouteInfo>? children})
    : super(CalculatorRoute.name, initialChildren: children);

  static const String name = 'CalculatorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CalculatorPage();
    },
  );
}

/// generated route for
/// [ClosedRouteView]
class ClosedRoute extends PageRouteInfo<void> {
  const ClosedRoute({List<PageRouteInfo>? children})
    : super(ClosedRoute.name, initialChildren: children);

  static const String name = 'ClosedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ClosedRouteView();
    },
  );
}

/// generated route for
/// [CreateOrderPage]
class ManagerCreateOrderRoute extends PageRouteInfo<void> {
  const ManagerCreateOrderRoute({List<PageRouteInfo>? children})
    : super(ManagerCreateOrderRoute.name, initialChildren: children);

  static const String name = 'ManagerCreateOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateOrderPage();
    },
  );
}

/// generated route for
/// [DeliveryTimePage]
class ManagerDeliveryTimeRoute extends PageRouteInfo<void> {
  const ManagerDeliveryTimeRoute({List<PageRouteInfo>? children})
    : super(ManagerDeliveryTimeRoute.name, initialChildren: children);

  static const String name = 'ManagerDeliveryTimeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DeliveryTimePage();
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
/// [ManagerDeliveryZonePage]
class ManagerDeliveryZoneRoute extends PageRouteInfo<void> {
  const ManagerDeliveryZoneRoute({List<PageRouteInfo>? children})
    : super(ManagerDeliveryZoneRoute.name, initialChildren: children);

  static const String name = 'ManagerDeliveryZoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManagerDeliveryZonePage();
    },
  );
}

/// generated route for
/// [ManagerIncomePage]
class ManagerIncomeRoute extends PageRouteInfo<void> {
  const ManagerIncomeRoute({List<PageRouteInfo>? children})
    : super(ManagerIncomeRoute.name, initialChildren: children);

  static const String name = 'ManagerIncomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManagerIncomePage();
    },
  );
}

/// generated route for
/// [ManagerSubscriptionsPage]
class ManagerSubscriptionsRoute extends PageRouteInfo<void> {
  const ManagerSubscriptionsRoute({List<PageRouteInfo>? children})
    : super(ManagerSubscriptionsRoute.name, initialChildren: children);

  static const String name = 'ManagerSubscriptionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManagerSubscriptionsPage();
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
class ManagerOrderHistoryRoute extends PageRouteInfo<void> {
  const ManagerOrderHistoryRoute({List<PageRouteInfo>? children})
    : super(ManagerOrderHistoryRoute.name, initialChildren: children);

  static const String name = 'ManagerOrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderHistoryPage();
    },
  );
}

/// generated route for
/// [OrderPage]
class ManagerOrderRoute extends PageRouteInfo<void> {
  const ManagerOrderRoute({List<PageRouteInfo>? children})
    : super(ManagerOrderRoute.name, initialChildren: children);

  static const String name = 'ManagerOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderPage();
    },
  );
}

/// generated route for
/// [SelectAddressPage]
class ManagerSelectAddressRoute extends PageRouteInfo<void> {
  const ManagerSelectAddressRoute({List<PageRouteInfo>? children})
    : super(ManagerSelectAddressRoute.name, initialChildren: children);

  static const String name = 'ManagerSelectAddressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectAddressPage();
    },
  );
}

/// generated route for
/// [SelectSectionPage]
class ManagerSelectSectionRoute extends PageRouteInfo<void> {
  const ManagerSelectSectionRoute({List<PageRouteInfo>? children})
    : super(ManagerSelectSectionRoute.name, initialChildren: children);

  static const String name = 'ManagerSelectSectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectSectionPage();
    },
  );
}

/// generated route for
/// [SelectTablePage]
class ManagerSelectTableRoute
    extends PageRouteInfo<ManagerSelectTableRouteArgs> {
  ManagerSelectTableRoute({
    Key? key,
    required int? sectionId,
    List<PageRouteInfo>? children,
  }) : super(
         ManagerSelectTableRoute.name,
         args: ManagerSelectTableRouteArgs(key: key, sectionId: sectionId),
         initialChildren: children,
       );

  static const String name = 'ManagerSelectTableRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ManagerSelectTableRouteArgs>();
      return SelectTablePage(key: args.key, sectionId: args.sectionId);
    },
  );
}

class ManagerSelectTableRouteArgs {
  const ManagerSelectTableRouteArgs({this.key, required this.sectionId});

  final Key? key;

  final int? sectionId;

  @override
  String toString() {
    return 'ManagerSelectTableRouteArgs{key: $key, sectionId: $sectionId}';
  }
}

/// generated route for
/// [SelectUserPage]
class ManagerSelectUserRoute extends PageRouteInfo<void> {
  const ManagerSelectUserRoute({List<PageRouteInfo>? children})
    : super(ManagerSelectUserRoute.name, initialChildren: children);

  static const String name = 'ManagerSelectUserRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectUserPage();
    },
  );
}

/// generated route for
/// [ShippingAddressPage]
class ManagerShippingAddressRoute extends PageRouteInfo<void> {
  const ManagerShippingAddressRoute({List<PageRouteInfo>? children})
    : super(ManagerShippingAddressRoute.name, initialChildren: children);

  static const String name = 'ManagerShippingAddressRoute';

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
/// [TasksPage]
class TasksRoute extends PageRouteInfo<void> {
  const TasksRoute({List<PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TasksPage();
    },
  );
}

/// generated route for
/// [UiTypeRouteView]
class UiTypeRoute extends PageRouteInfo<UiTypeRouteArgs> {
  UiTypeRoute({Key? key, bool isBack = false, List<PageRouteInfo>? children})
    : super(
        UiTypeRoute.name,
        args: UiTypeRouteArgs(key: key, isBack: isBack),
        initialChildren: children,
      );

  static const String name = 'UiTypeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UiTypeRouteArgs>(
        orElse: () => const UiTypeRouteArgs(),
      );
      return UiTypeRouteView(key: args.key, isBack: args.isBack);
    },
  );
}

class UiTypeRouteArgs {
  const UiTypeRouteArgs({this.key, this.isBack = false});

  final Key? key;

  final bool isBack;

  @override
  String toString() {
    return 'UiTypeRouteArgs{key: $key, isBack: $isBack}';
  }
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
}

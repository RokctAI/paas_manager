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
/// [LoginRouteView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginRouteView();
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
/// [NoConnectionRouteView]
class NoConnectionRoute extends PageRouteInfo<void> {
  const NoConnectionRoute({List<PageRouteInfo>? children})
      : super(NoConnectionRoute.name, initialChildren: children);

  static const String name = 'NoConnectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NoConnectionRouteView();
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
/// [RegisterConfirmationRouteView]
class RegisterConfirmationRoute
    extends PageRouteInfo<RegisterConfirmationRouteArgs> {
  RegisterConfirmationRoute({
    Key? key,
    required UserModel userModel,
    required String verificationId,
    bool isResetPassword = false,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterConfirmationRoute.name,
          args: RegisterConfirmationRouteArgs(
            key: key,
            userModel: userModel,
            verificationId: verificationId,
            isResetPassword: isResetPassword,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterConfirmationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterConfirmationRouteArgs>();
      return RegisterConfirmationRouteView(
        key: args.key,
        userModel: args.userModel,
        verificationId: args.verificationId,
        isResetPassword: args.isResetPassword,
      );
    },
  );
}

class RegisterConfirmationRouteArgs {
  const RegisterConfirmationRouteArgs({
    this.key,
    required this.userModel,
    required this.verificationId,
    this.isResetPassword = false,
  });

  final Key? key;

  final UserModel userModel;

  final String verificationId;

  final bool isResetPassword;

  @override
  String toString() {
    return 'RegisterConfirmationRouteArgs{key: $key, userModel: $userModel, verificationId: $verificationId, isResetPassword: $isResetPassword}';
  }
}

/// generated route for
/// [RegisterRouteView]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    bool isOnlyEmail = false,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key, isOnlyEmail: isOnlyEmail),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return RegisterRouteView(key: args.key, isOnlyEmail: args.isOnlyEmail);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key, this.isOnlyEmail = false});

  final Key? key;

  final bool isOnlyEmail;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, isOnlyEmail: $isOnlyEmail}';
  }
}

/// generated route for
/// [RegistrationStepsRouteView]
class RegistrationStepsRoute extends PageRouteInfo<void> {
  const RegistrationStepsRoute({List<PageRouteInfo>? children})
      : super(RegistrationStepsRoute.name, initialChildren: children);

  static const String name = 'RegistrationStepsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegistrationStepsRouteView();
    },
  );
}

/// generated route for
/// [ResetPasswordRouteView]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
      : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordRouteView();
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
/// [SplashRouteView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashRouteView();
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

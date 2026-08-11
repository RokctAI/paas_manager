// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// Host pages referenced by the routes below. The .gr.dart part shares this
// library's imports, so every @RoutePage class routed here must be visible.
import 'package:manager/presentation/pages/pages.dart';
// The blocks between the @generated markers are owned by the composer's
// update_router_table(): they are regenerated on every compose from the
// installed SDK manifests' "routes" declarations (base_sdk's initial routes,
// merchants' /main shell, orders' POS flow, zones' /delivery-zone, revenue's
// /income, subscriptions' page). Hand edits inside the markers are lost on
// recompose; host-owned routes live below, outside them.
// @generated-imports-start
import 'package:manager/presentation/pages/calc/calculator_page.dart';
import 'package:manager/presentation/pages/create_order/create_order_page.dart';
import 'package:manager/presentation/pages/create_order/order/order_page.dart';
import 'package:manager/presentation/pages/create_order/shipping/address/select_address_page.dart';
import 'package:manager/presentation/pages/create_order/shipping/details/delivery_time_page.dart';
import 'package:manager/presentation/pages/create_order/shipping/select_section/select_section_page.dart';
import 'package:manager/presentation/pages/create_order/shipping/select_table/select_table_page.dart';
import 'package:manager/presentation/pages/create_order/shipping/select_user/select_user_page.dart';
import 'package:manager/presentation/pages/create_order/shipping/shipping_address_page.dart';
import 'package:manager/presentation/pages/income/income_page.dart';
import 'package:manager/presentation/pages/main/main_page.dart';
import 'package:manager/presentation/pages/merchant/delivery_zone/delivery_zone_page.dart';
import 'package:manager/presentation/pages/notification/notification_list_page.dart';
import 'package:manager/presentation/pages/order_history/order_history.dart';
import 'package:manager/presentation/pages/subscriptions/subscriptions_page.dart';
import 'package:manager/presentation/pages/tasks/tasks_page.dart';
import 'package:manager/presentation/routes/auth_route_pages.dart';
import 'package:manager/presentation/routes/registration_step_pages.dart';
import 'package:manager/presentation/routes/route_pages.dart';
// @generated-imports-end

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
// @generated-routes-start
    MaterialRoute(path: '/', page: SplashRoute.page),
    MaterialRoute(path: '/no-connection', page: NoConnectionRoute.page),
    MaterialRoute(path: '/closed', page: ClosedRoute.page),
    MaterialRoute(path: '/ui-type', page: UiTypeRoute.page),
    CupertinoRoute(path: '/main', page: MainRoute.page),
    CupertinoRoute(path: '/order-products', page: ManagerCreateOrderRoute.page),
    CupertinoRoute(path: '/order', page: ManagerOrderRoute.page),
    CupertinoRoute(path: '/order-history', page: ManagerOrderHistoryRoute.page),
    CupertinoRoute(path: '/shipping-address', page: ManagerShippingAddressRoute.page),
    CupertinoRoute(path: '/select-address', page: ManagerSelectAddressRoute.page),
    CupertinoRoute(path: '/select-user', page: ManagerSelectUserRoute.page),
    CupertinoRoute(path: '/delivery-time', page: ManagerDeliveryTimeRoute.page),
    MaterialRoute(path: '/select-section', page: ManagerSelectSectionRoute.page),
    MaterialRoute(path: '/select-table', page: ManagerSelectTableRoute.page),
    MaterialRoute(path: '/subscriptions', page: ManagerSubscriptionsRoute.page),
    CupertinoRoute(path: '/list-notification', page: NotificationListRoute.page),
    CupertinoRoute(path: '/tasks', page: TasksRoute.page),
    CupertinoRoute(path: '/calc', page: CalculatorRoute.page),
    CupertinoRoute(path: '/income', page: ManagerIncomeRoute.page),
    CupertinoRoute(path: '/delivery-zone', page: ManagerDeliveryZoneRoute.page),
    MaterialRoute(path: '/login', page: LoginRoute.page),
    MaterialRoute(path: '/register', page: RegisterRoute.page),
    MaterialRoute(path: '/register-confirmation', page: RegisterConfirmationRoute.page),
    MaterialRoute(path: '/reset-password', page: ResetPasswordRoute.page),
    MaterialRoute(path: '/registration-steps', page: RegistrationStepsRoute.page),
// @generated-routes-end
        // Host-owned routes, deliberately OUTSIDE the generated markers:
        // update_router_table() rewrites everything between them on every
        // compose, and no SDK manifest declares these pages - they are the
        // app's own (lib/presentation/pages/). Each should migrate into its
        // owning SDK's manifest as its feature moves out of the app.
        //
        // /login is NO LONGER host-owned (plan M3): auth_sdk installs with
        // skip_install lifted, its route shells generate LoginRoute et al.,
        // and its manifest routes land in the @generated block above on
        // recompose. The host auth pages are deleted.
        //
        // /list-notification stays host-owned until comms_sdk's notification
        // parameterisation (fork plan S-3) lands.
        //
        // /view_map + /search_map: host map pages, still referenced by the
        // kept application/map slice (fork plan H-10 dedup follow-up).
        CupertinoRoute(
            path: '/list-notification', page: NotificationListRoute.page),
        CupertinoRoute(path: '/view_map', page: ViewMapRoute.page),
        CupertinoRoute(path: '/search_map', page: MapSearchRoute.page),
      ];
}

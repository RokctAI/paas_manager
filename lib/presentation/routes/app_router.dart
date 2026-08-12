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
import 'package:manager/presentation/pages/sync_issues/sync_issues_page.dart';
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
        CupertinoRoute(path: '/sync-issues', page: ManagerSyncIssuesRoute.page),
        CupertinoRoute(
            path: '/order-products', page: ManagerCreateOrderRoute.page),
        CupertinoRoute(path: '/order', page: ManagerOrderRoute.page),
        CupertinoRoute(
            path: '/order-history', page: ManagerOrderHistoryRoute.page),
        CupertinoRoute(
            path: '/shipping-address', page: ManagerShippingAddressRoute.page),
        CupertinoRoute(
            path: '/select-address', page: ManagerSelectAddressRoute.page),
        CupertinoRoute(path: '/select-user', page: ManagerSelectUserRoute.page),
        CupertinoRoute(
            path: '/delivery-time', page: ManagerDeliveryTimeRoute.page),
        MaterialRoute(
            path: '/select-section', page: ManagerSelectSectionRoute.page),
        MaterialRoute(
            path: '/select-table', page: ManagerSelectTableRoute.page),
        MaterialRoute(
            path: '/subscriptions', page: ManagerSubscriptionsRoute.page),
        CupertinoRoute(
            path: '/list-notification', page: NotificationListRoute.page),
        CupertinoRoute(path: '/tasks', page: TasksRoute.page),
        CupertinoRoute(path: '/calc', page: CalculatorRoute.page),
        CupertinoRoute(path: '/income', page: ManagerIncomeRoute.page),
        CupertinoRoute(
            path: '/delivery-zone', page: ManagerDeliveryZoneRoute.page),
        MaterialRoute(path: '/login', page: LoginRoute.page),
        MaterialRoute(path: '/register', page: RegisterRoute.page),
        MaterialRoute(
            path: '/register-confirmation',
            page: RegisterConfirmationRoute.page),
        MaterialRoute(path: '/reset-password', page: ResetPasswordRoute.page),
        MaterialRoute(
            path: '/registration-steps', page: RegistrationStepsRoute.page),
// @generated-routes-end
        // No host-owned routes remain (migration M2): /list-notification is
        // comms_sdk's manifest route now (its installed page generates the
        // same NotificationListRoute), and the /view_map + /search_map host
        // map pages were deleted with the application/map slice (decision D5:
        // nothing composed navigates to them; map_sdk owns the map surface).
      ];
}

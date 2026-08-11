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
import 'package:manager/presentation/routes/route_pages.dart';
// @generated-imports-end

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
// @generated-routes-start
// @generated-routes-end
        // Host-owned routes, deliberately OUTSIDE the generated markers:
        // update_router_table() rewrites everything between them on every
        // compose, and no SDK manifest declares these pages - they are the
        // app's own (lib/presentation/pages/). Each should migrate into its
        // owning SDK's manifest as its feature moves out of the app.
        //
        // /login stays host-owned: this app still owns its login page, whose
        // @RoutePage already generates LoginRoute - auth_sdk's route shells
        // would duplicate the name, so auth_sdk is composed with its
        // installer skipped ("skip_install" in composer.json), the same
        // stance paas_driver took.
        //
        // /list-notification stays host-owned until comms_sdk's notification
        // parameterisation (fork plan S-3) lands.
        //
        // /view_map + /search_map: host map pages, still referenced by the
        // kept application/map slice (fork plan H-10 dedup follow-up).
        CupertinoRoute(path: '/login', page: LoginRoute.page),
        CupertinoRoute(
            path: '/list-notification', page: NotificationListRoute.page),
        CupertinoRoute(path: '/view_map', page: ViewMapRoute.page),
        CupertinoRoute(path: '/search_map', page: MapSearchRoute.page),
      ];
}

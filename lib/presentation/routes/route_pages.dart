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

// Host-side route shells for base_sdk's initial pages.
//
// auto_route's generator only scans the host package, so SDK-resident pages
// are wrapped in thin @RoutePage shells here. Feature SDKs contribute their
// own shells through their manifest installs when they own routed pages.
//
// DELIBERATE DEVIATION from base_sdk's template (which also shells
// SplashRoute and NoConnectionRoute), mirroring paas_driver: this app still
// owns its splash, no-connection and login pages under
// lib/presentation/pages/, and those pages' own @RoutePage annotations
// already generate SplashRoute, NoConnectionRoute and LoginRoute. Shelling
// them here too would make auto_route emit two classes per name into
// app_router.gr.dart. Only the two base_sdk pages the app has no local
// equivalent for are shelled - the full template lands when the app's
// initial pages migrate into base_sdk.
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:base_sdk/src/presentation/pages/initial/closed/closed_page.dart'
    as pages;
import 'package:base_sdk/src/presentation/pages/initial/ui_type/ui_type_page.dart'
    as pages;

/// Host route shell for [pages.ClosedPage] (base_sdk-resident page).
@RoutePage(name: 'ClosedRoute')
class ClosedRouteView extends StatelessWidget {
  const ClosedRouteView({super.key});

  @override
  Widget build(BuildContext context) => const pages.ClosedPage();
}

/// Host route shell for [pages.UiTypePage] (base_sdk-resident page).
@RoutePage(name: 'UiTypeRoute')
class UiTypeRouteView extends StatelessWidget {
  final bool isBack;
  const UiTypeRouteView({super.key, this.isBack = false});

  @override
  Widget build(BuildContext context) => pages.UiTypePage(isBack: isBack);
}

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

// Aligned with base_sdk 1.4.0's templates/routes/route_pages.dart (migration
// M2 follow-up): the pre-#27 host copy carried only the Closed/UiType shells
// because the host's own splash/no_connection pages generated
// SplashRoute/NoConnectionRoute - those pages are deleted (base_sdk owns
// them), so all four shells live here now, exactly as the template installs
// on a clean tree. Kept host-owned (tracked) until the M5 untrack commit.
// Host-side route shells for base_sdk's initial pages.
//
// auto_route's generator only scans the host package, so SDK-resident pages
// are wrapped in thin @RoutePage shells here. Feature SDKs contribute their
// own shells through their manifest installs when they own routed pages.
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:base_sdk/src/presentation/pages/initial/closed/closed_page.dart'
    as pages;
import 'package:base_sdk/src/presentation/pages/initial/no_connection/no_connection_page.dart'
    as pages;
import 'package:base_sdk/src/presentation/pages/initial/splash/splash_page.dart'
    as pages;
import 'package:base_sdk/src/presentation/pages/initial/ui_type/ui_type_page.dart'
    as pages;

/// Host route shell for [pages.SplashPage] (base_sdk-resident page).
@RoutePage(name: 'SplashRoute')
class SplashRouteView extends StatelessWidget {
  const SplashRouteView({super.key});

  @override
  Widget build(BuildContext context) => const pages.SplashPage();
}

/// Host route shell for [pages.NoConnectionPage] (base_sdk-resident page).
@RoutePage(name: 'NoConnectionRoute')
class NoConnectionRouteView extends StatelessWidget {
  const NoConnectionRouteView({super.key});

  @override
  Widget build(BuildContext context) => const pages.NoConnectionPage();
}

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

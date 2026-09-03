// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/widgets.dart';

import 'package:base_sdk/src/presentation/adaptive/planes.dart';

/// The manager restaurant hub's plane declaration (approved frames 1f / 7d
/// / 7e, the profile cap ruling 4c — "let all profiles take only 2 planes
/// even if there is 3"): the hub is a PROFILE, so it declares
/// [PlaneSpan.two] and base_sdk's GenericProfilePage spreads itself over
/// the planes it is granted — two balanced columns at two planes or more
/// (core#129's spread branch), the untouched phone list at one. At a
/// three-plane width the third plane trails bare at the END, where the
/// next level lands.
///
/// The hub is TAB-HOSTED: the manager home shell keeps it in an
/// IndexedStack, not on a pushed route, so no PlaneHost sits above it by
/// itself — without this flow `Planes.maybeOf` is null inside the hub and
/// the page renders its one-column phone list stretched across the whole
/// window (tablet store review 2026-09-02, still 08-restaurant_hub). Same
/// shape as the sibling tabs' flows (CatalogPlaneFlow, KitchenPlaneFlow,
/// OrdersBoardPlaneFlow): the page wraps ITSELF in its host.
///
/// The flow is one step deep — the hub's rows push real routes (income,
/// order history, tasks...), so there is no pushed plane and no corner
/// back pill here (the 12:36Z two-state nav: full nav on a top-level
/// page).
class RestaurantHubPlaneFlow extends StatelessWidget {
  /// Builds the hub (base_sdk's GenericProfilePage with the merchant
  /// sections registered).
  final WidgetBuilder hubBuilder;

  const RestaurantHubPlaneFlow({super.key, required this.hubBuilder});

  @override
  Widget build(BuildContext context) {
    return PlaneHost(
      stack: [
        PlanePage(
          name: 'restaurant-hub',
          // The profile cap: two planes max, never all (the approved 4c
          // ruling; GenericProfilePage clamps its own spread too).
          span: PlaneSpan.two,
          builder: hubBuilder,
        ),
      ],
    );
  }
}

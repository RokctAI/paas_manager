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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_sdk/src/presentation/components/floating_nav/floating_nav_mode.dart';

/// The manager shell's tablet-mode side rail beside its pages — with the
/// rail's footprint RESERVED, not overlaid.
///
/// The shell used to float the rail over the tab pages in a Stack, so the
/// first ~92 logical px of every page (16 + 60 + 16: the rail's own
/// margins and housing) sat under it: the hub's Wallet and Reservations
/// rows, the catalog's first grid column, the order cards' leading text
/// and the "+" FAB, kitchen card #EMO-1037 (tablet store review
/// 2026-09-02, stills 08 / 10 / 12 / 14). No approved frame draws content
/// under the rail: the tablet-mode nav placement moved the pill to the
/// edge, it did not make the edge part of the page.
///
/// So the rail takes a column of its own at the start (or end) edge and
/// the pages take the rest; the plane host inside each page counts its
/// planes on the width that is actually the page's. The pages are
/// relieved of the window's start-edge system padding, which the rail's
/// column already absorbs through its own SafeArea (else a notch on that
/// edge would inset the pages a second time).
///
/// One place, every tab: the shell composes this once around its
/// IndexedStack, so no page needs a rail-aware layout of its own.
class NavRailLayout extends StatelessWidget {
  /// [FloatingNavPlacement.railStart] or [FloatingNavPlacement.railEnd].
  final FloatingNavPlacement placement;

  /// The rail (the shell's vertical pill plus its create button).
  final Widget rail;

  /// The tab pages.
  final Widget pages;

  const NavRailLayout({
    super.key,
    required this.placement,
    required this.rail,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    final bool atStart = placement != FloatingNavPlacement.railEnd;
    final bool ltr = Directionality.of(context) == TextDirection.ltr;
    // Which physical side the rail column occupies.
    final bool railOnLeft = atStart == ltr;

    final railColumn = SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
        // Same guard as the bottom pill's items: on a window that is
        // tablet-mode wide but short (landscape phone) the rail scales
        // down instead of overflowing.
        child: Center(
          child: FittedBox(fit: BoxFit.scaleDown, child: rail),
        ),
      ),
    );

    final pageColumn = Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: railOnLeft,
        removeRight: !railOnLeft,
        child: pages,
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (atStart) railColumn,
        pageColumn,
        if (!atStart) railColumn,
      ],
    );
  }
}

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

// The room a pane pushed over a PlaneHost flow leaves for the corner
// Back pill (canonical 347).
//
// Tour run 34040758271, still 10 (phone and tablet): the compose lane
// scrolls under base_sdk's FloatingBackPill, so whatever control lands
// in the bottom-END corner — the Long term switch on the phone, Save
// task on the tablet — sat under the pill. Padding INSIDE the list
// (88.h, the previous figure) only helps once the list is scrolled to
// its end; the still is taken at the top. The band below is reserved
// OUTSIDE the scroll instead, so the viewport itself ends above the
// pill and no control can scroll under it at any offset.
//
// The figures are base_sdk's own: FloatingBackPill's housing is 60.r
// tall and PlaneHost parks it 16 logical in from the bottom edge inside
// the SafeArea; the extra 12.h is the gap the frames leave between the
// last control and the pill (the same gap the merchants shell's
// managerNavClearance and zones' driverRootNavClearance leave under
// theirs). The safe-area inset itself is NOT included — the pane's own
// SafeArea adds it, exactly as PlaneHost does for the pill.

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The height of base_sdk's `FloatingBackPill` housing.
double planeBackPillHeight() => 60.r;

/// How far in from the bottom edge `PlaneHost` parks the pill.
const double planeBackPillInset = 16;

/// The vertical room a pushed pane must leave under its last child so
/// nothing it draws is buried under the corner Back pill.
double planeBackClearance() =>
    planeBackPillHeight() + planeBackPillInset + 12.h;

/// Reserves [planeBackClearance] beneath [child] — for the scroll view of
/// a pane that `PlaneHost` floats its Back pill over. Place it INSIDE the
/// pane's SafeArea and OUTSIDE the scroll view, so the viewport ends
/// above the pill rather than the content merely padding past it.
class PlaneBackClearance extends StatelessWidget {
  const PlaneBackClearance({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: planeBackClearance()),
      child: child,
    );
  }
}

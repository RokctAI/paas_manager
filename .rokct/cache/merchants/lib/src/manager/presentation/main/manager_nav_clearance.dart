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


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The height of the manager shell's floating bottom pill — the BlurWrap
/// housing the installed main_page.dart template draws in its Scaffold's
/// `floatingActionButton` slot (centerFloat). The shell reads this figure
/// too, so the pill and the clearance below can never drift apart.
double managerNavPillHeight() => 60.r;

/// The vertical room a phone page must leave under its last child so
/// nothing it draws is buried under the shell's floating pill.
///
/// The pill is [managerNavPillHeight] tall and the Scaffold floats it
/// [kFloatingActionButtonMargin] above the safe-area edge; the extra
/// `12.h` is the gap the frames leave between the last control and the
/// pill (the same gap zones' driver sheets leave under theirs). The
/// safe-area inset itself is NOT included — the page's own SafeArea adds
/// it, exactly as the Scaffold does for the pill.
///
/// Phone (one-plane) pages only: in a tablet-mode window the manager
/// shell docks the nav as a start rail beside the pages, which reserves
/// its own column and overlays nothing.
double managerNavClearance() =>
    managerNavPillHeight() + kFloatingActionButtonMargin + 12.h;

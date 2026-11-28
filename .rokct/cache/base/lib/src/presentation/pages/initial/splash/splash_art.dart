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

/// The app's own splash scene, drawn in code (Ray, 28 Nov 2026: the approved
/// per-app splashes stay code, not pictures, so they stay sharp and follow
/// light and dark mode).
///
/// A home SDK sets [builder] from its boot hook. When set, the phone splash
/// shows it full screen instead of `assets/images/splash.png` and without the
/// "from ROKCT" line (each approved design carries its own footer). Wide
/// windows keep the breathing app name.
class SplashArt {
  SplashArt._();

  static WidgetBuilder? builder;
}

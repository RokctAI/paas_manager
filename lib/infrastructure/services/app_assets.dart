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

class AppAssets {
  AppAssets._();

  static const String _pngPath = 'assets/image';
  static const String _svgPath = 'assets/svg';
  static const String _lottiePath = 'assets/lottie';

  /// png
  static const String pngSplash = '$_pngPath/splash.png';
  static const String pngLogo = '$_pngPath/logo.png';
  static const String pngNoOrders = '$_pngPath/no_orders.png';
  static const String imageMarker = '$_pngPath/marker.png';

  /// svg
  static const String svgMenu = '$_svgPath/menu.svg';

  /// lottie
  static const String lottiePin = '$_lottiePath/pin.json';
}

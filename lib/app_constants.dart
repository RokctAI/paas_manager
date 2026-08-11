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

import 'infrastructure/services/enums.dart';

class AppConstants {
  AppConstants._();

  static const bool isDemo = bool.fromEnvironment('IS_DEMO');
  static const bool autoTrn = bool.fromEnvironment('AUTO_TRN');
  static const bool appStoreMode = bool.fromEnvironment('APP_STORE_MODE');

  ////Water
  static const bool enableWaterMeterGallerySelection = true;

  /// hero tags
  static const String heroTagAddOrderButton = 'heroTagAddOrderButton';
  static const String heroTagOrderHistory = 'heroTagOrderHistory';
  static const String heroTagIncomePage = 'heroTagIncomePage';
  static const String heroTagListNotification = 'heroTagListNotification';

  /// api urls
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String adminPageUrl = String.fromEnvironment('ADMIN_URL');
  static String imageBaseUrl = const String.fromEnvironment('IMAGE_BASE_URL');
  static String chatGpt = const String.fromEnvironment('CHAT_GPT_KEY');
  static String webUrl = const String.fromEnvironment('WEB_URL');

  /// auth phone fields
  static bool isSpecificNumberEnabled =
      const bool.fromEnvironment('IS_SPECIFIC_NUMBER_ENABLED');
  static bool isNumberLengthAlwaysSame =
      const bool.fromEnvironment('IS_NUMBER_LENGTH_ALWAYS_SAME');
  static String countryCodeISO = const String.fromEnvironment('COUNTRY_ISO');
  static bool showFlag = const bool.fromEnvironment('SHOW_FLAG');
  static bool showArrowIcon = const bool.fromEnvironment('SHOW_ARROW_ICON');
  static SignUpType get signUpType =>
      SignUpType.values.byName(const String.fromEnvironment('SIGN_UP_TYPE'));

  /// location
  static double demoLatitude =
      double.parse(const String.fromEnvironment('DEMO_LATITUDE'));
  static double demoLongitude =
      double.parse(const String.fromEnvironment('DEMO_LONGITUDE'));
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  /// demo app info
  static const String demoSellerLogin =
      String.fromEnvironment('DEMO_SELLER_LOGIN');
  static const String demoSellerPassword =
      String.fromEnvironment('DEMO_SELLER_PASSWORD');

  ////QRCodes for Water Service
  static const Map<String, String> STEP_CODES = {
    'openTank': 'F24GZ25',
    'refillDispenser': 'H7JK9L3',
    'clean': 'M1NP5Q8',
    'checkFridge': 'R2ST6U9',
    'turnOnComputer': 'V3WX7Y0',
    'turnOnPrinter': 'A4BC8D1',
  };
}

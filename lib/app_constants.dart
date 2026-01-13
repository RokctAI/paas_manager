import 'infrastructure/services/enums.dart';

class AppConstants {
  AppConstants._();

  static const bool isDemo = false;
  static const bool autoTrn = true;
  static bool appStoreMode = false;

  ////Water
  static const bool enableWaterMeterGallerySelection = true;

  /// hero tags
  static const String heroTagAddOrderButton = 'heroTagAddOrderButton';
  static const String heroTagOrderHistory = 'heroTagOrderHistory';
  static const String heroTagIncomePage = 'heroTagIncomePage';
  static const String heroTagListNotification = 'heroTagListNotification';
  /// api urls
  /// api urls
  static const String adminPageUrl = baseUrl;
  static String imageBaseUrl = '$baseUrl/storage/images';
  static String chatGpt = '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';
  static String webUrl = 'https://web.juvo.app';


  /// auth phone fields
  static bool isSpecificNumberEnabled = false;
  static bool isNumberLengthAlwaysSame = true;
  static String countryCodeISO = 'ZA';
  static bool showFlag = true;
  static bool showArrowIcon = true;
  static SignUpType signUpType = SignUpType.phone;



  /// location
  static double demoLatitude = -22.34058;
  static double demoLongitude = 30.01341;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  /// demo app info
  static const String demoSellerLogin = '';
  static const String demoSellerPassword = '';

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

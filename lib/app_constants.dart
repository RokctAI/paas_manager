class AppConstants {
  AppConstants._();

  static const bool isDemo = bool.fromEnvironment('IS_DEMO');
  static const bool autoTrn = bool.fromEnvironment('AUTO_TRN');
  static const double radius = 10;
  static const Duration animationDuration = Duration(milliseconds: 375);

  /// api urls
  static const String adminPageUrl = String.fromEnvironment('ADMIN_URL');
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String chatGpt = '';
  static const String webUrl = String.fromEnvironment('WEB_URL');

  // sound notification
  static bool playMusicOnOrderStatusChange = true;
  static bool keepPlayingOnNewOrder = false;

  /// auth phone fields
  static const bool isSpecificNumberEnabled = bool.fromEnvironment(
    'IS_SPECIFIC_NUMBER_ENABLED',
  );
  static const bool isNumberLengthAlwaysSame = bool.fromEnvironment(
    'IS_NUMBER_LENGTH_ALWAYS_SAME',
  );
  static const String countryCodeISO = String.fromEnvironment('COUNTRY_ISO');
  static const bool showFlag = bool.fromEnvironment('SHOW_FLAG');
  static const bool showArrowIcon = bool.fromEnvironment('SHOW_ARROW_ICON');

  /// location
  static final double demoLatitude = double.parse(
    const String.fromEnvironment('DEMO_LATITUDE'),
  );
  static final double demoLongitude = double.parse(
    const String.fromEnvironment('DEMO_LONGITUDE'),
  );
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  /// demo app info
  static const String demoSellerLogin = String.fromEnvironment(
    'DEMO_SELLER_LOGIN',
  );
  static const String demoSellerPassword = String.fromEnvironment(
    'DEMO_SELLER_PASSWORD',
  );

  /// hero tags
  static const String heroTagAddOrderButton = 'heroTagAddOrderButton';
  static const String heroTagOrderHistory = 'heroTagOrderHistory';
  static const String heroTagIncomePage = 'heroTagIncomePage';
}

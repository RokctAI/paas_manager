class AppConstants {
  AppConstants._();

  static const bool isDemo = true;
  static const bool autoTrn = true;

  /// hero tags
  static const String heroTagAddOrderButton = 'heroTagAddOrderButton';
  static const String heroTagOrderHistory = 'heroTagOrderHistory';
  static const String heroTagIncomePage = 'heroTagIncomePage';

  /// api urls
  static const String adminPageUrl = 'https://admin.foodyman.org';
  static const String baseUrl = 'https://api.foodyman.org';
  static const String imageBaseUrl = '$baseUrl/storage/images';
  static const String chatGpt = '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';
  static const String webUrl = 'https://foodyman.org';


  /// auth phone fields
  static const bool isSpecificNumberEnabled = false;
  static const bool isNumberLengthAlwaysSame = true;
  static const String countryCodeISO = 'UZ';
  static const bool showFlag = true;
  static const bool showArrowIcon = true;



  /// location
  static const double demoLatitude = 41.304223;
  static const double demoLongitude = 69.2348277;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  /// demo app info
  static const String demoSellerLogin = 'sellers@githubit.com';
  static const String demoSellerPassword = 'seller';
}

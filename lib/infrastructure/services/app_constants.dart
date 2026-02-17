class AppConstants {
  AppConstants._();

  static const bool appStoreMode = false;

  /// shared preferences keys
  static const String keyLangSelected = 'keyLangSelected';
  static const String keyUser = 'keyUser';
  static const String keyAddressSelected = 'keyAddressSelected';
  static const String keyToken = 'keyToken';
  static const String keySelectedCurrency = 'keySelectedCurrency';
  static const String keyAppThemeMode = 'keyAppThemeMode';
  static const String keyGlobalSettings = 'keyGlobalSettings';
  static const String keyTranslations = 'keyTranslations';
  static const String keyLanguageData = 'keyLanguageData';
  static const String keyLangLtr = 'keyLangLtr';
  static const String keyWallet = 'keyWallet';
  static const String keyShop = 'keyShop';
  static const String keySystemLanguage = 'keySystemLanguage';
  static const String keyFirstName = 'keyFirstName';
  static const String keyLastName = 'keyLastName';
  static const String keyProfileImage = 'keyProfileImage';
  static const String keyUserId = 'keyUserId';
  static const String keyUserImage = 'keyUser';
  static const String keyWalletData = 'keyWalletData';

  /// hero tags
  static const String heroTagAddOrderButton = 'heroTagAddOrderButton';
  static const String heroTagListNotification = 'heroTagListNotification';
  static const String heroTagOrderHistory = 'heroTagOrderHistory';
  static const String heroTagIncomePage = 'heroTagIncomePage';

  /// api urls
  static const String adminPageUrl = 'https://admin.fo2odyman.org';
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

enum OrderStatus {
  newOrder,
  accepted,
  ready,
  onAWay,
  delivered,
  canceled,
}

enum SnackBarType { success, info, error }

enum ExtrasType { color, text, image }

enum DeliveryType { delivery, pickup }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
}

enum ProductStatus { published, pending, unpublished }

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
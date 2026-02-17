import 'package:dio/dio.dart';
import 'package:ftoast/ftoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/presentation/component/buttons/custom_button.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'enums.dart';
import 'tr_keys.dart';
import '../../app_constants.dart';
import 'local_storage.dart';

class AppHelpers {
  AppHelpers._();

  static Future openDialog({
    required BuildContext context,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: AppStyle.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            margin: EdgeInsets.all(24.w),
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    getTranslation(title),
                    textAlign: TextAlign.center,
                    style: AppStyle.interNormal(size: 18),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: () => Navigator.pop(context),
                    title: getTranslation(TrKeys.close),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void errorSnackBar(BuildContext context, {String? text}) {
    FToast.toast(
      context,
      toast: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height / 1.5,
              left: 32.r,
              right: 32.r,
            ),
            decoration: BoxDecoration(
              color: AppStyle.primary,
              borderRadius: BorderRadius.circular((AppConstants.radius / 2).r),
            ),
            child: Text(
              text ?? AppHelpers.getTranslation(TrKeys.failed),
              style: AppStyle.interNormal(color: AppStyle.white, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  static List<List<Extras>> cartesian(List<List<dynamic>> args) {
    List<List<Extras>> r = [];
    int max = args.length - 1;

    void helper(List<Extras> arr, int i) {
      for (int j = 0, l = args[i].length; j < l; j++) {
        List<Extras> a = List.from(arr);
        a.add(args[i][j]);
        if (i == max) {
          r.add(a);
        } else {
          helper(a, i + 1);
        }
      }
    }

    helper([], 0);
    return r;
  }

  static String numberFormat(num? number, {String? symbol, int? maxLength}) {
    symbol = symbol ?? LocalStorage.getSelectedCurrency()?.symbol ?? '';

    bool isBefore = LocalStorage.getSelectedCurrency()?.position == "before";
    String beforeSymbol = (isBefore ? symbol : '');
    String afterSymbol = (isBefore ? '' : ' $symbol');
    if ((number?.toStringAsFixed(1).length ?? 0) > 12) {
      maxLength = maxLength;
    } else {
      maxLength = 16;
    }
    if ((number?.toStringAsFixed(1).length ?? 0) > (maxLength ?? 16)) {
      return beforeSymbol +
          (number?.toStringAsExponential(maxLength ?? 10) ?? '') +
          afterSymbol;
    }
    if ((number?.toStringAsFixed(1).length ?? 0) > 8) {
      return beforeSymbol +
          NumberFormat.compact(
            locale: LocalStorage.getLanguage()?.locale,
          ).format(number) +
          afterSymbol;
    }
    if (isBefore) {
      return NumberFormat.currency(
        customPattern: '\u00a4#,###.#',
        symbol: symbol,
        decimalDigits: 2,
      ).format(number ?? 0);
    } else {
      return NumberFormat.currency(
        customPattern: '#,###.#\u00a4',
        symbol: symbol,
        decimalDigits: 2,
      ).format(number ?? 0);
    }
  }

  static SignUpType getAuthOption() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'auth_option') {
        switch (setting.value) {
          case 'phone':
            return SignUpType.phone;
          case 'email':
            return SignUpType.email;
          default:
            return SignUpType.both;
        }
      }
    }
    return SignUpType.both;
  }

  static String? selectedAddonsTitles(Stock stock) {
    final List<AddonData> addons = stock.localAddons ?? [];
    if (addons.isEmpty) {
      return null;
    }
    String text = '${addons[0].product?.translation?.title}';
    if (addons.length > 1) {
      for (int i = 1; i < addons.length; i++) {
        text =
            '$text${i != addons.length ? ',' : ''} ${addons[i].product?.translation?.title} ';
      }
    }
    return text;
  }

  static String? getAppAddressName() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'address') {
        return setting.value;
      }
    }
    return '';
  }

  static String getInitialAddonQuantity(ProductData addon) {
    return addon.stock?.quantity == null
        ? ''
        : addon.stock?.quantity.toString() ?? "";
  }

  static String getInitialAddonPrice(ProductData addon) {
    return addon.stock?.price.toString() ?? "";
  }

  static String truncate(String value, int length) {
    return value.length > length ? value.substring(0, length) : value;
  }

  static String getShopWorkingTimeForToday() {
    final shop = LocalStorage.getShop();
    if (shop == null) {
      return getTranslation(TrKeys.theRestaurantIsClosedToday);
    }
    final currentWeekday = DateFormat(
      'EEEE',
    ).format(DateTime.now()).toLowerCase();
    final List<ShopWorkingDays> workingDays = shop.shopWorkingDays ?? [];
    for (final day in workingDays) {
      if (day.day?.toLowerCase() == currentWeekday) {
        if (day.disabled ?? false) {
          return getTranslation(TrKeys.theRestaurantIsClosedToday);
        }
        return '${day.from?.substring(0, 2)}:${day.from?.substring(3, 5)} - ${day.to?.substring(0, 2)}:${day.to?.substring(3, 5)}';
      }
    }
    return '';
  }

  static double? getInitialLatitude() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'location') {
        final String? latString = setting.value?.substring(
          0,
          setting.value?.indexOf(','),
        );
        if (latString == null) {
          return null;
        }
        final double? lat = double.tryParse(latString);
        return lat;
      }
    }
    return null;
  }

  static double? getInitialLongitude() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'location') {
        final String? latString = setting.value?.substring(
          0,
          setting.value?.indexOf(','),
        );
        if (latString == null) {
          return null;
        }
        final String? lonString = setting.value?.substring(
          (latString.length) + 2,
          setting.value?.length,
        );
        if (lonString == null) {
          return null;
        }
        final double lon = double.parse(lonString);
        return lon;
      }
    }
    return null;
  }

  static String? getAppPhone() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'phone') {
        return setting.value;
      }
    }
    return '';
  }

  static ExtrasType getExtraTypeByValue(String? value) {
    switch (value) {
      case 'color':
        return ExtrasType.color;
      case 'text':
        return ExtrasType.text;
      case 'image':
        return ExtrasType.image;
      default:
        return ExtrasType.text;
    }
  }

  static OrderStatus getUpdatableStatus(String? value) {
    switch (value) {
      case 'new':
        return OrderStatus.accepted;
      case 'accepted':
        return OrderStatus.cooking;
      case 'cooking':
        return OrderStatus.ready;
      case 'ready':
        return OrderStatus.onAWay;
      case 'on_a_way':
        return OrderStatus.delivered;
      case 'delivered':
        return OrderStatus.newOrder;
      case 'canceled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.accepted;
    }
  }

  static String changeStatusButtonText(String? value) {
    switch (value) {
      case 'new':
        return getTranslation(TrKeys.swipeToAccept);
      case 'accepted':
        return getTranslation(TrKeys.swipeToCooking);
      case 'cooking':
        return getTranslation(TrKeys.swipeToReady);
      case 'ready':
        return getTranslation(TrKeys.swipeToWay);
      case 'on_a_way':
        return getTranslation(TrKeys.swipeToDelivered);
      case 'delivered':
        return getTranslation(TrKeys.swipeToAccept);
      case 'canceled':
        return getTranslation(TrKeys.swipeToAccept);
      default:
        return getTranslation(TrKeys.swipeToAccept);
    }
  }

  static OrderStatus getOrderStatus(String? value) {
    switch (value) {
      case 'new':
        return OrderStatus.newOrder;
      case 'accepted':
        return OrderStatus.accepted;
      case 'cooking':
        return OrderStatus.cooking;
      case 'ready':
        return OrderStatus.ready;
      case 'on_a_way':
        return OrderStatus.onAWay;
      case 'delivered':
        return OrderStatus.delivered;
      case 'canceled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.newOrder;
    }
  }

  static void showPopup({
    required BuildContext context,
    required Iterable<PopupMenuItem> items,
    double radius = AppConstants.radius,
    bool isRight = false,
  }) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx + (isRight ? size.width : 0),
        position.dy + size.height / 3,
        position.dx,
        position.dy + (isRight ? size.width : 0),
      ),
      elevation: 3,
      constraints: BoxConstraints(
        minWidth: size.width / 2,
        maxWidth: size.width,
      ),
      shadowColor: AppStyle.differBorderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      color: AppStyle.white,
      items: items.toList(),
    );
  }

  static bool checkIsSvg(String? url) {
    if (url == null) {
      return false;
    }
    final length = url.length;
    return url.substring(length - 3, length) == 'svg';
  }

  static String getAppName() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'title') {
        return setting.value ?? '';
      }
    }
    return '';
  }

  static void showNoConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Text(
        'No internet connection',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppStyle.white,
        ),
      ),
      action: SnackBarAction(
        label: 'Close',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showCheckTopSnackBar(
    BuildContext context, {
    String? text,
    SnackBarType? type,
  }) {
    return showTopSnackBar(
      Overlay.of(context),
      type == SnackBarType.error
          ? CustomSnackBar.error(
              message:
                  text ??
                  AppHelpers.getTranslation(
                    TrKeys.somethingWentWrongWithTheServer,
                  ),
            )
          : (type == SnackBarType.success
                ? CustomSnackBar.success(
                    message:
                        text ??
                        AppHelpers.getTranslation(TrKeys.successfullyCompleted),
                  )
                : CustomSnackBar.info(
                    message:
                        text ?? AppHelpers.getTranslation(TrKeys.infoMessage),
                  )),
    );
  }

  static String getTranslation(String trKey) {
    final Map<String, dynamic> translations = LocalStorage.getTranslations();
    if (AppConstants.autoTrn) {
      return (translations[trKey] ??
          (trKey.isNotEmpty
              ? trKey
                    .replaceAll(".", " ")
                    .replaceAll("_", " ")
                    .replaceFirst(
                      trKey.substring(0, 1),
                      trKey.substring(0, 1).toUpperCase(),
                    )
              : ''));
    } else {
      return translations[trKey] ?? trKey;
    }
  }

  static void showCustomModalBottomSheet({
    required BuildContext context,
    required Widget modal,
    required bool isDarkMode,
    double radius = 16,
    bool isDrag = true,
    bool isDismissible = true,
    double paddingTop = 200,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop.r,
      ),
      backgroundColor: AppStyle.transparent,
      context: context,
      builder: (context) =>
          Padding(padding: MediaQuery.of(context).viewInsets, child: modal),
    );
  }

  static void showCustomModalBottomDragSheet({
    required BuildContext context,
    required Function(ScrollController controller) modal,
    double radius = 16,
    bool isDrag = true,
    bool isDismissible = true,
    double paddingTop = 100,
    double maxChildSize = 0.9,
    double initSize = 0.9,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop.r,
      ),
      backgroundColor: AppStyle.transparent,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return modal(scrollController);
        },
      ),
    );
  }

  static void showCustomModalBottomSheetWithoutIosIcon({
    required BuildContext context,
    required Widget modal,
    required bool isDarkMode,
    double radius = 16,
    bool isDrag = true,
    double paddingTop = 200,
  }) {
    showModalBottomSheet(
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop.r,
      ),
      backgroundColor: AppStyle.transparent,
      context: context,
      builder: (context) => modal,
    );
  }

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
    double radius = 16,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
          ),
          contentPadding: EdgeInsets.all(16.r),
          iconPadding: EdgeInsets.zero,
          content: child,
        );
      },
    );
  }

  static String errorHandler(dynamic e) {
    try {
      return (e.runtimeType == DioException)
          ? ((e as DioException).response?.data["message"] == "Bad request."
                ? (e.response?.data["params"] as Map).values.first[0]
                : e.response?.data["message"])
          : e.toString();
    } catch (s) {
      try {
        return (e.runtimeType == DioException)
            ? ((e as DioException).response?.data.toString().substring(
                (e.response?.data.toString().indexOf("<title>") ?? 0) + 7,
                e.response?.data.toString().indexOf("</title") ?? 0,
              )).toString()
            : e.toString();
      } catch (r) {
        return (e.runtimeType == DioException)
            ? ((e as DioException).response?.data["error"]["message"])
                  .toString()
            : e.toString();
      }
    }
  }
}

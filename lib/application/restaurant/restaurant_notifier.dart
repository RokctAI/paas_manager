import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'restaurant_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class RestaurantNotifier extends StateNotifier<RestaurantState> {
  final UsersInterface _usersRepository;
  final SettingsInterface _settingsRepository;
  String _title = '';
  String _description = '';
  String _phone = '';

  RestaurantNotifier(this._usersRepository, this._settingsRepository)
      : super(const RestaurantState());

  Future<void> updateWorkingDays(List<ShopWorkingDays> days) async {
    final shop = state.shop?.copyWith(shopWorkingDays: days);
    LocalStorage.setShop(shop);
    state = state.copyWith(shop: shop);
  }

  Future<void> fetchMyShop({VoidCallback? afterFetched}) async {
    final response = await _usersRepository.getMyShop();
    response.when(
      success: (data) {
        LocalStorage.setShop(data.data);
        state = state.copyWith(shop: data.data,orderPayment: data.data?.orderPayment);
        afterFetched?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(shop: LocalStorage.getShop());
        afterFetched?.call();
        debugPrint('==> error with fetching my shop $failure');
      },
    );
  }

  void setPhone(String value) {
    _phone = value.trim();
  }

  void setDescription(String value) {
    _description = value.trim();
  }

  void setTitle(String value) {
    _title = value.trim();
  }

  void setPayment(String value) {
    state = state.copyWith(orderPayment: value);
  }

  void setLogoImageFile(String? file) {
    state = state.copyWith(logoImageFile: file);
  }

  Future<void> updateShop(BuildContext context,
      {VoidCallback? updateSuccess}) async {
    if (state.backgroundImageFile == null && state.logoImageFile == null) {
      updateSuccess?.call();
    }
    state = state.copyWith(isLoading: true);
    String? backUrl;
    if (state.backgroundImageFile != null) {
      final imageResponse = await _settingsRepository.uploadImage(
        state.backgroundImageFile!,
        UploadType.shopsBack,
      );
      imageResponse.when(
        success: (data) {
          backUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload shop back image fail: $failure');
          AppHelpers.showCheckTopSnackBar(context,
              text: failure, type: SnackBarType.error);
        },
      );
    }
    String? logoUrl;
    if (state.logoImageFile != null) {
      final imageResponse = await _settingsRepository.uploadImage(
        state.logoImageFile!,
        UploadType.shopsLogo,
      );
      imageResponse.when(
        success: (data) {
          logoUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload shop logo image fail: $failure');
          AppHelpers.showCheckTopSnackBar(context,
              text: failure, type: SnackBarType.error);
        },
      );
    }
    Translation? newTranslation = state.shop?.translation;
    newTranslation = newTranslation?.copyWith(
      title: _title.isNotEmpty ? _title : newTranslation.title,
      description:
          _description.isNotEmpty ? _description : newTranslation.description,
    );

    final response = await _usersRepository.updateShop(
      backImg: backUrl ?? state.shop?.backgroundImg,
      logoImg: logoUrl ?? state.shop?.logoImg,
      tax: state.shop?.tax.toString(),
      percentage: state.shop?.percentage,
      phone: _phone.isNotEmpty ? _phone : state.shop?.phone,
      type: state.shop?.type,
      pricePerKm: state.shop?.pricePerKm,
      minAmount: state.shop?.minAmount.toString(),
      price: state.shop?.price,
      translation: newTranslation,
      categories: state.shop?.categories,
      deliveryTime: state.shop?.deliveryTime,
      tags: state.shop?.tags,
      orderPayment: state.orderPayment,
    );
    response.when(
      success: (data) {
        _title = '';
        _description = '';
        _phone = '';
        state = state.copyWith(
          isLoading: false,
          shop: data.data,
          backgroundImageFile: null,
          logoImageFile: null,
        );
        updateSuccess?.call();
      },
      failure: (failure, status) {
        debugPrint('===> update shop fail $failure');
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(context,
            text: failure, type: SnackBarType.error);
      },
    );
  }

  void setBackgroundImageFile(String? file) {
    state = state.copyWith(backgroundImageFile: file);
  }

  void setOnlineOffline() {
    _usersRepository.setOnlineOffline();
  }
}

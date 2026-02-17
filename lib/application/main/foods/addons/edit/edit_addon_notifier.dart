import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_addon_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class EditAddonNotifier extends StateNotifier<EditAddonState> {
  final ProductsInterface _productsRepository;
  String _oldBarcode = '';
  String _tax = '';
  String _barcode = '';
  String _description = '';
  String _title = '';
  String _quantity = '';
  String _price = '';
  bool _active = true;

  EditAddonNotifier(this._productsRepository) : super(const EditAddonState());

  void setQuantity(String value) {
    _quantity = value.trim();
  }

  void setPrice(String value) {
    _price = value.trim();
  }

  void setTax(String value) {
    _tax = value.trim();
  }

  void setActive(bool? value) {
    _active = !_active;
  }

  void setDesc() {
    Map<String, List<String>> temp = Map.from(state.mapOfDesc);
    if (temp.containsKey(LocalStorage.getLanguage()?.locale)) {
      List<String> list = [_title, _description];
      temp.update(LocalStorage.getLanguage()?.locale ?? 'en', (value) => list);
    } else {
      List<String> list = [_title, _description];
      temp[LocalStorage.getLanguage()?.locale ?? "en"] = list;
    }
    state = state.copyWith(
      mapOfDesc: temp,
    );
  }

  Future<void> updateAddon(
    BuildContext context, {
    String? uuid,
    UnitData? unit,
    VoidCallback? updated,
    VoidCallback? failed,
  }) async {
    setDesc();
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.updateProduct(
      interval: "1",
      tax: _tax,
      maxQty: '10000',
      minQty: '1',
      qrcode: _barcode == _oldBarcode ? null : _barcode,
      active: _active,
      unitId: unit?.id,
      uuid: uuid,
      needAddons: true,
      titlesAndDescriptions: state.mapOfDesc,
    );
    response.when(
      success: (data) async {
        final stockResponse = await _productsRepository.updateStocks(
          deletedStocks: [],
          stocks: [
            Stock(
              quantity: int.tryParse(_quantity),
              price: num.tryParse(_price),
            ),
          ],
          uuid: data.data?.uuid,
          isAddon: true,
        );
        stockResponse.when(
          success: (stockData) {
            updated?.call();
            state = state.copyWith(isLoading: false);
          },
          failure: (stockFail, status) {
            debugPrint('===> update addon stock fail $stockFail');
            failed?.call();
            state = state.copyWith(isLoading: false);
            AppHelpers.showCheckTopSnackBar(context,
                text: stockFail, type: SnackBarType.error);
          },
        );
      },
      failure: (fail, status) {
        state = state.copyWith(isLoading: false);
        debugPrint('===> addon update fail $fail');
        failed?.call();
        AppHelpers.showCheckTopSnackBar(context,
            text: fail, type: SnackBarType.error);
      },
    );
  }

  void setBarcode(String value) {
    _barcode = value.trim();
  }

  void setDescription(String value) {
    _description = value.trim();
  }

  void setTitle(String value) {
    _title = value.trim();
  }

  void setAddonDetails(ProductData addon) {
    debugPrint('===> set addon details tax ${addon.tax}');
    _tax = addon.tax == null ? '' : addon.tax.toString();
    _title = addon.translation?.title ?? '';
    _description = addon.translation?.description ?? '';
    _oldBarcode = addon.barCode ?? '';
    _barcode = addon.barCode ?? '';
    _price = AppHelpers.getInitialAddonPrice(addon);
    _quantity = AppHelpers.getInitialAddonQuantity(addon);
    _active = addon.active ?? false;
    if (addon.translations != null) {
      Map<String, List<String>> temp = Map.from(state.mapOfDesc);
      var items = addon.translations;
      for (int i = 0; i < addon.translations!.length; i++) {
        temp[items?[i].locale ?? "en"] = [
          items?[i].title ?? '',
          items?[i].description ?? ''
        ];
      }
      state = state.copyWith(mapOfDesc: temp);
    }
  }
}

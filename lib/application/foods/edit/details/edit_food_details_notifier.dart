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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_details_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class EditFoodDetailsNotifier extends StateNotifier<EditFoodDetailsState> {
  final ProductsInterface _productsRepository;
  final SettingsInterface _settingsRepository;
  String? _oldBarcode;

  EditFoodDetailsNotifier(this._productsRepository, this._settingsRepository)
      : super(const EditFoodDetailsState());

  void setTax(String value) {
    state = state.copyWith(tax: value.trim());
  }

  void setInterval(String value) {
    state = state.copyWith(interval: value.trim());
  }

  void setMaxQty(String value) {
    state = state.copyWith(maxQty: value.trim());
  }

  void setMinQty(String value) {
    state = state.copyWith(minQty: value.trim());
  }

  void setActive(bool? value) {
    debugPrint('=== SET ACTIVE DETAILED DEBUG ===');
    debugPrint('Input value parameter: $value (${value.runtimeType})');
    debugPrint('Current state.active BEFORE: ${state.active}');
    debugPrint('Current state.product?.active BEFORE: ${state.product?.active}');

    final newActiveValue = value ?? !state.active;
    debugPrint('Calculated newActiveValue: $newActiveValue');

    // Update state
    state = state.copyWith(active: newActiveValue);
    debugPrint('State updated. state.active AFTER: ${state.active}');

    // Also update the product in state
    final product = state.product?.copyWith(active: newActiveValue);
    state = state.copyWith(product: product);

    debugPrint('Product updated. state.product?.active AFTER: ${state.product?.active}');
    debugPrint('================================');
  }


  Future<void> updateProduct(
    BuildContext context, {
    UnitData? unit,
    KitchenModel? kitchen,
    CategoryData? category,
    Function(ProductData?)? updated,
    VoidCallback? failed,
  }) async {
    debugPrint('=== UPDATE PRODUCT DETAILED DEBUG ===');
    debugPrint('state.active at start of updateProduct: ${state.active}');
    debugPrint('state.product?.active at start of updateProduct: ${state.product?.active}');
    state = state.copyWith(isLoading: true);
    setDesc();
    List<String> imageUrl = List.from(state.listOfUrls.map((e) => e.path));
    if (state.images.isNotEmpty) {
      final imageResponse = await _settingsRepository.uploadMultiImage(
        state.images,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl.addAll(data.data?.title ?? []);
        },
        failure: (failure, status) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.showCheckTopSnackBar(context, text: failure);
          state = state.copyWith(isLoading: true);
        },
      );
    }
    List<Galleries> tempList = List.from(List.from(state.listOfUrls)
        .where((element) => element.preview != null));
    List<String> previews = [];
    for (var element in tempList) {
      if (element.preview?.isNotEmpty ?? false) {
        previews.add(element.preview!);
      }
    }
    final response = await _productsRepository.updateProduct(
      titlesAndDescriptions: state.mapOfDesc,
      interval: state.interval,
      tax: state.tax,
      maxQty: state.maxQty,
      minQty: state.minQty,
      qrcode: state.barcode == _oldBarcode ? null : state.barcode,
      active: state.product?.active ?? false,
      categoryId: category?.id,
      unitId: unit?.id,
      kitchenId: kitchen?.id,
      images: imageUrl,
      uuid: state.product?.uuid,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        final updatedTranslation = state.product?.translation?.copyWith(
          title: state.title,
          description: state.description,
        );
        final updatedProduct = state.product?.copyWith(
          translation: updatedTranslation,
          tax: num.tryParse(state.tax),
          maxQty: int.tryParse(state.maxQty),
          minQty: int.tryParse(state.minQty),
          barCode: state.barcode,
          active: state.active,
          interval: num.tryParse(state.interval),
          categoryId: category?.id,
          category: category,
          unit: unit,
          img: imageUrl.first,
        );
        _oldBarcode = state.barcode;
        updated?.call(updatedProduct);
      },
      failure: (fail, status) {
        AppHelpers.showCheckTopSnackBar(context,
            text: fail, type: SnackBarType.error);
        state = state.copyWith(isLoading: false);
        debugPrint('===> product update fail $fail');
        failed?.call();
      },
    );
  }
  void setDesc() {
    Map<String, List<String>> temp = Map.from(state.mapOfDesc);
    if (temp.containsKey(state.language?.locale)) {
      List<String> list = [state.title, state.description];
      temp.update(
          state.language?.locale ?? LocalStorage.getLanguage()?.locale ?? 'en',
              (value) => list);
    } else {
      List<String> list = [state.title, state.description];
      temp[state.language?.locale ??
          LocalStorage.getLanguage()?.locale ??
          "en"] = list;
    }
    state = state.copyWith(
      mapOfDesc: temp,
    );
  }
  void setBarcode(String value) {
    state = state.copyWith(barcode: value.trim());
  }

  void setDescription(String value) {
    state = state.copyWith(description: value.trim());
  }

  void setTitle(String value) {
    state = state.copyWith(title: value.trim());
  }

  void setImageFile(String file) {
    List<String> list = List.from(state.images);
    list.add(file);
    state = state.copyWith(images: list);
  }

  void setUploadImage(Galleries gallery) {
    List<Galleries> list = List.from(state.listOfUrls);
    list.insert(0, gallery);
    state = state.copyWith(listOfUrls: list);
  }

  void deleteImage(String value) {
    List<String> list = List.from(state.images);
    list.remove(value);
    List<Galleries> urls = List.from(state.listOfUrls);
    urls.removeWhere((element) => element.path == value);
    state = state.copyWith(images: list, listOfUrls: urls);
  }

  void setFoodDetails(ProductData? product) {
    debugPrint('=== SET FOOD DETAILS DEBUG ===');
    debugPrint('Raw product active: ${product?.active}');
    debugPrint('Raw product tax: ${product?.tax}');
    debugPrint('Raw product stocks count: ${product?.stocks?.length}');

    if (product?.stocks?.isNotEmpty == true) {
      debugPrint('Raw first stock tax: ${product?.stocks?.first.tax}');
    }

    // FIXED: Get tax from product level first (user input), not stocks
    String taxValue = '';
    if (product?.tax != null) {
      taxValue = product!.tax.toString();
      debugPrint('Product tax conversion: ${product.tax} -> "$taxValue"');
    } else if (product?.stocks?.isNotEmpty == true) {
      // Fallback to stocks only if product level tax is null
      final stockTax = product?.stocks?.first.tax;
      if (stockTax != null) {
        taxValue = stockTax.toString();
      }
      debugPrint('Stock tax conversion (fallback): $stockTax -> "$taxValue"');
    } else {
      debugPrint('No tax found - keeping empty');
      taxValue = '';
    }

    final activeValue = product?.active ?? false;
    debugPrint('Final values:');
    debugPrint('  tax: "$taxValue"');
    debugPrint('  active: $activeValue');

    state = state.copyWith(
      product: product,
      listOfUrls: product?.galleries ?? [],
      images: [],
      minQty: product?.minQty?.toString() ?? '',
      maxQty: product?.maxQty?.toString() ?? '',
      tax: taxValue, // This will now show "5" when you input 5
      interval: product?.interval?.toString() ?? '',
      title: product?.translation?.title ?? '',
      description: product?.translation?.description ?? '',
      barcode: product?.barCode ?? '',
      active: activeValue,
    );
    _oldBarcode = product?.barCode;

    debugPrint('State after setting:');
    debugPrint('  state.tax: "${state.tax}"');
    debugPrint('  state.active: ${state.active}');
    debugPrint('=============================');

    if (product?.uuid?.isNotEmpty == true) {
      getProductDetailsById(product!.uuid!);
    }
  }

  Future<void> getProductDetailsById(String productId) async {
    debugPrint('=== GET PRODUCT DETAILS DEBUG ===');
    state = state.copyWith(isLoading: true);

    final response = await _productsRepository.getProductDetails(productId);
    response.when(
      success: (data) async {
        debugPrint('Raw API response tax: ${data.data?.tax}');
        debugPrint('Raw API response stocks: ${data.data?.stocks?.map((s) => s.tax).toList()}');

        // FIXED: Get tax from product level first (user input), not stocks
        String taxValue = state.tax; // Keep current if nothing found
        if (data.data?.tax != null) {
          taxValue = data.data!.tax.toString();
          debugPrint('Setting tax from product level: ${data.data?.tax} -> "$taxValue"');
        } else if (data.data?.stocks?.isNotEmpty == true) {
          // Fallback to stocks only if product tax is null
          final stockTax = data.data?.stocks?.first.tax;
          if (stockTax != null) {
            taxValue = stockTax.toString();
          }
          debugPrint('Setting tax from stocks (fallback): $stockTax -> "$taxValue"');
        }

        final activeValue = data.data?.active ?? state.active;
        debugPrint('Final active value: $activeValue');
        debugPrint('Final tax value: "$taxValue"');

        state = state.copyWith(
          product: data.data,
          isLoading: false,
          listOfUrls: data.data?.galleries ?? [],
          tax: taxValue, // This will now show "5" when you input 5
          active: activeValue,
        );

        if (data.data?.translations != null) {
          Map<String, List<String>> temp = Map.from(state.mapOfDesc);
          var items = data.data?.translations;
          for (int i = 0; i < data.data!.translations!.length; i++) {
            temp[items?[i].locale ?? "en"] = [
              items?[i].title ?? '',
              items?[i].description ?? ''
            ];
          }
          state = state.copyWith(mapOfDesc: temp);
        }

        debugPrint('Final state tax: "${state.tax}"');
        debugPrint('==============================');
      },
      failure: (failure, s) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get product details failure: $failure');
      },
    );
  }
}


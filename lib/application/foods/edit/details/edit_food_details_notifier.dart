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
    final product = state.product?.copyWith(
      active: !(state.product?.active ?? false),
    );

    state = state.copyWith(product: product);
  }

  Future<void> updateProduct(
    BuildContext context, {
    UnitData? unit,
    KitchenModel? kitchen,
    CategoryData? category,
    Function(ProductData?)? updated,
    VoidCallback? failed,
  }) async {
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
    List<Galleries> tempList = List.from(
      List.from(state.listOfUrls).where((element) => element.preview != null),
    );
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
        AppHelpers.showCheckTopSnackBar(
          context,
          text: fail,
          type: SnackBarType.error,
        );
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
        (value) => list,
      );
    } else {
      List<String> list = [state.title, state.description];
      temp[state.language?.locale ??
              LocalStorage.getLanguage()?.locale ??
              "en"] =
          list;
    }
    state = state.copyWith(mapOfDesc: temp);
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

  void setTitleTranslations(Map<String, String> translations) {
    state = state.copyWith(titleTranslations: translations);
    final currentLang = LocalStorage.getLanguage()?.locale ?? 'en';
    if (translations.containsKey(currentLang)) {
      state = state.copyWith(title: translations[currentLang]!);
    } else if (translations.isNotEmpty) {
      state = state.copyWith(title: translations.values.first);
    }
  }

  void setDescriptionTranslations(Map<String, String> translations) {
    state = state.copyWith(descriptionTranslations: translations);
    final currentLang = LocalStorage.getLanguage()?.locale ?? 'en';
    if (translations.containsKey(currentLang)) {
      state = state.copyWith(description: translations[currentLang]!);
    } else if (translations.isNotEmpty) {
      state = state.copyWith(description: translations.values.first);
    }
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
    state = state.copyWith(
      product: product,
      listOfUrls: product?.galleries ?? [],
      images: [],
      minQty: product?.minQty.toString() ?? '',
      maxQty: product?.maxQty.toString() ?? '',
      tax: product?.tax == null ? '' : (product?.tax.toString() ?? ''),
      interval: product?.interval == null
          ? ''
          : (product?.interval.toString() ?? ''),
      title: product?.translation?.title ?? '',
      description: product?.translation?.description ?? '',
      barcode: product?.barCode ?? '',
      active: product?.active ?? false,
      titleTranslations: {},
      descriptionTranslations: {},
    );
    _oldBarcode = product?.barCode;
    getProductDetailsById(product?.uuid ?? '');
  }

  Future<void> getProductDetailsById(String productId) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.getProductDetails(productId);
    response.when(
      success: (data) async {
        state = state.copyWith(
          product: data.data,
          isLoading: false,
          listOfUrls: data.data?.galleries ?? [],
        );
        if (data.data?.translations != null) {
          Map<String, List<String>> temp = Map.from(state.mapOfDesc);
          Map<String, String> titleTranslations = {};
          Map<String, String> descriptionTranslations = {};
          var items = data.data?.translations;
          for (int i = 0; i < data.data!.translations!.length; i++) {
            final locale = items?[i].locale ?? "en";
            temp[locale] = [items?[i].title ?? '', items?[i].description ?? ''];
            titleTranslations[locale] = items?[i].title ?? '';
            descriptionTranslations[locale] = items?[i].description ?? '';
          }
          state = state.copyWith(
            mapOfDesc: temp,
            titleTranslations: titleTranslations,
            descriptionTranslations: descriptionTranslations,
          );
        }
      },
      failure: (failure, s) {
        debugPrint('==> get product details failure: $failure');
      },
    );
  }
}

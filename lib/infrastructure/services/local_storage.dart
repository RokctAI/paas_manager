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

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manager/infrastructure/models/models.dart';

import 'storage_keys.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  LocalStorage._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String? token) async {
    if (_preferences != null) {
      await _preferences!.setString(StorageKeys.keyToken, token ?? '');
    }
  }

  static Future<void> setAddressSelected(AddressData data) async {
    if (_preferences != null) {
      await _preferences!
          .setString(StorageKeys.keyAddressSelected, jsonEncode(data.toJson()));
    }
  }

  static AddressData? getAddressSelected() {
    String dataString =
        _preferences?.getString(StorageKeys.keyAddressSelected) ?? "";
    if (dataString.isNotEmpty) {
      AddressData data = AddressData.fromJson(jsonDecode(dataString));
      return data;
    } else {
      return null;
    }
  }

  static Future<void> setWalletData(Wallet? wallet) async {
    if (_preferences != null) {
      final String walletString = jsonEncode(wallet?.toJson());
      await _preferences!.setString(StorageKeys.keyWalletData, walletString);
    }
  }

  static String getToken() =>
      _preferences?.getString(StorageKeys.keyToken) ?? '';

  static void _deleteToken() => _preferences?.remove(StorageKeys.keyToken);

  static Future<void> setLanguageSelected(bool selected) async {
    if (_preferences != null) {
      await _preferences!.setBool(StorageKeys.keyLangSelected, selected);
    }
  }

  static bool getLanguageSelected() =>
      _preferences?.getBool(StorageKeys.keyLangSelected) ?? false;

  static Future<void> setSettingsList(List<SettingsData> settings) async {
    if (_preferences != null) {
      final List<String> strings =
          settings.map((setting) => jsonEncode(setting.toJson())).toList();
      await _preferences!.setStringList(StorageKeys.keyGlobalSettings, strings);
    }
  }

  static List<SettingsData> getSettingsList() {
    final List<String> settings =
        _preferences?.getStringList(StorageKeys.keyGlobalSettings) ?? [];
    final List<SettingsData> settingsList = settings
        .map(
          (setting) => SettingsData.fromJson(jsonDecode(setting)),
        )
        .toList();
    return settingsList;
  }

  static Future<void> setTranslations(
      Map<String, dynamic>? translations) async {
    if (_preferences != null) {
      final String encoded = jsonEncode(translations);
      await _preferences!.setString(StorageKeys.keyTranslations, encoded);
    }
  }

  static Map<String, dynamic> getTranslations() {
    final String encoded =
        _preferences?.getString(StorageKeys.keyTranslations) ?? '';
    if (encoded.isEmpty) {
      return {};
    }
    final Map<String, dynamic> decoded = jsonDecode(encoded);
    return decoded;
  }

  static Future<void> setAppThemeMode(bool isDarkMode) async {
    if (_preferences != null) {
      await _preferences!.setBool(StorageKeys.keyAppThemeMode, isDarkMode);
    }
  }

  static bool getAppThemeMode() =>
      _preferences?.getBool(StorageKeys.keyAppThemeMode) ?? false;

  static Future<void> setLanguageData(LanguageData? langData) async {
    if (_preferences != null) {
      final String lang = jsonEncode(langData?.toJson());
      await _preferences!.setString(StorageKeys.keyLanguageData, lang);
    }
  }

  static LanguageData? getLanguage() {
    final lang = _preferences?.getString(StorageKeys.keyLanguageData);
    if (lang == null) {
      return null;
    }
    final map = jsonDecode(lang);
    if (map == null) {
      return null;
    }
    return LanguageData.fromJson(map);
  }

  static Future<void> setLangLtr(bool? backward) async {
    if (_preferences != null) {
      await _preferences!.setBool(StorageKeys.keyLangLtr, backward ?? false);
    }
  }

  static bool getLangLtr() =>
      !(_preferences?.getBool(StorageKeys.keyLangLtr) ?? false);

  static Future<void> setSelectedCurrency(CurrencyData? currency) async {
    if (_preferences != null) {
      final String currencyString = jsonEncode(currency?.toJson());
      await _preferences!
          .setString(StorageKeys.keySelectedCurrency, currencyString);
    }
  }

  static CurrencyData? getSelectedCurrency() {
    final savedString =
        _preferences?.getString(StorageKeys.keySelectedCurrency);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return CurrencyData.fromJson(map);
  }

  static Future<void> setUser(UserData? user) async {
    if (_preferences != null) {
      final String userString = user != null ? jsonEncode(user.toJson()) : '';
      await _preferences!.setString(StorageKeys.keyUser, userString);
    }
  }

  static UserData? getUser() {
    final savedString = _preferences?.getString(StorageKeys.keyUser);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return UserData.fromJson(map);
  }

  static void _deleteUser() => _preferences?.remove(StorageKeys.keyUser);

  static Future<void> setWallet(Wallet? wallet) async {
    if (_preferences != null) {
      final String walletString =
          wallet != null ? jsonEncode(wallet.toJson()) : '';
      await _preferences!.setString(StorageKeys.keyWallet, walletString);
    }
  }

  static Wallet? getWallet() {
    final savedString = _preferences?.getString(StorageKeys.keyWallet);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return Wallet.fromJson(map);
  }

  static void _deleteWallet() => _preferences?.remove(StorageKeys.keyWallet);

  static Future<void> setShop(ShopData? shop) async {
    if (_preferences != null) {
      final String shopString = shop != null ? jsonEncode(shop.toJson()) : '';
      await _preferences!.setString(StorageKeys.keyShop, shopString);
    }
  }

  static ShopData? getShop() {
    final savedString = _preferences?.getString(StorageKeys.keyShop);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return ShopData.fromJson(map);
  }

  static void _deleteShop() => _preferences?.remove(StorageKeys.keyShop);

  static Future<void> setSystemLanguage(LanguageData? lang) async {
    if (_preferences != null) {
      final String langString = jsonEncode(lang?.toJson());
      await _preferences!.setString(StorageKeys.keySystemLanguage, langString);
    }
  }

  static LanguageData? getSystemLanguage() {
    final lang = _preferences?.getString(StorageKeys.keySystemLanguage);
    if (lang == null) {
      return null;
    }
    final map = jsonDecode(lang);
    if (map == null) {
      return null;
    }
    return LanguageData.fromJson(map);
  }

  static void logout() {
    _deleteToken();
    _deleteUser();
    _deleteWallet();
    _deleteShop();
  }
}

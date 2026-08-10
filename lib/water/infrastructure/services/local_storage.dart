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

// lib/water/infrastructure/services/local_storage.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../infrastructure/services/storage_keys.dart';
import '../../../infrastructure/services/local_storage.dart' as MainLocalStorage;
import '../../models/meter_reading.dart';
import '../../models/shop.dart';

class LocalStorage {
  static Future<void> saveWaterMeterReading(MeterReading reading) async {
    final prefs = await SharedPreferences.getInstance();
    final readings = await getWaterMeterReadings();
    readings.add(reading);
    await prefs.setString(StorageKeys.keyWaterMeterReadings, jsonEncode(readings.map((r) => r.toJson()).toList()));
  }

  static Future<List<MeterReading>> getWaterMeterReadings() async {
    final prefs = await SharedPreferences.getInstance();
    final readingsJson = prefs.getString(StorageKeys.keyWaterMeterReadings);
    if (readingsJson != null) {
      final List<dynamic> decodedReadings = jsonDecode(readingsJson);
      return decodedReadings.map((json) => MeterReading.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  static Future<void> saveWaterRate(double rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(StorageKeys.keyWaterRate, rate);
  }

  static Future<double> getWaterRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(StorageKeys.keyWaterRate) ?? 1.0;
  }

  static Future<void> setSelectedShop(Shop shop) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_shop', json.encode(shop.toJson()));
  }

  static Future<Shop?> getSelectedShop() async {
    final prefs = await SharedPreferences.getInstance();
    final shopJson = prefs.getString('selected_shop');
    if (shopJson != null) {
      return Shop.fromJson(json.decode(shopJson));
    }
    return null;
  }

  static String getFirstName() {
    return MainLocalStorage.LocalStorage.getFirstName();
  }

  static String getLastName() {
    return MainLocalStorage.LocalStorage.getLastName();
  }

  static String getUserId() {
    return MainLocalStorage.LocalStorage.getUserId().toString();
  }

  static String getToken() {
    return MainLocalStorage.LocalStorage.getToken();
  }

  static bool getAppThemeMode() {
    return MainLocalStorage.LocalStorage.getAppThemeMode();
  }
}
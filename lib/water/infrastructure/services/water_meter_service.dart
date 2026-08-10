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

import 'dart:io';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import '../../models/meter_reading.dart';
import '../../models/store_info.dart';

import '../../../app_constants.dart';

class WaterMeterService {
  static const String _readingsKey = 'water_meter_readings';
  static const String _storeInfoKey = 'store_info';
  static const String _unsentReadingsKey = 'unsent_readings';
  static final String _apiUrl = '${AppConstants.baseUrl}/api/v1/rest/water';

  Future<String?> detectMeterId(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String? meterId;
    for (TextBlock block in recognizedText.blocks) {
      final match = RegExp(r'\b211090986\b').firstMatch(block.text);
      if (match != null) {
        meterId = match.group(0);
        break;
      }
    }

    await textRecognizer.close();
    return meterId;
  }

  Future<int?> detectReading(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String? readingStr;
    for (TextBlock block in recognizedText.blocks) {
      final match = RegExp(r'\b\d{8}\b').firstMatch(block.text);
      if (match != null) {
        readingStr = match.group(0);
        break;
      }
    }

    await textRecognizer.close();

    if (readingStr != null) {
      return int.tryParse(readingStr);
    }
    return null;
  }

  Future<void> saveStoreInfo(StoreInfo storeInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storeInfoKey, jsonEncode(storeInfo.toJson()));
  }

  Future<StoreInfo?> getStoreInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final storeInfoString = prefs.getString(_storeInfoKey);
    if (storeInfoString != null) {
      final storeInfoJson = jsonDecode(storeInfoString);
      return StoreInfo.fromJson(storeInfoJson);
    }
    return null;
  }

  Future<void> saveReading(MeterReading reading) async {
    final prefs = await SharedPreferences.getInstance();
    final readings = await getReadings();
    readings.add(reading);
    await prefs.setString(_readingsKey, jsonEncode(readings.map((r) => r.toJson()).toList()));

    // Add to unsent readings queue
    final unsentReadings = await getUnsentReadings();
    unsentReadings.add(reading);
    await prefs.setString(_unsentReadingsKey, jsonEncode(unsentReadings.map((r) => r.toJson()).toList()));
  }

  Future<List<MeterReading>> getReadings() async {
    final prefs = await SharedPreferences.getInstance();
    final readingsString = prefs.getString(_readingsKey);
    if (readingsString != null) {
      final List<dynamic> decodedList = jsonDecode(readingsString);
      return decodedList.map((json) => MeterReading.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<MeterReading>> getUnsentReadings() async {
    final prefs = await SharedPreferences.getInstance();
    final unsentReadingsString = prefs.getString(_unsentReadingsKey);
    if (unsentReadingsString != null) {
      final List<dynamic> decodedList = jsonDecode(unsentReadingsString);
      return decodedList.map((json) => MeterReading.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> clearTodayReadings() async {
    final prefs = await SharedPreferences.getInstance();
    final readings = await getReadings();
    final today = DateTime.now();
    final filteredReadings = readings.where((reading) =>
    reading.timestamp.year != today.year ||
        reading.timestamp.month != today.month ||
        reading.timestamp.day != today.day
    ).toList();
    await prefs.setString(_readingsKey, jsonEncode(filteredReadings.map((r) => r.toJson()).toList()));

    // Also clear today's readings from unsent readings
    final unsentReadings = await getUnsentReadings();
    final filteredUnsentReadings = unsentReadings.where((reading) =>
    reading.timestamp.year != today.year ||
        reading.timestamp.month != today.month ||
        reading.timestamp.day != today.day
    ).toList();
    await prefs.setString(_unsentReadingsKey, jsonEncode(filteredUnsentReadings.map((r) => r.toJson()).toList()));
  }

  Future<bool> sendReadingsToApi() async {
    try {
      final deviceInfo = await _getDeviceInfo();
      final packageInfo = await PackageInfo.fromPlatform();
      final storeInfo = await getStoreInfo();

      if (storeInfo == null) {
        throw Exception('Store information not set');
      }

      final unsentReadings = await getUnsentReadings();
      if (unsentReadings.isEmpty) {
        return true; // No readings to send
      }

      // Sort readings by timestamp
      unsentReadings.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      final List<Map<String, dynamic>> consumptionPeriods = [];
      for (int i = 0; i < unsentReadings.length - 1; i++) {
        final openReading = unsentReadings[i];
        final closeReading = unsentReadings[i + 1];
        final consumptionLiters = closeReading.reading - openReading.reading;
        final consumptionM3 = consumptionLiters / 1000;

        consumptionPeriods.add({
          "meter_id": openReading.meterId,
          "open_reading": {
            "timestamp": openReading.timestamp.toUtc().toIso8601String(),
            "value": openReading.reading
          },
          "close_reading": {
            "timestamp": closeReading.timestamp.toUtc().toIso8601String(),
            "value": closeReading.reading
          },
          "consumption_liters": consumptionLiters,
          "consumption_m3": consumptionM3,
        });
      }

      final Map<String, dynamic> requestBody = {
        "store_name": storeInfo.storeName,
        "branch": storeInfo.branch,
        "consumption_periods": consumptionPeriods,
        "device_id": deviceInfo,
        "app_version": packageInfo.version,
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Consumption periods sent successfully');
        // Clear sent readings from the queue
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_unsentReadingsKey);
        return true;
      } else {
        print('Failed to send consumption periods. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending consumption periods to API: $e');
      return false;
    }
  }

  Future<String> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
    return 'unknown';
  }
}
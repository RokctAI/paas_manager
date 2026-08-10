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

// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:venderfoodyman/application/providers/app_providers.dart';

import '../app_constants.dart';

class AppInitializer extends StatefulWidget {
  final ProviderContainer providerContainer;

  const AppInitializer({super.key, required this.providerContainer});

  Future<void> initializeApp() async {
    await initializeRemoteConfigWithoutAPICall();
    await checkAppStatusFromAPI();
  }

  Future<void> initializeRemoteConfigWithoutAPICall() async {
    final initializer = _AppInitializerState(providerContainer);
    await initializer._initializeRemoteConfigWithoutAPICall();
  }

  Future<void> checkAppStatusFromAPI() async {
    final initializer = _AppInitializerState(providerContainer);
    //await initializer._checkAppStatusFromAPI();
  }

  @override
  _AppInitializerState createState() => _AppInitializerState(providerContainer);
}

class _AppInitializerState extends State<AppInitializer> {
  final ProviderContainer providerContainer;

  _AppInitializerState(this.providerContainer);

  @override
  void initState() {
    super.initState();
    print('AppInitializer initState');
  }

  Future<void> _initializeRemoteConfigWithoutAPICall() async {
    final String tenantSite = AppConstants.baseUrl;
    const String controlPanelUrl = "https://platform.rokct.ai";

    print('Starting Remote Config initialization (Custom API)');

    try {
      print('Fetching Remote Config values...');
      final response = await http.get(Uri.parse('$tenantSite/api/method/paas.api.get_remote_config?app_type=Manager'));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final config = responseData['message'];

        if (config != null) {
            String? getString(String key) => config[key]?.toString();
            bool? getBool(String key) => config[key] == 1 || config[key] == true || config[key] == "true";
            double? getDouble(String key) => double.tryParse(config[key]?.toString() ?? "");

            if (getString('adminPageUrl') != null) AppConstants.adminPageUrl = getString('adminPageUrl')!;
            // AppConstants.baseUrl is not overwritten
            if (getString('chatGpt') != null) AppConstants.chatGpt = getString('chatGpt')!;
            if (getString('webUrl') != null) AppConstants.webUrl = getString('webUrl')!;
            if (getString('imageBaseUrl') != null) AppConstants.imageBaseUrl = getString('imageBaseUrl')!;

            /// auth phone fields
            if (getBool('isSpecificNumberEnabled') != null) AppConstants.isSpecificNumberEnabled = getBool('isSpecificNumberEnabled')!;
            if (getBool('isNumberLengthAlwaysSame') != null) AppConstants.isNumberLengthAlwaysSame = getBool('isNumberLengthAlwaysSame')!;
            if (getString('countryCodeISO') != null) AppConstants.countryCodeISO = getString('countryCodeISO')!;
            if (getBool('showFlag') != null) AppConstants.showFlag = getBool('showFlag')!;
            if (getBool('showArrowIcon') != null) AppConstants.showArrowIcon = getBool('showArrowIcon')!;

            if (getDouble('demoLatitude') != null) AppConstants.demoLatitude = getDouble('demoLatitude')!;
            if (getDouble('demoLongitude') != null) AppConstants.demoLongitude = getDouble('demoLongitude')!;

            print('Remote Config initialized successfully');
            // providerContainer.read(remoteConfigInitializedProvider.notifier).state = true;
        }
      } else {
          print('Failed to fetch remote config. Status: ${response.statusCode}');
          // providerContainer.read(remoteConfigInitializedProvider.notifier).state = false;
      }
    } catch (e) {
      print('Error initializing remote config: $e');
      // providerContainer.read(remoteConfigInitializedProvider.notifier).state = false;
    }
  }

  /* Future<void> _checkAppStatusFromAPI() async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.baseUrl}/public/api/v1/rest/status'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        AppConstants.isMaintain = data['status'] != 'OK';
      } else {
        AppConstants.isMaintain = true;
      }
    } on TimeoutException {
      AppConstants.isMaintain = true;
    } catch (e) {
      AppConstants.isMaintain = true;
      print('Error checking app status: $e');
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


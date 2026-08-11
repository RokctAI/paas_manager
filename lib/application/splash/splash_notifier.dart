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

import 'splash_state.dart';
import 'package:manager/domain/interface/interfaces.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  final SettingsInterface _settingsRepository;
  final UsersInterface _userRepository;

  SplashNotifier(this._settingsRepository, this._userRepository)
      : super(const SplashState());

  Future<void> fetchCurrencies() async {
    final response = await _settingsRepository.getCurrencies();
    response.when(
      success: (data) {
        int defaultCurrencyIndex = 0;
        final List<CurrencyData> currencies = data.data ?? [];
        for (int i = 0; i < currencies.length; i++) {
          if (currencies[i].isDefault ?? false) {
            defaultCurrencyIndex = i;
            break;
          }
        }
        LocalStorage.setSelectedCurrency(currencies[defaultCurrencyIndex]);
      },
      failure: (failure, status) {
        debugPrint('==> error with fetching currencies $failure');
      },
    );
  }

  Future<void> fetchProfileDetails({
    required VoidCallback? goMain,
    required VoidCallback? goBecome,
    required VoidCallback? goLogin,
  }) async {
    final response = await _userRepository.getProfileDetails();
    response.when(
      success: (data) {
        LocalStorage.setUser(data.data);
        if (data.data?.wallet != null) {
          LocalStorage.setWallet(data.data?.wallet);
        }
        if (data.data?.role == "seller") {
          goMain?.call();
        }else{
          goBecome?.call();
        }
      },
      failure: (failure, status) {
        if(status==401){
          goLogin?.call();
        }
        debugPrint('==> error with fetching profile $failure');
      },
    );
  }

  Future<void> fetchGlobalSettings() async {
    final response = await _settingsRepository.getGlobalSettings();
    response.when(
      success: (data) {
        LocalStorage.setSettingsList(data.data ?? []);
      },
      failure: (failure, status) {
        debugPrint('==> error with fetching settings $failure');
      },
    );
  }

  Future<void> getActiveLanguages(
    BuildContext context, {
    VoidCallback? goMain,
    VoidCallback? goLogin,
  }) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      if (LocalStorage.getToken().isEmpty) {
        goLogin?.call();
      } else {
        goMain?.call();
      }
    }
  }

  Future<void> fetchTranslations({
    VoidCallback? noConnection,
    VoidCallback? goMain,
    VoidCallback? goLogin,
    VoidCallback? goBecome,
  }) async {
    if (await AppConnectivity.connectivity()) {
      if (LocalStorage.getSettingsList().isEmpty) {
        final response = await _settingsRepository.getTranslations();
        response.when(
          success: (data) {
            LocalStorage.setTranslations(data.data);
          },
          failure: (failure, status) {
            debugPrint('==> error with fetching translations $failure');
          },
        );
        fetchGlobalSettings();
      }

      if (LocalStorage.getToken().isNotEmpty) {
        fetchProfileDetails(goMain: goMain, goBecome: goBecome, goLogin: goLogin);
      } else {
        goLogin?.call();
      }
      if (LocalStorage.getSelectedCurrency() == null) {
        fetchCurrencies();
      }
      if (LocalStorage.getSettingsList().isNotEmpty) {
        final response = await _settingsRepository.getTranslations();
        response.when(
          success: (data) {
            LocalStorage.setTranslations(data.data);
          },
          failure: (failure, status) {
            debugPrint('==> error with fetching translations $failure');
          },
        );
        fetchGlobalSettings();
      }
    } else {
      noConnection?.call();
    }
  }
}

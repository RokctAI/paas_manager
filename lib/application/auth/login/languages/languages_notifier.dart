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

import 'languages_state.dart';
import 'package:manager/domain/interface/interfaces.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

class LanguagesNotifier extends StateNotifier<LanguagesState> {
  final SettingsInterface _settingsRepository;

  LanguagesNotifier(this._settingsRepository) : super(const LanguagesState());

  Future<void> checkLanguage(BuildContext context) async {
    final lang = LocalStorage.getLanguage();
    if (lang == null) {
      state = state.copyWith(isSelectLanguage: false);
    } else {
      final connect = await AppConnectivity.connectivity();
      if (connect) {
        final response = await _settingsRepository.getLanguages();
        response.when(
          success: (data) {
            state = state.copyWith(languages: data.data ?? []);
            final List<LanguageData> languages = data.data ?? [];
            for (int i = 0; i < languages.length; i++) {
              if (languages[i].id == lang.id) {
                state = state.copyWith(
                  isSelectLanguage: true,
                );
                break;
              }
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isSelectLanguage: false);
            AppHelpers.showCheckTopSnackBar(
              context,
              text: AppHelpers.getTranslation(status.toString()),
            );
          },
        );
      } else {
        if (context.mounted) {
          AppHelpers.showNoConnectionSnackBar(context);
        }
      }
    }
  }

  void change(int index) {
    state = state.copyWith(index: index);
  }

  Future<void> getLanguages(BuildContext context) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      state = state.copyWith(isLoading: true);
      final response = await _settingsRepository.getLanguages();
      response.when(
        success: (data) {
          final List<LanguageData> languages = data.data ?? [];
          final lang = LocalStorage.getLanguage();
          int index = 0;
          for (int i = 0; i < languages.length; i++) {
            if (languages[i].id == lang?.id) {
              index = i;
              break;
            }
          }
          state = state.copyWith(
            isLoading: false,
            languages: data.data ?? [],
            index: index,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            text: AppHelpers.getTranslation(status.toString()),
          );
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  void makeSelectedLang({Function(LanguageData)? afterUpdate}) {
    LocalStorage.setLanguageSelected(true);
    LocalStorage.setLanguageData(state.languages[state.index]);
    LocalStorage.setLangLtr(state.languages[state.index].backward);
    getTranslations(
      afterUpdate: () {
        if (afterUpdate != null) {
          afterUpdate(state.languages[state.index]);
        }
      },
    );
  }

  Future<void> getTranslations({VoidCallback? afterUpdate}) async {
    state = state.copyWith(isLoading: true, isSelectLanguage: false);
    final response = await _settingsRepository.getTranslations();
    response.when(
      success: (data) {
        LocalStorage.setTranslations(data.data);
        if (afterUpdate != null) {
          afterUpdate();
        }
        state = state.copyWith(isLoading: false);
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
      },
    );
  }
}

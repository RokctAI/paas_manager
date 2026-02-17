import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'languages_state.dart';
import '../../../domain/interface/interfaces.dart';
import '../../../infrastructure/models/models.dart';
import '../../../infrastructure/services/services.dart';

class LanguagesNotifier extends StateNotifier<LanguagesState> {
  final SettingsRepository _settingsRepository;

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

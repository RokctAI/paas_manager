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

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'languages_state.freezed.dart';

@freezed
class LanguagesState with _$LanguagesState {
  const factory LanguagesState({
    @Default([]) List<LanguageData> languages,
    @Default(0) int index,
    @Default(true) bool isLoading,
    @Default(true) bool isSelectLanguage,
  }) = _LanguagesState;

  const LanguagesState._();
}

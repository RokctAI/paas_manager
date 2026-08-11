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
part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool isLoading,
    @Default(false) bool showPassword,
    @Default(true) bool isKeepLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isGoogleLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool showConfirmPassword,
    @Default(false) bool isEmailInvalid,
    @Default(false) bool isPasswordInvalid,
    @Default(false) bool isConfirmPasswordInvalid,
    @Default(false) bool isPhoneInvalid,
    @Default(false) bool isFirstNameInvalid,
    @Default(false) bool isSurNameInvalid,
    @Default('') String phone,
    @Default('') String verificationId,
    @Default('') String email,
    @Default('') String referral,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String password,
    @Default('') String confirmPassword,
  }) = _SignUpState;

  const SignUpState._();
}

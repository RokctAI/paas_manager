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
import 'package:firebase_messaging/firebase_messaging.dart';

import 'login_state.dart';
import 'package:venderfoodyman/domain/interface/interfaces.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthInterface _authRepository;
  final UsersInterface _userRepository;
  String _email = '';
  String _password = '';

  LoginNotifier(this._authRepository, this._userRepository)
      : super(const LoginState());


  Future<void> getProfileDetails() async {
    final response = await _userRepository.getProfileDetails();
    response.when(
      success: (data) {
        LocalStorage.setUser(data.data);
        if (data.data?.wallet != null) {
          LocalStorage.setWallet(data.data?.wallet);
        }
      },
      failure: (failure,status) {
        debugPrint('==> get profile details failure: $failure');
      },
    );
  }

  void setPassword(String text) {
    _password = text.trim();
    if (state.isLoginError) {
      state = state.copyWith(isLoginError: false);
    }
  }

  void setEmail(String text) {
    _email = text.trim();
    if (state.isLoginError) {
      state = state.copyWith(isLoginError: false);
    }
  }

  void toggleShowPassword() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  void toggleKeepLogin() {
    state = state.copyWith(isKeepLogin: !state.isKeepLogin);
  }

  Future<void> login({
    VoidCallback? checkYourNetwork,
    VoidCallback? loginSuccess,
    VoidCallback? seller,
    VoidCallback? admin,
    VoidCallback? accessDenied,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isLoading: true);
      final response =
      await _authRepository.login(email: _email, password: _password);
      response.when(
        success: (data) async {
          if (data.data?.user?.role == 'seller') {
            seller?.call();
          } else if (data.data?.user?.role == 'admin') {
            state = state.copyWith(isLoading: false);
            accessDenied?.call();
          } else {
            state = state.copyWith(isLoading: false);
            accessDenied?.call();
          }
          LocalStorage.setToken(data.data?.accessToken ?? '');
          loginSuccess?.call();
          getProfileDetails();
          String? fcmToken;
          try {
            fcmToken = await FirebaseMessaging.instance.getToken();
          } catch (e) {
            debugPrint('===> error with getting firebase token $e');
          }
          _userRepository.updateFirebaseToken(fcmToken);
          state = state.copyWith(isLoading: false);
        },
        failure: (failure,status) {
          debugPrint('===> login request failure $failure');
          state = state.copyWith(isLoading: false, isLoginError: true);
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}

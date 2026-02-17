import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

import 'login_state.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  String _email = '';
  String _password = '';

  LoginNotifier() : super(const LoginState());

  Future<void> getProfileDetails() async {
    final response = await usersRepository.getProfileDetails();
    response.when(
      success: (data) {
        LocalStorage.setUser(data.data);
        if (data.data?.wallet != null) {
          LocalStorage.setWallet(data.data?.wallet);
        }
      },
      failure: (failure, status) {
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
    required int index,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isLoading: true);
      final response = await authRepository.login(
        email: _email,
        password: _password,
      );
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
          usersRepository.updateFirebaseToken(fcmToken);
          state = state.copyWith(isLoading: false);
        },
        failure: (failure, status) {
          debugPrint('===> login request failure $failure');
          state = state.copyWith(isLoading: false, isLoginError: true);
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}

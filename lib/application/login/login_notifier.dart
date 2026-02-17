import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'login_state.dart';
import '../../domain/interface/interfaces.dart';
import '../../infrastructure/services/services.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;
  final UsersRepository _userRepository;
  String _email = '';
  String _password = '';

  LoginNotifier(this._authRepository, this._userRepository)
      : super(const LoginState());

  Future<void> loginWithGoogle({
    VoidCallback? checkYourNetwork,
    Function(String)? errorOccurred,
    VoidCallback? loginSuccess,
    VoidCallback? seller,
    VoidCallback? admin,
    VoidCallback? accessDenied,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isGoogleLoading: true);
      GoogleSignInAccount? googleUser;
      try {
        googleUser = await GoogleSignIn().signIn();
      } catch (e) {
        state = state.copyWith(isGoogleLoading: false);
        debugPrint('===> login with google exception: $e');
        if (errorOccurred != null) {
          errorOccurred(e.toString());
        }
        final GoogleSignIn signIn = GoogleSignIn();
        signIn.disconnect();
        signIn.signOut();
      }
      if (googleUser == null) {
        state = state.copyWith(isGoogleLoading: false);
        final GoogleSignIn signIn = GoogleSignIn();
        signIn.disconnect();
        signIn.signOut();
        return;
      }
      final response = await _authRepository.loginWithSocial(
        email: googleUser.email,
        displayName: googleUser.displayName,
        id: googleUser.id,
      );
      response.when(
        success: (data) async {
          if (data.data?.user?.role == 'seller') {
            state = state.copyWith(isGoogleLoading: false);
            seller?.call();
            String? fcmToken = await FirebaseMessaging.instance.getToken();
            _userRepository.updateFirebaseToken(fcmToken);
          } else {
            state = state.copyWith(isGoogleLoading: false);
            accessDenied?.call();
            final GoogleSignIn signIn = GoogleSignIn();
            signIn.disconnect();
            signIn.signOut();
            return;
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
        },
        failure: (failure,status) {
          debugPrint('===> login error google $failure');
          state = state.copyWith(isGoogleLoading: false);
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

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

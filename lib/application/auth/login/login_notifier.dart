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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'login_state.dart';
import 'package:manager/domain/interface/interfaces.dart';
import 'package:manager/infrastructure/services/services.dart';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:permission_handler/permission_handler.dart';

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
        failure: (failure, status) {
          debugPrint('===> login request failure $failure');
          state = state.copyWith(isLoading: false, isLoginError: true);
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> loginWithGoogle({
    VoidCallback? checkYourNetwork,
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
        debugPrint('===> google sign in exception: $e');
      }

      if (googleUser == null) {
        state = state.copyWith(isGoogleLoading: false);
        return;
      }

      final response = await _authRepository.loginWithGoogle(
        email: googleUser.email,
        displayName: googleUser.displayName ?? '',
        id: googleUser.id,
        avatar: googleUser.photoUrl ?? "",
      );

      response.when(
        success: (data) async {
          if (data.data?.user?.role == 'seller') {
            seller?.call();
          } else if (data.data?.user?.role == 'admin') {
            state = state.copyWith(isGoogleLoading: false);
            accessDenied?.call();
          } else {
            state = state.copyWith(isGoogleLoading: false);
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
          state = state.copyWith(isGoogleLoading: false);
        },
        failure: (failure, status) {
          debugPrint('===> google login request failure $failure');
          state = state.copyWith(isGoogleLoading: false, isLoginError: true);
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> loginWithFacebook({
    VoidCallback? checkYourNetwork,
    VoidCallback? loginSuccess,
    VoidCallback? seller,
    VoidCallback? admin,
    VoidCallback? accessDenied,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isLoading: true);
      final fb = FacebookAuth.instance;
      try {
        TrackingStatus? status;
        if (Platform.isIOS) {
          final permission = await Permission.appTrackingTransparency.request();
          status = await AppTrackingTransparency.trackingAuthorizationStatus;
          debugPrint("permission $permission");
          debugPrint("status: $status");
        }

        final user = await fb.login(
          loginTracking: status == TrackingStatus.authorized
              ? LoginTracking.enabled
              : LoginTracking.limited,
          loginBehavior: LoginBehavior.nativeWithFallback,
        );

        debugPrint('===> login with facebook token ${user.accessToken?.tokenString}');
        debugPrint('===> login with facebook status ${user.status}');

        final rawNonce = AppHelpers.generateNonce();
        final OAuthCredential credential =
        user.accessToken?.type == AccessTokenType.limited
            ? OAuthCredential(
          providerId: 'facebook.com',
          signInMethod: 'oauth',
          idToken: user.accessToken!.tokenString,
          rawNonce: rawNonce,
        )
            : FacebookAuthProvider.credential(
            user.accessToken?.tokenString ?? "");

        final userObj =
        await FirebaseAuth.instance.signInWithCredential(credential);

        if (user.status == LoginStatus.success) {
          final response = await _authRepository.loginWithGoogle(
            email: userObj.user?.email ?? "",
            displayName: userObj.user?.displayName ?? "",
            id: userObj.user?.uid ?? "",
            avatar: userObj.user?.photoURL ?? "",
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
              _userRepository.updateFirebaseToken(fcmToken);
              state = state.copyWith(isLoading: false);
            },
            failure: (failure, status) {
              debugPrint('===> facebook login request failure $failure');
              state = state.copyWith(isLoading: false, isLoginError: true);
            },
          );
        } else {
          state = state.copyWith(isLoading: false);
        }
      } catch (e) {
        state = state.copyWith(isLoading: false);
        debugPrint('===> login with facebook exception: $e');
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> loginWithApple({
    VoidCallback? checkYourNetwork,
    VoidCallback? loginSuccess,
    VoidCallback? seller,
    VoidCallback? admin,
    VoidCallback? accessDenied,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isLoading: true);

      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        OAuthProvider oAuthProvider = OAuthProvider("apple.com");
        final AuthCredential credentialApple = oAuthProvider.credential(
          idToken: credential.identityToken,
          accessToken: credential.authorizationCode,
        );

        final userObj =
        await FirebaseAuth.instance.signInWithCredential(credentialApple);

        final response = await _authRepository.loginWithGoogle(
          email: credential.email ?? userObj.user?.email ?? "",
          displayName: credential.givenName ?? userObj.user?.displayName ?? "",
          id: credential.userIdentifier ?? userObj.user?.uid ?? "",
          avatar: userObj.user?.photoURL ?? "",
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
            _userRepository.updateFirebaseToken(fcmToken);
            state = state.copyWith(isLoading: false);
          },
          failure: (failure, status) {
            debugPrint('===> apple login request failure $failure');
            state = state.copyWith(isLoading: false, isLoginError: true);
          },
        );
      } catch (e) {
        state = state.copyWith(isLoading: false);
        debugPrint('===> login with apple exception: $e');
      }
    } else {
      checkYourNetwork?.call();
    }
  }
}
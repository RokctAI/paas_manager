import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    @Default(false) bool showPassword,
    @Default(true) bool isKeepLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isGoogleLoading,
    @Default(false) bool isEmailNotValid,
    @Default(false) bool isPhoneNotValid,
    @Default(false) bool isPasswordNotValid,
  }) = _LoginState;

  const LoginState._();
}

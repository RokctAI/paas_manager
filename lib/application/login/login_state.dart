import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    @Default(false) bool showPassword,
    @Default(true) bool isKeepLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isGoogleLoading,
  }) = _LoginState;

  const LoginState._();
}

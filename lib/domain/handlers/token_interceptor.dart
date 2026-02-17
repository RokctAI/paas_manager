import 'package:dio/dio.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';

class TokenInterceptor extends Interceptor {
  final bool requireAuth;
  final bool chatGPT;

  TokenInterceptor({
    required this.requireAuth,
    this.chatGPT = false,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String token = LocalStorage.getToken();
    if (token.isNotEmpty && requireAuth) {
      options.headers.addAll({'Authorization': 'Bearer ${chatGPT ? AppConstants.chatGpt : token}'});
    }
    handler.next(options);
  }
}

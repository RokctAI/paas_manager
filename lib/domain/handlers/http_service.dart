import 'package:dio/dio.dart';

import 'token_interceptor.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class HttpService {
  Dio client({bool requireAuth = false,bool chatGpt = false}) => Dio(
        BaseOptions(
          baseUrl: chatGpt ? "https://api.openai.com" : AppConstants.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json'
          },
        ),
      )
        ..interceptors.add(TokenInterceptor(requireAuth: requireAuth,chatGPT: chatGpt))
        ..interceptors
            .add(LogInterceptor(requestBody: true, responseBody: true));
}

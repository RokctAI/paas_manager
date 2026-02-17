import 'package:dio/dio.dart';

import 'token_interceptor.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class HttpService {
  Dio client({bool requireAuth = false}) =>
      Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              'Accept': 'application/json',
              'Content-type': 'application/json',
            },
          ),
        )
        ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
        ..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
}

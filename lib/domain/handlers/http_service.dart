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

import 'package:dio/dio.dart';

import 'token_interceptor.dart';
import 'package:manager/infrastructure/services/services.dart';

class HttpService {
  Dio client({bool requireAuth = false, bool chatGpt = false}) => Dio(
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
        ..interceptors
            .add(TokenInterceptor(requireAuth: requireAuth, chatGPT: chatGpt))
        ..interceptors
            .add(LogInterceptor(requestBody: true, responseBody: true));
}

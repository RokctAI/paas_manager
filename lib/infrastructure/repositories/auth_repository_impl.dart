import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import '../models/data/user.dart';
import '../models/models.dart';
import '../../domain/di/injection.dart';
import '../../domain/handlers/handlers.dart';
import '../../domain/interface/interfaces.dart';
import '../models/request/sign_up_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final data = {
      if (AppValidators.isValidEmail(email)) 'email': email,
      if (!AppValidators.isValidEmail(email)) 'phone': email.replaceAll("+", ""),
      'password': password
    };
    debugPrint('===> login request $data');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/login',
        data: data,
      );
      return ApiResult.success(
        data: LoginResponse.fromJson(response.data),
      );
    } catch (e,s) {
      debugPrint('==> login failure: $e,$s');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<LoginResponse>> loginWithSocial({
    String? email,
    String? displayName,
    String? id,
  }) async {
    final data = {
      if (email != null) 'email': email,
      if (displayName != null) 'name': displayName,
      if (id != null) 'id': id,
    };
    debugPrint('===> login request ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/google/callback',
        data: data,
      );
      return ApiResult.success(data: LoginResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> login with google failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<RegisterResponse>> sendOtp({required String phone}) async {
    final data = {'phone': phone.replaceAll("+", "")};
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/register',
        data: data,
      );
      return ApiResult.success(data: RegisterResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> send otp failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<VerifyPhoneResponse>> verifyPhone({
    required String verifyId,
    required String verifyCode,
  }) async {
    final data = {'verifyId': verifyId, 'verifyCode': verifyCode};
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/verify/phone',
        data: data,
      );
      return ApiResult.success(
        data: VerifyPhoneResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> verify phone failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<RegisterResponse>> forgotPassword({
    required String email,
  }) async {
    final data = {'email': email.replaceAll("+", "")};
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/forgot/email-password',
        queryParameters: data,
      );
      return ApiResult.success(data: RegisterResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> forgot password failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<VerifyData>> forgotPasswordConfirm({
    required String verifyCode,
    required String email,
  }) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/forgot/email-password/$verifyCode?email=${email.replaceAll("+", "")}',
      );

      return ApiResult.success(
        data: VerifyData.fromJson(response.data["data"]),
      );
    } catch (e) {
      debugPrint('==> forgot password confirm failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<VerifyData>> forgotPasswordConfirmWithPhone({
    required String phone,
  }) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('/api/v1/auth/forgot/password/confirm',
          data: {"phone": phone.replaceAll("+", ""), "type": "firebase"});

      return ApiResult.success(
        data: VerifyData.fromJson(response.data["data"]),
      );
    } catch (e) {
      debugPrint('==> forgot password confirm failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<VerifyPhoneResponse>> verifyEmail({
    required String verifyCode,
  }) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/auth/verify/$verifyCode',
      );
      return ApiResult.success(
          data: VerifyPhoneResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> verify email failure: $e');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<VerifyData>> sigUpWithData({required UserModel user}) async {
    final data = {
      "firstname": user.firstname,
      "lastname": user.lastname,
      "phone": user.phone?.replaceAll("+", ""),
      "email": user.email,
      "password": user.password,
      "password_conformation": user.conPassword,
      if (user.referral?.isNotEmpty ?? false) 'referral': user.referral
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      var res = await client.post(
        '/api/v1/auth/after-verify',
        data: data,
      );
      return ApiResult.success(
        data: VerifyData.fromJson(res.data["data"]),
      );
    } catch (e) {
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<VerifyData>> sigUpWithPhone(
      {required UserModel user}) async {
    final data = {
      "firstname": user.firstname,
      "lastname": user.lastname,
      "phone": user.phone?.replaceAll("+", ""),
      "email": user.email,
      "password": user.password,
      "password_conformation": user.conPassword,
      "type": "firebase",
      if (user.referral?.isNotEmpty ?? false) 'referral': user.referral
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      var res = await client.post(
        '/api/v1/auth/verify/phone',
        data: data,
      );
      return ApiResult.success(
        data: VerifyData.fromJson(res.data["data"]),
      );
    } catch (e) {
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> signUp({
    required String email,
  }) async {
    final data = SignUpRequest(
      email: email.replaceAll("+", ""),
    );
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      await client.post(
        '/api/v1/auth/register',
        queryParameters: data.toJson(),
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(data),
      );
    } catch (e) {
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CheckPhoneResponse>> checkPhone(
      {required String phone}) async {
    final data = {'phone': phone.replaceAll("+", "")};
    debugPrint('===> login request $data');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/check/phone',
        queryParameters: data,
      );
      return ApiResult.success(
          data: CheckPhoneResponse.fromJson(response.data));
    } catch (e, s) {
      debugPrint('==> check phone failure: $e, $s');
      return ApiResult.failure(
           error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}

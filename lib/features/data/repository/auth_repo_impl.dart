import 'dart:io';
import 'package:dio/dio.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';
import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/data/data_source/remote/auth/auth_api_service.dart';
import 'package:testtem/features/data/data_source/remote/payload/auth/login_req.dart';
import 'package:testtem/features/data/data_source/remote/payload/auth/register_req.dart';
import 'package:testtem/features/data/data_source/remote/payload/auth/reset_pass_req.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthApiService _authApiService;
  final StorageToken storageToken;
  const AuthRepoImpl(this._authApiService, this.storageToken);

  @override
  Future<DataState<void>> checkCodeReset(String code) async {
    try {
      final result = await _authApiService.checkCodeReset(code);
      if (result.response.statusCode == HttpStatus.ok) {
        return DataSuccess(null, result.data.message);
      } else {
        return DataFail(DioException(
            error: result.response.statusCode,
            requestOptions: result.response.requestOptions,
            response: result.response));
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }

  @override
  Future<DataState<String?>> forgotPassword(String email) async {
    try {
      final result = await _authApiService.forgotPassword(email);
      if (result.response.statusCode == HttpStatus.ok) {
        return DataSuccess(null, result.data.message);
      } else {
        return DataFail(DioException(
            requestOptions: result.response.requestOptions,
            response: result.response,
            error: result.response.statusCode));
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }

  @override
  Future<DataState<void>> login(String email, String password) async {
    try {
      final result = await _authApiService
          .login(LoginReq(email: email, password: password));
      if (result.response.statusCode == HttpStatus.ok) {
        storageToken.saveAccessToken(result.data.model!);
        return DataSuccess(null, result.data.message);
      } else {
        return DataFail(DioException(
            requestOptions: result.response.requestOptions,
            error: result.response.statusCode,
            response: result.response));
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }

  @override
  Future<DataState<void>> loginGG(String token) async {
    try {
      final result = await _authApiService.loginGG(token);
      if (result.response.statusCode == HttpStatus.ok) {
        storageToken.saveAccessToken(result.data.model!);
        return DataSuccess(null, result.data.message);
      } else {
        return DataFail(DioException(
            requestOptions: result.response.requestOptions,
            error: result.response.statusCode,
            response: result.response));
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }

  @override
  Future<DataState<void>> register(
      String name, String email, String password) async {
    try {
      final result = await _authApiService
          .register(RegisterReq(email: email, password: password));
      if (result.response.statusCode == HttpStatus.ok) {
        return DataSuccess(null, result.data.message);
      } else {
        return DataFail(DioException(
            requestOptions: result.response.requestOptions,
            error: result.response.statusCode,
            response: result.response));
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }

  @override
  Future<DataState<void>> resetPassword(String code, String newPassword) async {
    try {
      final result = await _authApiService
          .resetPassword(ResetPassReq(code: code, newPassword: newPassword));
      if (result.response.statusCode == HttpStatus.ok) {
        return DataSuccess(null, result.data.message);
      } else {
        return DataFail(DioException(
            requestOptions: result.response.requestOptions,
            error: result.response.statusCode,
            response: result.response));
      }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }
}

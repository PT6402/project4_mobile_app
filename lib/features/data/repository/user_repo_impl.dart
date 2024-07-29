import 'dart:io';
import 'package:dio/dio.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';
import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/data/data_source/remote/user/user_api_service.dart';
import 'package:testtem/features/domain/entities/user_entity.dart';
import 'package:testtem/features/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserApiService userApiService;
  final StorageToken storageToken;
  UserRepoImpl(this.userApiService, this.storageToken);

  @override
  Future<DataState<UserEntity>> getUser() async {
    try {
      final result = await userApiService.getUser();
      if (result.response.statusCode == HttpStatus.ok) {
        return DataSuccess(result.data.model, result.data.message);
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
  Future<DataState<void>> logout() async {
    try {
      final result = await userApiService.logout();
      storageToken.deleteAccessToken();
      if (result.response.statusCode == HttpStatus.ok) {
        return const DataSuccess(null, null);
      } else {
        return DataFail(DioException(
            requestOptions: result.response.requestOptions,
            error: result.response.statusCode,
            response: result.response));
      }
    } on DioException catch (e) {
      print("this error ${e.message}");
      return DataFail(e);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/features/core/http/auth_http.dart';
import 'package:testtem/features/data/data_source/remote/payload/result_dto.dart';
import 'package:testtem/features/data/model/user_model.dart';

part "user_api_service_impl.dart";

@RestApi(baseUrl: "$urlServer/api/v1/user")
abstract class UserApiService {
  factory UserApiService(AuthHttp authHttp, Dio dio) = _UserApiService;

  @GET("")
  Future<HttpResponse<ResultDto<UserModel>>> getUser();

  @GET("/logout")
  Future<HttpResponse> logout();
}

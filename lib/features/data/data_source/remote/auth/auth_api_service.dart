import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/features/data/data_source/remote/payload/auth/login_req.dart';
import 'package:testtem/features/data/data_source/remote/payload/auth/register_req.dart';
import 'package:testtem/features/data/data_source/remote/payload/auth/reset_pass_req.dart';
import 'package:testtem/features/data/data_source/remote/payload/result_dto.dart';

part 'auth_api_service_impl.dart';

@RestApi(baseUrl: "$urlServer/api/v1/auth")
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;
  @POST("/login")
  Future<HttpResponse<ResultDto<String?>>> login(@Body() LoginReq req);

  @POST("/register")
  Future<HttpResponse<ResultDto>> register(@Body() RegisterReq req);

  @POST("/loginGG")
  Future<HttpResponse<ResultDto<String?>>> loginGG(
      @Query("token") String token);

  //

  @GET("/forgot-password/{email}")
  Future<HttpResponse<ResultDto>> forgotPassword(@Path("email") String email);

  @POST("/reset-password")
  Future<HttpResponse<ResultDto>> resetPassword(@Body() ResetPassReq req);

  @POST("/check-code-reset")
  Future<HttpResponse<ResultDto>> checkCodeReset(@Query("code") String code);
}

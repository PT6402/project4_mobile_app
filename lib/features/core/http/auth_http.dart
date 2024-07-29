import 'package:cookie_jar/cookie_jar.dart';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';

class AuthHttp {
  final Dio dio;
  final StorageToken storageToken;
  final CookieJar cookieJar;
  AuthHttp(this.dio, this.storageToken, this.cookieJar) {
    dio.options.extra['withCredentials'] = true;
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        String? accessToken = await storageToken.getAccessToken();

        if (accessToken != null) {
          final expirationDate = JwtDecoder.getExpirationDate(accessToken);
          if (expirationDate.isBefore(DateTime.now())) {
            print("Access token is expired");
            await storageToken.deleteAccessToken();
            try {
              accessToken = await _refreshToken();
              options.headers['Authorization'] = 'Bearer $accessToken';
              // options.extra['withCredentials'] = true;
              return handler.resolve(await _retry(options));
            } catch (e) {
              return handler.reject(DioException(
                requestOptions: options,
                error: e,
                type: DioExceptionType.badResponse,
              ));
            }
          } else {
            print("Access token not expired");
            options.headers['Authorization'] = 'Bearer $accessToken';
            // options.extra['withCredentials'] = true;
          }
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        print("Request error: ${error.message}");
        handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  Future<String> _refreshToken() async {
    try {
      final response = await dio.post(
        '$urlServer/api/auth/refresh-token',
      );
      final newAccessToken = response.data['model'];
      await storageToken.saveAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      throw Exception("Failed to refresh token: $e");
    }
  }
}

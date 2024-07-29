// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _UserApiService implements UserApiService {
  _UserApiService(
    this.authHttp,
    this.dio, {
    this.baseUrl,
  }) {
    baseUrl ??= '$urlServer/api/v1/user';
  }
  final Dio dio;
  final AuthHttp authHttp;

  String? baseUrl;

  @override
  Future<HttpResponse<ResultDto<UserModel>>> getUser() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await authHttp.dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<ResultDto<UserModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              authHttp.dio.options,
              '',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              authHttp.dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = ResultDto<UserModel>.fromMap(
      _result.data!,
      UserModel.fromMap(_result.data!['model'] as Map<String, dynamic>),
    );
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse> logout() async {
    try {
      final _extra = <String, dynamic>{};
      final queryParameters = <String, dynamic>{};
      final _headers = <String, dynamic>{};
      const _data = null;

      final _result =
          await authHttp.dio.fetch<String>(_setStreamType<HttpResponse>(Options(
        method: 'GET',
        headers: _headers,
        extra: _extra,
      )
              .compose(
                authHttp.dio.options,
                '/logout',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                  baseUrl: _combineBaseUrls(
                authHttp.dio.options.baseUrl,
                baseUrl,
              ))));

      // Xử lý phản hồi kiểu chuỗi
      final responseData = _result.data;
      // print('Response data as String: $responseData');

      final httpResponse = HttpResponse(responseData, _result);
      return httpResponse;
    } on DioException catch (e) {
      print("This is error service: ${e}");
      return HttpResponse(null, Response(requestOptions: e.requestOptions));
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

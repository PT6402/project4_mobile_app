// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final String? message;
  final DioException? error;
  const DataState({this.data, this.error, this.message});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data, String? message)
      : super(data: data, message: message);
}

class DataFail<T> extends DataState<T> {
  const DataFail(DioException? error) : super(error: error);
}

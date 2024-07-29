import 'dart:convert';

class ResultDto<T> {
  T? model;
  String? message;
  bool? status;
  ResultDto({
    this.model,
    this.message,
    this.status,
  });

  ResultDto<T> copyWith({
    T? model,
    String? message,
    bool? status,
  }) {
    return ResultDto<T>(
      model: model ?? this.model,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'message': message,
      'status': status,
    };
  }

  factory ResultDto.fromMap(map, T? modelToMap) {
    return ResultDto<T>(
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      model: modelToMap ?? modelToMap,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultDto.fromJson(String source, dynamic model) =>
      ResultDto.fromMap(json.decode(source) as Map<String, T>, model);

  @override
  String toString() =>
      'ResultDto(model: $model, message: $message, status: $status)';
}

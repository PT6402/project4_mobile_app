// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetPassReq {
  String? code;
  String? newPassword;
  ResetPassReq({
    this.code,
    this.newPassword,
  });

  ResetPassReq copyWith({
    String? code,
    String? newPassword,
  }) {
    return ResetPassReq(
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'newPassword': newPassword,
    };
  }

  factory ResetPassReq.fromMap(Map<String, dynamic> map) {
    return ResetPassReq(
      code: map['code'] != null ? map['code'] as String : null,
      newPassword:
          map['newPassword'] != null ? map['newPassword'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPassReq.fromJson(String source) =>
      ResetPassReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResetPassReq(code: $code, newPassword: $newPassword)';
}

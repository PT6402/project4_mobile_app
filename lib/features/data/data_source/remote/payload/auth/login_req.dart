// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginReq {
  String? email;
  String? password;
  LoginReq({
    this.email,
    this.password,
  });

  LoginReq copyWith({
    String? email,
    String? password,
  }) {
    return LoginReq(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginReq.fromMap(Map<String, dynamic> map) {
    return LoginReq(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginReq.fromJson(String source) =>
      LoginReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginReq(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginReq other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}

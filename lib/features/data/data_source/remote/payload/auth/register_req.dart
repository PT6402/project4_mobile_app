// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterReq {
  String? name;
  String? email;
  String? password;
  RegisterReq({
    this.name,
    this.email,
    this.password,
  });

  RegisterReq copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return RegisterReq(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory RegisterReq.fromMap(Map<String, dynamic> map) {
    return RegisterReq(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterReq.fromJson(String source) =>
      RegisterReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegisterReq(name: $name, email: $email, password: $password)';
}

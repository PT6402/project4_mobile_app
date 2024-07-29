// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:testtem/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.name,
    super.email,
    super.role,
  });

  @override
  UserModel copyWith({
    String? name,
    String? email,
    String? role,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(name: $name, email: $email, role: $role)';
}

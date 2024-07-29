// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserEntity {
  String? name;
  String? email;
  String? role;
  UserEntity({
    this.name,
    this.email,
    this.role,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? role,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserEntity(name: $name, email: $email, role: $role)';
}

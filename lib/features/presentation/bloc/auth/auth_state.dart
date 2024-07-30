// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:testtem/features/domain/entities/user_entity.dart';

class AuthState {
  final String? email;
  final UserEntity? user;
  final bool? isLoading;
  final String? isError;

  const AuthState({
    this.isLoading,
    this.isError,
    this.user,
    this.email,
  });

  AuthState set({
    String? email,
    UserEntity? user,
    bool? isLoading,
    String? isError,
  }) {
    return AuthState(
      email: email ?? this.email,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

class GuestUserState extends AuthState {
  const GuestUserState();
}

class LoggedInState extends AuthState {
  const LoggedInState(UserEntity user) : super(user: user);
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}

class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

// check code reset
class CheckCodeSuccess extends AuthState {
  const CheckCodeSuccess();
}

class CheckCodeFail extends AuthState {
  const CheckCodeFail();
}

// reset password
class ResetPassSuccess extends AuthState {
  const ResetPassSuccess();
}

class ResetPassFail extends AuthState {
  const ResetPassFail();
}

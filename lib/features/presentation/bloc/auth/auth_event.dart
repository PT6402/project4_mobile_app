// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

abstract class AuthEvent {
  final dynamic params;
  final BuildContext? context;
  const AuthEvent({
    this.params,
    this.context,
  });
}

class LoginUser extends AuthEvent {
  const LoginUser(
      ({
        String email,
        String password,
      }) params,
      BuildContext context)
      : super(params: params, context: context);
}

class RegisterUser extends AuthEvent {
  const RegisterUser(
      ({
        String name,
        String email,
        String password,
      }) params,
      BuildContext context)
      : super(params: params, context: context);
}

class ForgotPasswordUser extends AuthEvent {
  const ForgotPasswordUser(String email, BuildContext context)
      : super(params: email, context: context);
}

class CheckCodeResetUser extends AuthEvent {
  const CheckCodeResetUser(String code, BuildContext context)
      : super(params: code, context: context);
}

class ResetPasswordUser extends AuthEvent {
  const ResetPasswordUser(
      ({String code, String newPassword}) params, BuildContext context)
      : super(params: params, context: context);
}

class LoginGGUser extends AuthEvent {
  const LoginGGUser(BuildContext context) : super(context: context);
}

class LogoutUser extends AuthEvent {
  const LogoutUser(BuildContext context) : super(context: context);
}

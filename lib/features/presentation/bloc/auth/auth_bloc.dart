// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/domain/usecases/auth/auth_forgot_pass_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_login_gg_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_login_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_register_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_reset_pass_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/check_code_reset_usecase.dart';
import 'package:testtem/features/domain/usecases/user/auth_logout_usecase.dart';
import 'package:testtem/features/domain/usecases/user/user_get_usecase.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUsecase login;
  final AuthRegisterUsecase register;
  final AuthForgotPassUsecase forgot;
  final AuthLoginGgUsecase loginGG;
  final CheckCodeResetUsecase checkCodeReset;
  final AuthResetPassUsecase resetPassword;
  final AuthLogoutUsecase logout;
  final UserGetUsecase user;
  final Logger logger = Logger();
  AuthBloc(
    this.login,
    this.register,
    this.forgot,
    this.loginGG,
    this.checkCodeReset,
    this.resetPassword,
    this.logout,
    this.user,
  ) : super(const GuestUserState()) {
    on<LoginUser>(onLogin);
    on<LoginGGUser>(onLoginGG);
    on<RegisterUser>(onRegister);
    on<ForgotPasswordUser>(onForgotPassword);
    on<CheckCodeResetUser>(onCheckCodeReset);
    on<ResetPasswordUser>(onResetPassword);
    on<LogoutUser>(onLogoutUser);
  }
  onLogin(LoginUser loginUser, Emitter<AuthState> emit) async {
    emit(state.set(isLoading: true, isError: null));
    try {
      var result = await login(params: loginUser.params);
      if (result is DataFail) {
        throw Exception(result.message);
      }
      if (result is DataSuccess) {
        var dataUser = await user();
        logger.i(dataUser.data);
        if (dataUser is DataFail) {
          throw Exception(result.message);
        } else {
          emit(LoggedInState(dataUser.data!));
        }
      }
    } on Exception catch (e) {
      logger.e(e);
      emit(state.set(isError: e.toString()));
    } finally {
      emit(state.set(isLoading: false));
    }
  }

  onLoginGG(LoginGGUser loginGGUser, Emitter<AuthState> emit) async {
    emit(state.set(isLoading: true, isError: null));
    try {
      var result = await loginGG();
      if (result is DataFail) {
        throw Exception(result.message);
      }
      if (result is DataSuccess) {
        var dataUser = await user();
        if (dataUser is DataFail) {
          throw Exception(result.message);
        } else {
          emit(LoggedInState(dataUser.data!));
        }
      }
    } on Exception catch (e) {
      logger.e(e);
      emit(state.set(isError: e.toString()));
    } finally {
      emit(state.set(isLoading: false));
    }
  }

  void onRegister(RegisterUser registerUser, Emitter<AuthState> emit) async {
    emit(state.set(isLoading: true, isError: null));
    try {
      var result = await register(params: registerUser.params);
      if (result is DataFail) {
        throw Exception(result.message);
      }
      if (result is DataSuccess) {
        registerUser.context!.pop();
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      emit(state.set(isError: e.toString()));
    } finally {
      emit(state.set(isLoading: false));
    }
  }

  void onCheckCodeReset(
      CheckCodeResetUser checkCodeResetUser, Emitter<AuthState> emit) async {
    emit(state.set(isLoading: true, isError: null));
    try {
      var result = await checkCodeReset(params: checkCodeResetUser.params);
      if (result is DataFail) {
        print(result.message);
        emit(const CheckCodeFail());
      }
      if (result is DataSuccess) {
        emit(state.set(code: checkCodeResetUser.params));
        print("ok");
        checkCodeResetUser.context!.pop();
        checkCodeResetUser.context!
            .pushNamed('resetPassword', pathParameters: {"isCode": "false"});
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      emit(state.set(isError: e.toString()));
    } finally {
      emit(state.set(isLoading: false));
    }
  }

  void onForgotPassword(
      ForgotPasswordUser forgotPasswordUser, Emitter<AuthState> emit) async {
    emit(state.set(isLoading: true, isError: null));
    try {
      var result = await forgot(params: forgotPasswordUser.params);
      if (result is DataFail) {
        print(result.message);
      }
      if (result is DataSuccess) {
        forgotPasswordUser.context!
            .pushNamed('resetPassword', pathParameters: {"isCode": "true"});
        print(result.message);
      }
    } on Exception catch (e) {
      logger.e(e);
      emit(state.set(isError: e.toString()));
    } finally {
      emit(state.set(isLoading: false));
    }
  }

  void onResetPassword(
      ResetPasswordUser resetPasswordUser, Emitter<AuthState> emit) async {
    var result = await resetPassword(params: resetPasswordUser.params);
    if (result is DataFail) {
      print(result.message);
    }
    if (result is DataSuccess) {
      resetPasswordUser.context!.pop();
      resetPasswordUser.context!.pop();
      print(result.message);
    }
  }

  void onLogoutUser(LogoutUser logoutUser, Emitter<AuthState> emit) async {
    var result = await logout();
    if (result is DataFail) {
      print(result);
    }
    if (result is DataSuccess) {
      emit(const GuestUserState());
    }
  }
}

import 'package:testtem/features/core/resource/data_state.dart';

abstract class AuthRepo {
  // remote
  Future<DataState<void>> login(String email, String password);
  Future<DataState<void>> loginGG(String token);

  Future<DataState<void>> register(String name, String email, String password);
  Future<DataState<void>> forgotPassword(String email);
  Future<DataState<void>> resetPassword(String code, String newPassword);
  Future<DataState<void>> checkCodeReset(String code);
}

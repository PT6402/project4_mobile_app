import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';

class AuthLoginGgUsecase implements Usecase<DataState<void>, void> {
  final AuthRepo authRepo;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  AuthLoginGgUsecase(this.authRepo);

  @override
  Future<DataState<void>> call({void params}) async {
    try {
      var acc = await googleSignIn.signIn();
      if (acc != null) {
        print(acc.email);
        var auth = await acc.authentication;
        print(auth.accessToken);
        return authRepo.loginGG(auth.accessToken!);
      } else {
        throw Exception("gg fail");
      }
    } on DioException catch (e) {
      return DataFail(e);
    } finally {
      await googleSignIn.signOut();
    }
  }
}

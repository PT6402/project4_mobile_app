import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';

class AuthResetPassUsecase
    implements Usecase<DataState<void>, ({String code, String newPassword})> {
  final AuthRepo authRepo;
  AuthResetPassUsecase(this.authRepo);

  @override
  Future<DataState<void>> call({({String code, String newPassword})? params}) {
    return authRepo.resetPassword(params!.code, params.newPassword);
  }
}

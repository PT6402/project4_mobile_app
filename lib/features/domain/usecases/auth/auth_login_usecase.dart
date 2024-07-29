import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';

class AuthLoginUsecase
    implements Usecase<DataState<void>, ({String email, String password})> {
  final AuthRepo authRepo;
  AuthLoginUsecase(this.authRepo);
  @override
  Future<DataState<void>> call({({String email, String password})? params}) {
    return authRepo.login(params!.email, params.password);
  }
}

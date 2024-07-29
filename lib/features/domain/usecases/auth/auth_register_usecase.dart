import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';

class AuthRegisterUsecase
    implements
        Usecase<DataState<void>,
            ({String name, String email, String password})> {
  final AuthRepo authRepo;
  AuthRegisterUsecase(this.authRepo);
  @override
  Future<DataState<void>> call(
      {({String name, String email, String password})? params}) {
    return authRepo.register(params!.name, params.email, params.password);
  }
}

import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/repository/user_repo.dart';

class AuthLogoutUsecase implements Usecase<DataState<void>, void> {
  final UserRepo userRepo;
  AuthLogoutUsecase(this.userRepo);
  @override
  Future<DataState<void>> call({void params}) {
    return userRepo.logout();
  }
}

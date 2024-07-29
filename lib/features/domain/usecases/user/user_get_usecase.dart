import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/entities/user_entity.dart';
import 'package:testtem/features/domain/repository/user_repo.dart';

class UserGetUsecase implements Usecase<DataState<UserEntity>, void> {
  final UserRepo userRepo;
  UserGetUsecase(this.userRepo);

  @override
  Future<DataState<UserEntity>> call({void params}) {
    return userRepo.getUser();
  }
}

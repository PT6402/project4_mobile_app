import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/core/usecase/usecase.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';

class CheckCodeResetUsecase implements Usecase<DataState<void>, String> {
  final AuthRepo authRepo;
  CheckCodeResetUsecase(this.authRepo);

  @override
  Future<DataState<void>> call({String? params}) {
    return authRepo.checkCodeReset(params!);
  }
}

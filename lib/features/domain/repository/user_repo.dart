import 'package:testtem/features/core/resource/data_state.dart';
import 'package:testtem/features/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<DataState<UserEntity>> getUser();
  Future<DataState<void>> logout();
}

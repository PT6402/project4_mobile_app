import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';
import 'package:testtem/features/core/http/auth_http.dart';
import 'package:testtem/features/data/data_source/remote/auth/auth_api_service.dart';
import 'package:testtem/features/data/data_source/remote/user/user_api_service.dart';
import 'package:testtem/features/data/repository/auth_repo_impl.dart';
import 'package:testtem/features/data/repository/user_repo_impl.dart';
import 'package:testtem/features/domain/repository/auth_repo.dart';
import 'package:testtem/features/domain/repository/user_repo.dart';
import 'package:testtem/features/domain/usecases/auth/auth_forgot_pass_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_login_gg_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_login_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_register_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/auth_reset_pass_usecase.dart';
import 'package:testtem/features/domain/usecases/auth/check_code_reset_usecase.dart';
import 'package:testtem/features/domain/usecases/user/auth_logout_usecase.dart';
import 'package:testtem/features/domain/usecases/user/user_get_usecase.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  final dio = Dio();
  final storageToken = StorageToken();
  final appDocDir = await getApplicationDocumentsDirectory();
  final cookieJar =
      PersistCookieJar(storage: FileStorage("${appDocDir.path}/cookies"));

  sl.registerSingleton<Dio>(dio);
  sl.registerSingleton<StorageToken>(storageToken);
  sl.registerSingleton<AuthHttp>(AuthHttp(dio, storageToken, cookieJar));

  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<UserApiService>(UserApiService(sl(), sl()));

  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl(), sl()));
  sl.registerSingleton<UserRepo>(UserRepoImpl(sl(), sl()));

  sl.registerSingleton<AuthLoginUsecase>(AuthLoginUsecase(sl()));
  sl.registerSingleton<AuthLoginGgUsecase>(AuthLoginGgUsecase(sl()));
  sl.registerSingleton<AuthRegisterUsecase>(AuthRegisterUsecase(sl()));
  sl.registerSingleton<AuthForgotPassUsecase>(AuthForgotPassUsecase(sl()));
  sl.registerSingleton<CheckCodeResetUsecase>(CheckCodeResetUsecase(sl()));
  sl.registerSingleton<AuthResetPassUsecase>(AuthResetPassUsecase(sl()));
  sl.registerSingleton<AuthLogoutUsecase>(AuthLogoutUsecase(sl()));

  sl.registerSingleton<UserGetUsecase>(UserGetUsecase(sl()));

  sl.registerFactory<AuthBloc>(
      () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
}

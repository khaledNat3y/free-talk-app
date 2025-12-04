import 'package:free_talk_app/features/auth/data/repo/auth_repo.dart';
import 'package:free_talk_app/features/auth/logic/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /// there is no API service yet,
  /// so when you create API service you can add object from it instead of ApiService() object in below comment
  // getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => AuthRepo());
  getIt.registerFactory(() => AuthCubit(getIt<AuthRepo>()));
}

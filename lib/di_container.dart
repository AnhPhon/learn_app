import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repository/danh_muc_tin_tuc_repository.dart';
import 'package:template/data/repository/thong_bao_repository.dart';
import 'package:template/data/repository/tin_tuc_repository.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerSingleton<DioClient>(DioClient());
  // sl.registerSingleton<FirebaseService>(FirebaseService());

  // Repository
  sl.registerLazySingleton(() => TinTucRepository());
  sl.registerLazySingleton(() => DanhMucTinTucRepository());
  // sl.registerLazySingleton(() => RegionRepo());
  // sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => ThongBaoRepository());

  // Provider
  // sl.registerFactory(() => RegionProvider());
  // sl.registerFactory(() => AuthProvider());

  // Provider
  sl.registerFactory(() => TinTucProvider());
  sl.registerFactory(() => DanhMucTinTucProvider());
  // sl.registerFactory(() => AuthProvider());
  sl.registerFactory(() => ThongBaoProvider());
}

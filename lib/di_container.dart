import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/region_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:template/utils/firebase_service.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/region_repo.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<FirebaseService>(FirebaseService());

  // Repository
  sl.registerLazySingleton(() => RegionRepo());

  // Provider
  sl.registerFactory(() => RegionProvider());



}

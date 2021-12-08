import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/helper/izi_network.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/value_global_notifier.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerSingleton<ValueGlobalNotifier>(ValueGlobalNotifier());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<IZISize>(IZISize());
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton(() => IZINetwork(sl()));
  sl.registerSingleton<DioClient>(DioClient());

  
}

import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repository/banner_repository.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/data/repository/category_news_repository.dart';
import 'package:template/data/repository/category_repository.dart';
import 'package:template/data/repository/context_repository.dart';
import 'package:template/data/repository/district_repository.dart';
import 'package:template/data/repository/image_repository.dart';
import 'package:template/data/repository/news_repository.dart';
import 'package:template/data/repository/order_item_repository.dart';
import 'package:template/data/repository/order_repository.dart';
import 'package:template/data/repository/personal_honor_repository.dart';
import 'package:template/data/repository/product_repository.dart';
import 'package:template/data/repository/province_repository.dart';
import 'package:template/data/repository/user_repository.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:template/utils/firebase_service.dart';
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
  // sl.registerLazySingleton(() => RegionRepo());
  sl.registerLazySingleton(() => CategoryRepository());
  sl.registerLazySingleton(() => CategoryNewsRepository());
  sl.registerLazySingleton(() => ProductRepository());
  sl.registerLazySingleton(() => NewsRepository());
  sl.registerLazySingleton(() => OrderItemRepository());
  sl.registerLazySingleton(() => OrderRepository());
  sl.registerLazySingleton(() => ProvinceRepository());
  sl.registerLazySingleton(() => DistrictRepository());
  sl.registerLazySingleton(() => UserRepository());
  sl.registerLazySingleton(() => ImageUpdateRepository());
  sl.registerLazySingleton(() => PersonalHonorRepository());
  sl.registerLazySingleton(() => BannerRepository());
  sl.registerLazySingleton(() => ContextRepository());
  // sl.registerLazySingleton(() => AuthRepository());

  // Provider
  // sl.registerFactory(() => RegionProvider());
  // sl.registerFactory(() => AuthProvider());

  // Provider
  // sl.registerFactory(() => AuthProvider());
}

import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repository/cong_viec_nhan_vien_repository.dart';
import 'package:template/data/repository/kho_hang_repository.dart';
import 'package:template/data/repository/san_pham_repository.dart';
import 'package:template/data/repository/thu_chi_nhan_vien_repository.dart';
import 'package:template/data/repository/tin_tuc_repository.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/provider/kho_hang_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';
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
  // sl.registerLazySingleton(() => RegionRepo());
  sl.registerLazySingleton(() => ThuChiNhanVienRepository());
  sl.registerLazySingleton(() => TinTucRepository());
  sl.registerLazySingleton(() => KhoHangRepository());
  sl.registerLazySingleton(() => SanPhamRepository());
  sl.registerLazySingleton(() => CongViecNhanVienRepository());

  // Provider
  // sl.registerFactory(() => RegionProvider());
  sl.registerFactory(() => ThuChiNhanVienProvider());
  sl.registerFactory(() => TinTucProvider());
  sl.registerFactory(() => KhoHangProvider());
  sl.registerFactory(() => SanPhamProvider());
  sl.registerFactory(() => CongViecNhanVienProvider());
  

  // Provider
  // sl.registerFactory(() => AuthProvider());
}

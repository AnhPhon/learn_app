import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repository/bao_cao_nhan_vien_repository.dart';
import 'package:template/data/repository/cham_cong_repository.dart';
import 'package:template/data/repository/danh_muc_tin_tuc_repository.dart';
import 'package:template/data/repository/du_an_nhan_vien_repository.dart';
import 'package:template/data/repository/phuong_xa_repository.dart';
import 'package:template/data/repository/quan_huyen_repository.dart';
import 'package:template/data/repository/cong_viec_nhan_vien_repository.dart';
import 'package:template/data/repository/danh_muc_san_pham_repository.dart';
import 'package:template/data/repository/danh_muc_tin_tuc_repository.dart';
import 'package:template/data/repository/don_dich_vu_repository.dart';
import 'package:template/data/repository/kho_hang_repository.dart';
import 'package:template/data/repository/san_pham_repository.dart';
import 'package:template/data/repository/tai_khoan_repository.dart';
import 'package:template/data/repository/thong_bao_repository.dart';
import 'package:template/data/repository/thu_chi_nhan_vien_repository.dart';
import 'package:template/data/repository/tin_tuc_repository.dart';
import 'package:template/data/repository/tinh_tp_repository.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/kho_hang_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
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

  // Repository
  sl.registerLazySingleton(() => TinTucRepository());
  sl.registerLazySingleton(() => DanhMucTinTucRepository());
  // sl.registerLazySingleton(() => RegionRepo());
  // sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => TinhTpRepository());
  sl.registerLazySingleton(() => QuanHuyenRepository());
  sl.registerLazySingleton(() => PhuongXaRepository());
  sl.registerLazySingleton(() => ChamCongRepository());
  sl.registerLazySingleton(() => SanPhamRepository());
  sl.registerLazySingleton(() => DonDichVuRepository());
  sl.registerLazySingleton(() => DuAnNhanVienRepository());
  sl.registerLazySingleton(() => CongViecNhanVienRepository());
  // Provider

  sl.registerLazySingleton(() => ThongBaoRepository());
  sl.registerLazySingleton(() => KhoHangRepository());
  sl.registerLazySingleton(() => BaoCaoNhanVienRepository());
  sl.registerLazySingleton(() => TaiKhoanRepository());
  sl.registerLazySingleton(() => ThuChiNhanVienRepository());
  sl.registerLazySingleton(() => DanhMucSanPhamRepository());

  // Provider
  sl.registerLazySingleton(() => DanhMucTinTucProvider());
  sl.registerLazySingleton(() => DonDichVuProvider());
  sl.registerLazySingleton(() => ThuChiNhanVienProvider());
  sl.registerLazySingleton(() => TinTucProvider());
  sl.registerLazySingleton(() => ThongBaoProvider());
  sl.registerLazySingleton(() => KhoHangProvider());
  sl.registerLazySingleton(() => SanPhamProvider());
  sl.registerLazySingleton(() => CongViecNhanVienProvider());
  sl.registerLazySingleton(() => TaiKhoanProvider());
  sl.registerLazySingleton(() => BaoCaoNhanVienProvider());
  sl.registerLazySingleton(() => ChamCongProvider());
  sl.registerLazySingleton(() => TinhTpProvider());
  sl.registerLazySingleton(() => QuanHuyenProvider());
  sl.registerLazySingleton(() => PhuongXaProvider());
  sl.registerLazySingleton(() => DanhMucSanPhamProvider());
  sl.registerLazySingleton(() => DuAnNhanVienProvider());
}

import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repository/auth_repository.dart';
import 'package:template/data/repository/bang_bang_cap_repository.dart';
import 'package:template/data/repository/bang_gia_dang_tin_repository.dart';
import 'package:template/data/repository/bang_gia_loc_ho_so_repository.dart';
import 'package:template/data/repository/bang_luong_repository.dart';
import 'package:template/data/repository/bao_cao_nhan_vien_repository.dart';
import 'package:template/data/repository/cham_cong_repository.dart';
import 'package:template/data/repository/chi_tiet_don_hang_repository.dart';
import 'package:template/data/repository/chi_tiet_vat_tu_repository.dart';
import 'package:template/data/repository/chuc_vu_repository.dart';
import 'package:template/data/repository/chuyen_mon_repository.dart';
import 'package:template/data/repository/chuyen_nganh_chinh_repository.dart';
import 'package:template/data/repository/cong_viec_nhan_vien_repository.dart';
import 'package:template/data/repository/dang_ky_bao_hiem_repository.dart';
import 'package:template/data/repository/danh_muc_tin_tuc_repository.dart';
import 'package:template/data/repository/dieu_khoan_chinh_sach_repository.dart';
import 'package:template/data/repository/hang_muc_xay_dung_repository.dart';
import 'package:template/data/repository/lien_he_cong_ty_repository.dart';
import 'package:template/data/repository/loai_cong_viec_repository.dart';
import 'package:template/data/repository/nhom_dich_vu_repository.dart';
import 'package:template/data/repository/phuong_xa_repository.dart';
import 'package:template/data/repository/quan_huyen_repository.dart';
import 'package:template/data/repository/thong_tin_f_s_s_repository.dart';
import 'package:template/data/repository/tin_tuc_repository.dart';
import 'package:template/data/repository/tinh_tp_repository.dart';
// import 'package:template/data/repository/auth_repo.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/dang_ky_hop_dong_s_b_s_provider.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';
import 'package:template/provider/dieu_khoan_chinh_sach_provider.dart';
import 'package:template/provider/hang_muc_xay_dung_provider.dart';
import 'package:template/provider/lien_he_cong_ty_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/thong_tin_f_s_s_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
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
import 'package:template/helper/network_info.dart';
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
import 'data/repository/bang_gia_phi_van_chuyen_repository.dart';
import 'provider/phuong_xa_provider.dart';
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
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() =>BangBangCapRepository());
  sl.registerLazySingleton(() => BangGiaDangTinRepository());
  sl.registerLazySingleton(() => BangGiaLocHoSoRepository());
  sl.registerLazySingleton(() => BangGiaPhiVanChuyenRepository());
  sl.registerLazySingleton(() => BangLuongRepository());
  sl.registerLazySingleton(() => BaoCaoNhanVienRepository());
  sl.registerLazySingleton(() => ChamCongRepository());
  sl.registerLazySingleton(() => ChiTietDonHangRepository());
  sl.registerLazySingleton(() => ChiTietVatTuRepository());
  sl.registerLazySingleton(() => ChucVuRepository());
  sl.registerLazySingleton(() => ChuyenMonRepository());
  sl.registerLazySingleton(() => ChuyenNganhChinhRepository());
  sl.registerLazySingleton(() => DangKyBaoHiemRepository());
  sl.registerLazySingleton(() => DangKyHopDongSBSProvider());
  // Tạo đơn công việc
  sl.registerLazySingleton(() => NhomDichVuRepository());
  sl.registerLazySingleton(() => HangMucXayDungRepository());
  sl.registerLazySingleton(()=> LoaiCongViecRepository());
  // Tình thành phố quận huyện
  sl.registerLazySingleton(() => TinhTpRepository());
  sl.registerLazySingleton(() => QuanHuyenRepository());
  sl.registerLazySingleton(() => PhuongXaRepository());
  sl.registerLazySingleton(()=> ThongTinFSSRepository());

  // Provider
  // sl.registerFactory(() => RegionProvider());
  sl.registerFactory(() => AuthProvider());
  // Tạo đơn công việc
  sl.registerFactory(() => NhomDichVuProvider());
  sl.registerFactory(() => HangMucXayDungProvider());
  sl.registerFactory(() => LoaiCongViecProvider());
  sl.registerFactory(() => TinhTpProvider());
  sl.registerFactory(() => QuanHuyenProvider());
  sl.registerFactory(() => PhuongXaProvider());
  sl.registerFactory(() => ThongTinFSSProvider());
  sl.registerFactory(() => DieuKhoanChinhSachProvider());
  sl.registerFactory(() => LienHeCongTyProvider());
  sl.registerLazySingleton(() => SanPhamRepository());
  sl.registerLazySingleton(() => DonDichVuRepository());
  sl.registerLazySingleton(() => ThongBaoRepository());
  sl.registerLazySingleton(() => KhoHangRepository());
  sl.registerLazySingleton(() => TaiKhoanRepository());
  sl.registerLazySingleton(() => DieuKhoanChinhSachRepository());
  sl.registerLazySingleton(() => LienHeCongTyRepository());
  sl.registerLazySingleton(() => ThuChiNhanVienRepository());
  sl.registerLazySingleton(() => CongViecNhanVienRepository());
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
  sl.registerLazySingleton(() => DanhMucSanPhamProvider());
}

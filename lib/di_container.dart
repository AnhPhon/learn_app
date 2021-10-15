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
import 'package:template/data/repository/danh_muc_san_pham_repository.dart';
import 'package:template/data/repository/danh_muc_tin_tuc_repository.dart';
import 'package:template/data/repository/danh_sach_bao_gia_don_dich_vu_repository.dart';
import 'package:template/data/repository/don_dich_vu_repository.dart';
import 'package:template/data/repository/hang_muc_xay_dung_repository.dart';
import 'package:template/data/repository/kho_hang_repository.dart';
import 'package:template/data/repository/loai_cong_viec_repository.dart';
import 'package:template/data/repository/nhom_dich_vu_repository.dart';
import 'package:template/data/repository/phan_hoi_don_dich_vu_repository.dart';
import 'package:template/data/repository/phuong_xa_repository.dart';
import 'package:template/data/repository/quan_huyen_repository.dart';
import 'package:template/data/repository/tai_khoan_repository.dart';
import 'package:template/data/repository/thong_bao_repository.dart';
import 'package:template/data/repository/thu_chi_nhan_vien_repository.dart';
import 'package:template/data/repository/tin_tuc_repository.dart';
import 'package:template/data/repository/tinh_tp_repository.dart';
import 'package:template/data/repository/trang_thai_don_hang_repository.dart';
import 'package:template/data/repository/vat_tu_repository.dart';
import 'package:template/helper/network_info.dart';
import 'package:template/provider/bang_bang_cap_provider.dart';
import 'package:template/provider/bang_gia_dang_tin_provider.dart';
import 'package:template/provider/bang_gia_loc_ho_so_provider.dart';
import 'package:template/provider/bang_gia_phi_van_chuyen_provider.dart';
import 'package:template/provider/bang_luong_provider.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/chi_tiet_don_hang_provider.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/chuc_vu_provider.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/chuyen_nganh_chinh_provider.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/hang_muc_xay_dung_provider.dart';
import 'package:template/provider/kho_hang_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trang_thai_don_hang_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/bang_gia_phi_van_chuyen_repository.dart';
import 'data/repository/tai_khoan_repository.dart';
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
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => BangBangCapRepository());
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
  sl.registerLazySingleton(() => HangMucXayDungRepository());
  sl.registerLazySingleton(() => LoaiCongViecRepository());
  sl.registerLazySingleton(() => NhomDichVuRepository());
  sl.registerLazySingleton(() => TinhTpRepository());
  sl.registerLazySingleton(() => QuanHuyenRepository());
  sl.registerLazySingleton(() => PhuongXaRepository());
  sl.registerLazySingleton(() => TaiKhoanRepository());
  sl.registerLazySingleton(() => DonDichVuRepository());
  sl.registerLazySingleton(() => KhoHangRepository());
  sl.registerLazySingleton(() => ThuChiNhanVienRepository());
  sl.registerLazySingleton(() => ThongBaoRepository());
  sl.registerLazySingleton(() => CongViecNhanVienRepository());
  sl.registerLazySingleton(() => DanhMucSanPhamRepository());
  sl.registerLazySingleton(() => PhanHoiDonDichVuRepository());
  sl.registerLazySingleton(() => TrangThaiDonHangRepository());
  sl.registerLazySingleton(() => VatTuRepository());
  sl.registerLazySingleton(() => DanhSachBaoGiaDonDichVuRepository());

  // Provider
  sl.registerLazySingleton(() => BangBangCapProvider());
  sl.registerLazySingleton(() => BangGiaDangTinProvider());
  sl.registerLazySingleton(() => BangGiaLocHoSoProvider());
  sl.registerLazySingleton(() => BangGiaPhiVanChuyenProvider());
  sl.registerLazySingleton(() => BangLuongProvider());
  sl.registerLazySingleton(() => BaoCaoNhanVienProvider());
  sl.registerLazySingleton(() => ChamCongProvider());
  sl.registerLazySingleton(() => ChiTietDonHangProvider());
  sl.registerLazySingleton(() => ChiTietVatTuProvider());
  sl.registerLazySingleton(() => ChucVuProvider());
  sl.registerLazySingleton(() => ChuyenMonProvider());
  sl.registerLazySingleton(() => ChuyenNganhChinhProvider());
  sl.registerLazySingleton(() => DangKyBaoHiemProvider());
  sl.registerLazySingleton(() => HangMucXayDungProvider());
  sl.registerLazySingleton(() => LoaiCongViecProvider());
  sl.registerLazySingleton(() => NhomDichVuProvider());
  sl.registerLazySingleton(() => TinhTpProvider());
  sl.registerLazySingleton(() => QuanHuyenProvider());
  sl.registerLazySingleton(() => PhuongXaProvider());
  sl.registerLazySingleton(() => TaiKhoanProvider());
  sl.registerLazySingleton(() => DonDichVuProvider());
  sl.registerLazySingleton(() => KhoHangProvider());
  sl.registerLazySingleton(() => ThuChiNhanVienProvider());
  sl.registerLazySingleton(() => ThongBaoProvider());
  sl.registerLazySingleton(() => CongViecNhanVienProvider());
  sl.registerLazySingleton(() => DanhMucSanPhamProvider());
  sl.registerLazySingleton(() => PhanHoiDonDichVuProvider());
  sl.registerLazySingleton(() => TrangThaiDonHangProvider());
  sl.registerLazySingleton(() => VatTuProvider());
  sl.registerLazySingleton(() => DanhSachBaoGiaDonDichVuProvider());
}

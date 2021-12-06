import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_hop_dong_s_b_s_provider.dart';
import 'package:template/provider/dang_ky_thue_provider.dart';
import 'package:template/provider/giay_chung_nhan_suc_khoe_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2FinishUpdateController extends GetxController {
  // provider
  DangKyThueProvider dangKyThueProvider = GetIt.I.get<DangKyThueProvider>();
  DangKyBaoHiemProvider dangKyBaoHiemProvider =
      GetIt.I.get<DangKyBaoHiemProvider>();
  DangKyHopDongSBSProvider dangKyHopDongSBSProvider =
      GetIt.I.get<DangKyHopDongSBSProvider>();
  GiayChungNhanSucKhoeProvider giayChungNhanSucKhoeProvider =
      GetIt.I.get<GiayChungNhanSucKhoeProvider>();
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  RefreshController? refreshController;

  String title = "Bạn cần hoàn thiện hồ sơ";

  bool maSoThueValid = false;
  bool dangKyValid = false;
  bool camKetValid = false;
  bool hopDongValid = false;
  bool baoHiemValid = false;
  bool chungNhanValid = false;
  bool sanPhamMauValid = false;
  bool bangGiaValid = false;
  bool capNhatThongTinCuaHangValid = false;
  bool capNhatHinhAnhCuaHangValid = false;

  bool isLoading = true;

  String loaiTaiKhoan = "6168fb3062f385255f293b0b";

  @override
  void onInit() {
    super.onInit();

    // get loai tai khoan
    loaiTaiKhoan = Get.arguments.toString();

    // init refreshController
    refreshController ??= RefreshController();

    // program initialize
    programInit();
  }

  ///
  /// program init
  ///
  void programInit() {
    sl.get<SharedPreferenceHelper>().userId.then((idUser) {
      // dang ky thue
      dangKyThue(idUser!);

      // dang ky fss
      dangKyFSS(idUser);

      // dang ky bao hiem tai nan
      dangKyBaoHiemTaiNan(idUser);

      // chứng nhận sức khỏe
      chungNhanSucKhoe(idUser);

      // cập nhật thông tin và hình ảnh cửa hàng
      onCapNhatThongTinCheck(idUser);
    });
  }

  ///
  /// đăng ký thuế
  ///
  void dangKyThue(String id) {
    dangKyValid = false;
    camKetValid = false;
    dangKyThueProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // chi đăng ký thuế hợp lệ
            if (model.trangThai == '1' && model.loai == '1') {
              dangKyValid = true;
              update();
            }

            // cả đăng ký và cam kết thuế hợp lệ
            if (model.trangThai == '1' && model.loai == '2') {
              camKetValid = true;
              dangKyValid = true;
              update();
            }
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// đăng ký fss
  ///
  void dangKyFSS(String id) {
    hopDongValid = false;
    dangKyHopDongSBSProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // đăng ký hợp đồng SBS
            if (model.trangThai == '1') {
              hopDongValid = true;
              update();
              break;
            }
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// đăng ký bảo hiểm tai nạn
  ///
  void dangKyBaoHiemTaiNan(String id) {
    baoHiemValid = false;
    dangKyBaoHiemProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // đăng ký bảo hiểm
            if (model.idBaoHiem != null) {
              if (model.idBaoHiem!.loai.toString() == '1') {
                baoHiemValid = true;
                update();
                break;
              }
            }
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// chúng nhận sức khỏe
  ///
  void chungNhanSucKhoe(String id) {
    chungNhanValid = false;
    giayChungNhanSucKhoeProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // giấy chừng nhận sức khỏe
            if (model.trangThai == '1') {
              chungNhanValid = true;
              update();
              break;
            }
          }
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// check cập nhật thông tin
  ///
  void onCapNhatThongTinCheck(String id) {
    capNhatHinhAnhCuaHangValid = false;
    capNhatThongTinCuaHangValid = false;
    taiKhoanProvider.find(
      id: id,
      onSuccess: (data) {
        if (data.hoTen != null &&
            data.tenPhapLy != null &&
            data.soDienThoai != null &&
            data.email != null &&
            data.idNhomCuaHang != null &&
            data.idMatHangDacTrungs != null &&
            data.diaDiemCuThe != null &&
            data.thoiGianLamViec != null &&
            data.lamChieuThuBay != null &&
            data.lamNgayChuNhat != null) {
          if (data.hoTen.toString().trim().isNotEmpty &&
              data.tenPhapLy.toString().trim().isNotEmpty &&
              data.soDienThoai.toString().trim().isNotEmpty &&
              data.email.toString().trim().isNotEmpty &&
              data.idNhomCuaHang.toString().trim().isNotEmpty &&
              data.idMatHangDacTrungs.toString().trim().isNotEmpty &&
              data.diaDiemCuThe.toString().trim().isNotEmpty &&
              data.thoiGianLamViec.toString().trim().isNotEmpty &&
              data.lamChieuThuBay.toString().trim().isNotEmpty &&
              data.lamNgayChuNhat.toString().trim().isNotEmpty) {
            capNhatThongTinCuaHangValid = true;
          }
          update();
        }
        if (data.hinhAnhCuaHangs != null) {
          if (data.hinhAnhCuaHangs!.isNotEmpty) {
            capNhatHinhAnhCuaHangValid = true;
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// on dang ky va cam ket click
  ///
  void onDangKyClick() {
    Get.toNamed(AppRoutes.V2_TAX_REGISTER);
  }

  ///
  /// on dang ky va cam ket click
  ///
  void onHoSoClick() {
    Get.toNamed(AppRoutes.V2_TAX);
  }

  ///
  /// on dang ky va cam ket click
  ///
  void onCamKetClick() {
    Get.toNamed(AppRoutes.V2_TAX_REGISTER, arguments: 2);
  }

  ///
  /// on dang ky hợp đồng click
  ///
  void onDangKyHopDongClick() {
    Get.toNamed(AppRoutes.V1_CONTRACT);
  }

  ///
  /// on Bao Hiem Tai Nan Click
  ///
  void onBaoHiemTaiNanClick() {
    Get.toNamed(AppRoutes.V1_ACCIDENT_INSURANCE, arguments: true);
  }

  ///
  /// on Giay Chung Nhan Kham Suc Khoe Click
  ///
  void onGiayChungNhanKhamSucKhoeClick() {
    Get.toNamed(AppRoutes.V2_SAFETY_PAPER);
  }

  ///
  /// on Cap Nhat San Pham Click
  ///
  void onCapNhatSanPhamClick() {}

  ///
  /// on Cập nhập bảng báo giá dịch vụ Click
  ///
  void onCapNhatBangBaoGiaClick() {}

  ///
  /// on cap nhat thong tin cua hang Click
  ///
  void onCapNhatThongTinCuaHangClick() {
    Get.toNamed(AppRoutes.V3_STORE_INFOMATION);
  }

  ///
  /// on cap nhat hinh anh cua hàng Click
  ///
  void onCapNhatHinhAnhCuaHangClick() {
    Get.toNamed(AppRoutes.V3_STORE_INFOMATION);
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    programInit();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController!.loadComplete();
  }
}

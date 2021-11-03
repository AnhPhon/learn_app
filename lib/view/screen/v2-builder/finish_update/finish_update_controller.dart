import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_hop_dong_s_b_s_provider.dart';
import 'package:template/provider/dang_ky_thue_provider.dart';
import 'package:template/provider/giay_chung_nhan_suc_khoe_provider.dart';
import 'package:template/routes/app_routes.dart';
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

  String title = "Bạn cần hoàn thiện hồ sơ";

  bool thueValid = false;
  bool maSoThueValid = false;
  bool camKetValid = false;
  bool hopDongValid = false;
  bool baoHiemValid = false;
  bool chungNhanValid = false;
  bool sanPhamMauValid = false;
  bool bangGiaValid = false;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

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
    });
  }

  ///
  /// đăng ký thuế
  ///
  void dangKyThue(String id) {
    dangKyThueProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1' && models[0].loai == '1') {
            thueValid = true;
            update();
          }

          if (models[0].trangThai == '1' && models[0].loai == '2') {
            thueValid = true;
            maSoThueValid = true;
            camKetValid = true;
            update();
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
    dangKyHopDongSBSProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            hopDongValid = true;
            update();
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
    dangKyBaoHiemProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            baoHiemValid = true;
            update();
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
    giayChungNhanSucKhoeProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            chungNhanValid = true;
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
  /// on dang ky va cam ket click
  ///
  void onDangKyVaCamKetClick() {
    Get.toNamed(AppRoutes.V1_TAX);
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
    Get.toNamed(AppRoutes.V1_ACCIDENT_INSURANCE);
  }

  ///
  /// on Giay Chung Nhan Kham Suc Khoe Click
  ///
  void onGiayChungNhanKhamSucKhoeClick() {}

  ///
  /// on Cap Nhat San Pham Click
  ///
  void onCapNhatSanPhamClick() {}

  ///
  /// on Cập nhập bảng báo giá dịch vụ Click
  ///
  void onCapNhatBangBaoGiaClick() {}
}

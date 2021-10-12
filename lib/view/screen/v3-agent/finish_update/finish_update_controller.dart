import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3FinishUpdateController extends GetxController {
  String title = "Bạn cần hoàn thiện hồ sơ";

  ///
  /// on dang ky va cam ket click
  ///
  void onDangKyVaCamKetClick() {
    Get.toNamed(AppRoutes.V2_REGISTER_AND_COMMIT);
  }

  ///
  /// on dang ky hợp đồng click
  ///
  void onDangKyHopDongClick() {
  }

  ///
  /// on Bao Hiem Tai Nan Click
  ///
  void onBaoHiemTaiNanClick() {
  }
  
  ///
  /// on Giay Chung Nhan Kham Suc Khoe Click
  ///
  void onGiayChungNhanKhamSucKhoeClick() {
  }

  ///
  /// on Ma So Thue Click
  ///
  void onMaSoThueClick() {
  }

  ///
  /// on Cap Nhat San Pham Click
  ///
  void onCapNhatSanPhamClick() {
  }
}

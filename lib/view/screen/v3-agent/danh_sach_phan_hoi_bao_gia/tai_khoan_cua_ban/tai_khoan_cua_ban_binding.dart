import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/tai_khoan_cua_ban/tai_khoan_cua_ban_controller.dart';

class V3TaiKhoanCuaBanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3TaiKhoanCuaBanController());
  }
}

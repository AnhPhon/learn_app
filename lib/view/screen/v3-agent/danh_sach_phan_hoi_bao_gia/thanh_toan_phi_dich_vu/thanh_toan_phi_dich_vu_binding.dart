import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thanh_toan_phi_dich_vu/thanh_toan_phi_dich_vu_controller.dart';

class V3ThanhToanPhiDichVuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3ThanhToanPhiDichVuController());
  }
}

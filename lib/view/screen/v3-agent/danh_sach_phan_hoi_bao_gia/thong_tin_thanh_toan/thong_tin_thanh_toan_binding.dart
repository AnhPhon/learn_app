import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thong_tin_thanh_toan/thong_tin_thanh_toan_controller.dart';

class V3ThongTinThanhToanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3ThongTinThanhToanController());
  }
}

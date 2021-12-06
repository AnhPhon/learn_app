import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thong_bao_thanh_cong/thong_bao_thanh_cong_controller.dart';

class V3ThongBaoThanhCongBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3ThongBaoThanhCongController());
  }
}

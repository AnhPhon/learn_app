import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/chua_phan_hoi/chua_phan_hoi_controller.dart';

class V3ChuaPhanHoiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3ChuaPhanHoiController());
  }
}

import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/quote_phan_hoi_bao_gia_controller.dart';

class V3QuotePhanHoiBaoGiaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3QuotePhanHoiBaoGiaController());
  }
}

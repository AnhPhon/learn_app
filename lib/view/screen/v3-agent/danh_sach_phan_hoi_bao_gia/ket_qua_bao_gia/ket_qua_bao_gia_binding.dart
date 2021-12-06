import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/ket_qua_bao_gia/ket_qua_bao_gia_controller.dart';

class V3KetQuaBaoGiaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3KetQuaBaoGiaController());
  }
}

import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thong_tin_khach_hang/thong_tin_khach_hang_controller.dart';

class V3ThongTinKhachHangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => V3ThongTinKhachHangController());
  }
}

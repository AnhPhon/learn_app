import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/tai_khoan_provider.dart';

class V3ThongBaoThanhCongController extends GetxController
    with SingleGetTickerProviderMixin {
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  String title = "Thông báo thành công";

  bool isLoading = true;

  ///
  /// on xac nhan Click
  ///
  void onXacNhanClick() {
    Get.back(result: true);
    Get.back(result: true);
    Get.back(result: true);
    Get.back(result: true);
  }
}

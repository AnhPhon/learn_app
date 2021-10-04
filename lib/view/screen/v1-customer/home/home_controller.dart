import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1HomeController extends GetxController {
  ///
  /// tới trang quản lý đơn tạo
  ///
  void onClickFormManagementPage() {
    Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
  }
}

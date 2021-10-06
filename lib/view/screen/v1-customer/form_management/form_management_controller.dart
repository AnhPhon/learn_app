import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1FormManagementController extends GetxController {
  String title = "Quản lý đơn tạo";

  Map<String, String> titleTabBar = {
    "DPH": "Đã phản hồi",
    "CPH": "Chưa phản hồi",
  };
  int currentIndex = 0;

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// go to Product Response
  ///
  void onProductResponseClick() {
    Get.toNamed(AppRoutes.V1_PRODUCT_RESPONSE);
  }
}

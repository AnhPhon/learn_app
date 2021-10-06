import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1FormListController extends GetxController {
  String title = "Danh sách đơn tạo";

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
  ///go to job detail
  ///
  void onJobDetailClick() {
    Get.toNamed(AppRoutes.V1_JOB_DETAIL);
  }
}

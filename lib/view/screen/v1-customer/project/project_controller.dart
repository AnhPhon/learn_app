import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1ProjectController extends GetxController {
  String title = "Dự án";

  List titleTabBar = [
    "Dự án đang triển khai",
    "Dự án đã triển khai",
  ];

  int currentIndex = 0;

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  ///on project detail click
  ///
  void onProjectDetailClick() {
    Get.toNamed(AppRoutes.V1_PROJECT_DETAIL);
  }
}

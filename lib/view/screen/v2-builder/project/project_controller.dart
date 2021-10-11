import 'package:get/get.dart';

class V2ProjectController extends GetxController {
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
  // void onProjectDetailClick() {
  //   Get.toNamed(AppRoutes.V2_PROJECT_DETAIL);
  // }
}

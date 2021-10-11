import 'package:get/get.dart';

class V4DashboardController extends GetxController {
  int tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}

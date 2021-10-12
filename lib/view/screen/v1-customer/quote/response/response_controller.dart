import 'package:get/get.dart';

class V1ResponseController extends GetxController {
  String title = "Phản hồi đơn giá vật tư";

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
  }
}

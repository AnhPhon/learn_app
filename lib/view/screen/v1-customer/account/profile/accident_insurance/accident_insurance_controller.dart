import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1AccidentInsuranceController extends GetxController {
  String title = "Bảo hiểm tai nạn";

  Map<String, String> titleTabBar = {
    "GT": "Giới thiệu",
    "QL": "Quyền lợi",
    "BT": "Bồi thường",
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
  ///on register click
  ///
  void onRegisterClick() {
    Get.toNamed(AppRoutes.V1_INURANCE_REGISTER);
  }

  ///
  ///on your insurance click
  ///
  void onYourInsurancePageClick() {
    Get.toNamed(AppRoutes.V1_YOUR_INSURANCE);
  }
}

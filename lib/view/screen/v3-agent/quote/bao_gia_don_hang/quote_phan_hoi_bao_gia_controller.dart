import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';


class V3QuotePhanHoiBaoGiaController extends GetxController {
  String title = "Danh sách phản hồi đơn giá";
  

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
  void onProductResponseClick() {}

  ///
  /// go to reponse page
  ///
  void toReponse() {
    Get.toNamed(AppRoutes.V3_QUOTE_RESPONSE);
  }
}

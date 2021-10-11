import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup3Controller extends GetxController {
  String title = "Công việc đang cần người";

  ///
  ///accept
  ///
  void onAcceptClick() {
    Get.toNamed(AppRoutes.V2_WINNING_BID);
  }
}

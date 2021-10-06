import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1ProductResponseController extends GetxController {
  String title = "Phản hồi đơn hàng";

  ///
  ///on accept click
  ///
  void onAcceptClick() {
    Get.toNamed(AppRoutes.V1_BILL_DETAIL);
  }
}

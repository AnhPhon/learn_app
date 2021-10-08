import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3PaymentSuccessController extends GetxController {
  String title = "Thông báo thành công";

  ///
  ///go to home
  ///
  void onCompleteClick() {
    Get.toNamed(AppRoutes.V3_DASHBOARD);
  }
}

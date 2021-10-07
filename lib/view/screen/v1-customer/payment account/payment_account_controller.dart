import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1PaymentAccountController extends GetxController {
  String title = "Tài khoản của bạn";

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    Get.toNamed(AppRoutes.V1_PAYMENT_SUCCESS);
  }

  ///
  ///go to recharge
  ///
  void onRechargeClick() {
    Get.toNamed(AppRoutes.V1_RECHARGE);
  }
}
